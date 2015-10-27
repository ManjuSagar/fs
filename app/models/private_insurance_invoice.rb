class PrivateInsuranceInvoice < ActiveRecord::Base
  include UsersHelper
  include ClaimReportRelatedMethods
  include ActionView::Helpers::NumberHelper
  include AASM
  self.table_name = 'invoices'

  has_many :private_receivables, :foreign_key => :invoice_id
  belongs_to :org
  belongs_to :payer, :polymorphic => true
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :treatment_episode
  belongs_to :invoice_package
  before_create :assign_org

  audited :associated_with => :treatment_episode, :allow_mass_assignment => true


  scope :org_scope, lambda{ where(:org_id => Org.current.id) }
  scope :ins_scope, lambda{org_scope.where("payer_id in (select id from insurance_companies where billing_flow = 'V')")}

  attr_accessor :system_driven_event, :receivables_for_print, :line_items, :insurance

  STATE_MAP = {:sent => 'S', :received => 'C'}

  aasm :column => :invoice_status do
    state :sent, :initial => true
    state :received

    event :mark_as_received do
      transitions :to => :received, :from => :sent, :guard => :current_user_is_consultant_or_ha_not_associated_with_consultant?
    end

    event :undo do
      transitions :to => :sent, :from => :received, :guard => :all_items_are_not_sent?
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :invoice_status
    write_attribute_without_mapping(attr, v)
  end

  def invoice_status
    STATE_MAP.invert[read_attribute(:invoice_status)]
  end

  def current_user_is_consultant_or_ha_not_associated_with_consultant?
    (current_user_is_consultant? or ha_not_associated_with_consultant?)
  end

  def all_items_are_not_sent?
    receivables = receivables || line_items
    receivables.all?{|r| r.sent? == false }
  end

  def billed_amount
    receivables = receivables || line_items
    receivables.map(&:receivable_amount).sum
  end

  def self.create_invoice_group_by_insurance_company(params)
    receivables_group_by_insurance_company = PrivateReceivable.org_scope.find(params[:record_ids]).group_by(&:payer)
    receivables_group_by_insurance_company.each do |ins_id, receivables|
      receivables_group_by_patient = receivables.group_by{|r| r.treatment.patient_id}
      receivables_group_by_patient.each{|patient_id, receivables|
        amount = receivables.map(&:receivable_amount).sum
        invoice = self.create_invoice(receivables, params[:date], amount, ins_id)
      }
      self.create_invoice_package_number(receivables, ins_id, 'sent')
      self.update_receivable_package_number(receivables, ins_id)
    end

  end


  def self.create_invoice(receivables, date, amount, ins_id)
    receivable = receivables.first
    invoice = self.create(invoice_number: Invoice.next_invoice_number, invoice_date: Date.current,
                              payer_type: receivable.payer_type, payer_id: receivable.payer_id, invoice_amount: amount,
                              sent_date: date, invoice_type: '323', treatment: receivable.treatment, treatment_episode: receivable.treatment_episode)
    update_receivable_status(receivables, invoice, ins_id)
    invoice.private_receivables << receivables
    invoice
  end

  def self.update_receivable_status(receivables, invoice, payer)
    payment_due_date = invoice.sent_date + payer.claim_payment_due_days
    receivables.each{ |receivable|
      receivable.receivable_status_change_for_sent_event
      receivable.update_attributes!(private_insurance_invoice: invoice, payment_due_date: payment_due_date)
    }
  end

  def self.update_receivable_package_number(receivables, ins)
    receivables.each{|receivable|
      package = InvoicePackage.org_scope.where({insurance_company_id: ins.id}).last
      receivable.update_attributes({invoice_package_id: package.id})
    }
  end

  def invoice_date_display
    res = self.invoice_date || Date.current
    res.strftime("%m%d%y")
  end

  def poc_document
    episode.plan_of_care_document
  end


  def oasis_doc

    episode = self.treatment_episode || line_items.first.source.treatment_episode
    episode.oasis_evaluation_or_recertification_or_roc_document
  end

  def oasis_document
    oasis_doc
  end

  def episode
    self.treatment_episode ||= line_items.first.source.treatment_episode
  end

  def calender_year
    if Invoice::INVOICE_TYPES[invoice_type] == "RAP"
      episode.start_date.year
    else
      episode.end_date.year
    end
  end

  def get_the_visits_by_discipline(discipline_code)
    discipline = get_discipline(discipline_code)
    episode.completed_visits.where(discipline_id: discipline)
  end

  def patient
    treatment.patient
  end

  def primary_physician_first_name
    patinet_treatment.primary_physician.first_name
  end

  def primary_physician_last_name
    patinet_treatment.primary_physician.last_name
  end

  def primary_physician_middle_initials
    patinet_treatment.primary_physician.middle_initials
  end

  def primary_physician_npi
    patinet_treatment.primary_physician.npi_number
  end

  def patinet_treatment
    self.treatment ||= line_items.first.treatment
  end

  def patient_last_name
    patient.last_name
  end

  def patient_first_name
    patient.first_name
  end

  def patient_hi_claim_number
    patient.patient_insurance_companies.first.patient_insurance_number
  end

  def patient_dob_century_format
    dob = if oasis_doc.present?
            Date.strptime(oasis_doc.m0066_pat_birth_dt, "%m/%d/%Y")
          else
            patient.dob
          end
    dob.strftime("%Y%m%d")
  end

  def final_claim?
    false
  end

  def lupa?
    false
  end

  def patient_control_number
    "#{patient.patient_reference} - #{self.invoice_number}" if patient
  end

  def final_or_lupa_bill?
    false
  end

  def partial_episode_date
    activity = patinet_treatment.treatment_activities.reorder("id DESC").detect{|a| a.activity_type == TreatmentActivity::DISCHARGE}
    activity.activity_date if TreatmentActivity::DISCHARGE_REASON_CODES.include? activity.activity_reason_code
  end

  def src
    self.treatment.src
  end

  def get_through_date
    return  episode.start_date
    if episode.is_recertified?
      episode.end_date
    else
      date = partial_episode_date
      date ? date : (raise 'Activity Reason code is blank')
    end
  end

  def provider_number
    insurance_company.payer_id
  end

  def status_of_discharge
    episode = self.treatment_episode if episode.nil?
    if (episode.is_recertified?)
      "30"
    else
      discharges = patinet_treatment.treatment_activities.where(["activity_type = ? and activity_reason_code is not null", "D"])
      discharges.last.activity_reason_code if discharges.size > 0
    end
  end

  def treatment_authorization_codes
    episode = self.treatment_episode if episode.nil?
    episode.treatment_authorization
  end

  def prior_payment
    "0.00"
  end

  def patient_relationship
    patinet_treatment.treatment_request.patient_relation_to_insured
  end

  def invoice_type
    invoice_type ||= "323"
  end

  def insurance_company
    (payer.present? ? payer : insurance)
  end

  def payer_full_name
    insurance_company.company_name if insurance_company.present?
  end

  def payer_address1
    if insurance_company.claim_suite_number.present?
      "Suite " + insurance_company.claim_suite_number
    else
      insurance_company.claim_street_address unless insurance_company.claim_street_address.blank?
    end
  end

  def payer_address2
    if insurance_company.claim_suite_number.blank?
      nil
    else
      insurance_company.claim_street_address unless insurance_company.claim_street_address.blank?
    end
  end

  def payer_city_details
    payer_location = []
    payer_location << insurance_company.claim_city unless insurance_company.claim_city.blank?
    payer_location << ["#{insurance_company.claim_state} #{insurance_company.claim_zip_code}"].reject{|x| x.blank?}
    payer_location.join(", ")
  end

  def payer_name
    (insurance_company.is_a? User) ? insurance_company.full_name : insurance_company.company_name if insurance_company.present?
  end

  def payer_street_address
    payer_street = []
    payer_street << insurance_company.claim_street_address unless insurance_company.claim_street_address.blank?
    payer_street << "Suite " + insurance_company.claim_suite_number unless insurance_company.claim_suite_number.blank?
    payer_street.join(", ")
  end


  def payer_contact
    ("Claim Inquiry " + insurance_company.claim_phone_number) if insurance_company.claim_phone_number
  end

  def priority_of_visit
    "2"
  end


  def home_health_service
    nil
  end

  def receivables
    res = line_items
    return res unless self.receivables_for_print
    number_of_receivables = res.size
    blank_receivables = (number_of_receivables % 21)
    (21 - blank_receivables).times{|i| res << PrivateReceivable.new(:receivable_date => "", :private_insurance_invoice => PrivateInsuranceInvoice.new) }
    res
  end

  def total_service_units
    line_items.map(&:service_units).compact.sum
  end

  def total_amount
    line_items.map(&:receivable_amount).compact.sum
  end

  def total_amount_for_edi
    line_items = self.private_receivables
    line_items.map(&:receivable_amount).compact.sum
  end

  def print_claims(params)
    claims = params[:selected_claims]
    pdfs_list = []
    claims_group_by_ins = PrivateReceivable.group_by_payer(claims, params[:status]).group_by{|x| [x.payer, x.invoice_package]}
    claims_group_by_ins.each{|ins, receivables|
      pdfs_list << get_print_url_by_filters(params, ins, receivables)
    }
    res = if pdfs_list.flatten.compact.present?
      combine_reports(pdfs_list)
    else
      nil
    end
  end


  def get_print_url_by_filters(params, ins, receivables)
    total_list = []
    cover_sheet = []
    list = []
    patients = receivables.group_by{|x| [x.treatment.patient_id, x.private_insurance_invoice]}
    if params[:form_required] or params[:doc_required]
      res = get_the_forms_and_documents(patients, list, params, ins)
      total_list << res if res.flatten.compact.present?
    else
      total_list << list
    end
    package_count =(total_list.flatten.compact).collect{|p| PDF::Reader.new(p).page_count}.sum if total_list.flatten.compact.present?
    cover_sheet << get_cover_sheet(ins, receivables, package_count, params[:action]) if params[:inv_required]
    [cover_sheet, total_list]
  end

  def get_cover_sheet(insurance, claims, package_count, action)
    ReportDataSource::PrivateInsuranceCoverSheet.new(insurance, claims, package_count, action).to_pdf
  end

  def self.create_invoice_package_number(receivables, insurance, action)
    if action == 'sent'
      org = insurance.org
      invoice_package = InvoicePackage.org_scope.last
      package_number = invoice_package.present? ? invoice_package.package_number.to_i + 1 : 1      
      InvoicePackage.create!({insurance_company_id: insurance.id, package_number: package_number,
                                org_id: org.id})     
    end
  end

  def get_ub04_or_cms_1500(ins, invoice)
    return unless ins.claim_form_type.present?
    if ins.claim_form_type == "U"
      ReportDataSource::MedicareClaim.new(invoice).to_pdf
    elsif ins.claim_form_type == "C"
      ReportDataSource::Cms1500Print.new(invoice).to_pdf
    end
  end

  def get_documents_url(claims, list)
    claims = claims.select{|x| x.id.present?}
    claims.each do |x|
      docs = x.source.documents
      docs.each do |x|
        list << x.to_pdf
        list << x.tinetti_pdf if x.is_a? PTEvaluation and x.tinetti_fields_entered?
        list << x.wound_pdf if x.is_a? SNEvaluation and x.wound_values_entered?
      end
    end
  end

  def get_the_forms_and_documents(patients, list, params, ins)
    patients.each do |patient, claims|
      invoice = patient.last || Org.current.private_insurance_invoices.build
      invoice.line_items = claims
      invoice.insurance = ins.first
      invoice.treatment_episode = claims.first.treatment_episode
      invoice.treatment = claims.first.treatment
      list << get_ub04_or_cms_1500(ins.first, invoice) if params[:form_required]
      if params[:doc_required]
        get_documents_url(claims, list)
      end
    end
    list
  end

  def combine_reports(list_of_pdfs)
    list_of_pdfs = list_of_pdfs.flatten.compact
    combined_pdf_file = "#{tempfile}.pdf"
    require 'pdf_merger'
    PdfMerger.new.merge(list_of_pdfs, combined_pdf_file)
    combined_pdf_file
  end

  def self.get_edi_url_and_claims_mark_as_sent(approved_claims, params, private_receivables)
    mode_char = (params[:test_mode] == 'T' ? 'T' : 'P')
    url = Generate837Edi.new(approved_claims, mode_char, private_receivables).construct_edi_file
    errors_present = (url.is_a? Array)
    [errors_present, url]
  end

  private

  def assign_org
    self.org ||= Org.current
  end


end