# == Schema Information
#
# Table name: invoices
#
#  id                  :integer          not null, primary key
#  invoice_number      :integer          not null
#  invoice_date        :date             not null
#  org_id              :integer          not null
#  payer_type          :string(255)      not null
#  payer_id            :integer          not null
#  invoice_amount      :decimal(8, 2)    not null
#  invoice_status      :string(1)        not null
#  invoice_description :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'jasper-rails'
class Invoice < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include JasperRails
  include UsersHelper
  include ClaimReportRelatedMethods

  has_many :receivables, :dependent => :destroy
  has_many :invoice_payments, :dependent => :destroy
  has_many :medicare_remittance_claims
  has_many :medicare_remittances, :through => :medicare_remittance_claims
  has_many :medicare_claim_transmission_logs
  belongs_to :org
  belongs_to :payer, :polymorphic => true
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :treatment_episode

  audited :associated_with => :treatment_episode, :allow_mass_assignment => true

  after_destroy :update_episode_medicare_bill_status, :unless => :new_record?
  scope :not_pending_scope, lambda{org_scope.where(["invoice_type IN (?)",['322', '329', '327']])}
  #default_scope lambda {order("invoices.id DESC")}
  scope :org_scope, lambda{ where(:org_id => Org.current.id) }
  scope :consultant_scope, -> { where(["invoice_status in (?) AND org_id IN (SELECT ccha.health_agency_id FROM
                        consulting_company_health_agencies ccha where ccha.consulting_company_id IN (SELECT ou.org_id
                        FROM org_users ou WHERE ou.user_id = ?))", ['A', 'S','N','E'], User.current.id])}

  scope :claims_status_scope, lambda{|claim_ids, status| org_scope.where(["id in (?) and invoice_status in (?)", claim_ids, status])}
  scope :approved_claims, lambda{org_scope.where(["invoice_status in (?)", "A"])}
  scope :claims_ready_for_send, lambda{org_scope.where(["invoice_status in (?)", "N"])}
  scope :approved_claims_not_edi_generation_failure, lambda{claims_ready_for_send.where("transmission_status is null")}
  scope :pending_transmission_org_specific, lambda{org_scope.where(["transmission_status in (?)", ["pending_trn", "pending_ta1", "pending_999", "pending_277"]])}
  scope :pending_transmission, lambda{where(["transmission_status in (?)", ["pending_trn", "pending_ta1", "pending_999", "pending_277"]])}


  attr_accessor :aged
  netzke_attribute :aged

  FINAL = "329"
  LUPA = "327"

  INVOICE_TYPES = {"R" => "Pending", "322" => "RAP", "329" => "Final", "327" => "LUPA"}
  NRS_NUMBER = {"S" => "1", "T" => "2", "U" => "3", "V" => "4", "W" => "5", "X" => "6"}
  TYPE_STORE = INVOICE_TYPES.reject{|k, v| k == "R"}.collect{|k,v| [k.to_s, v.to_s]}.unshift(["", "---"])
  include AASM
  STATE_MAP = {:draft => 'D', :approved => 'A', :sent => 'S', :paid => 'P', :esend_failed => 'F', :esent => 'E',
               :ready_for_esend => 'N', :partially_paid => "R", :denied => 'I', :esend_in_progress => 'O'}

  STATUS_STORE = STATE_MAP.reject{|k, v| k == :ready_for_esend}.collect{|k,v| [v.to_s, k.to_s.titleize]}.unshift(["", "---"])
  STATUS_STORE_FOR_CONSULTANT = [["", "---"], ["A", "Approved"], ["S", "Sent"], ["E", "ESent"]]
  TYPE_STORE_FOR_CONSULTANT = [["", "---"], ["322", "RAP"], ["327", "LUPA"], ["329", "Final"]]
  TRANSMISSION_STATUS = ["---", "accepted", "rejected", "edi_generation_failure", "pending_trn", "pending_ta1", "pending_999", "pending_277"]
  GENDER = {1 => "M", 2 => "F"}

  store :additional_fields, accessors: [:approved_date, :paid_date, :invoice_sent_date, :partially_paid_date,
                                        :denied_date, :esent_date, :esend_failed_date, :ready_for_esend_date, :esend_in_progress_date]

  aasm :column => :invoice_status do
    state :draft, :initial => true, before_enter: :reset_transmission_status
    state :approved, before_enter: :reset_sent_date
    state :sent
    state :esent
    state :esend_in_progress
    state :esend_failed
    state :paid
    state :partially_paid
    state :denied
    state :ready_for_esend

    event :approve, after: :update_status_date  do
      transitions :to => :approved, :from => :draft
    end

    event :mark_as_sent, after: :update_status_date  do
      transitions :to => :sent, :from => :approved, :guard => :current_user_is_consultant_or_ha_not_associated_with_consultant?
    end

    event :mark_as_esent, :hidden => true, after: :update_status_date  do
      transitions :to => :esent, :from => :esend_in_progress, :guard => :current_user_is_consultant_or_ha_not_associated_with_consultant?
    end

    event :mark_as_esend_in_progress, :hidden => true, after: :update_status_date  do
      transitions :to => :esend_in_progress, :from => :ready_for_esend, :guard => :current_user_is_consultant_or_ha_not_associated_with_consultant?
    end

    event :mark_as_ready_for_esend, :hidden => true, after: :update_status_date  do
      transitions :to => :ready_for_esend, :from => :approved, :guard => :current_user_is_consultant_or_ha_not_associated_with_consultant?
    end

    event :mark_as_esend_failed, after: :update_status_date  do
      transitions :to => :esend_failed, :from => :esend_in_progress, :guard => :is_claim_transmission_failure
    end

    event :pay, after: :update_status_date do
      transitions :to => :paid, :from => :sent, :guard => :all_items_are_paid_and_system_driven_event?
      transitions :to => :partially_paid, :from => :sent, :guard => :not_all_items_are_paid_and_system_driven_event?
      transitions :to => :paid, :from => :partially_paid, :guard => :all_items_are_paid_and_system_driven_event?
      transitions :to => :partially_paid, :from => :partially_paid, :guard => :not_all_items_are_paid_and_system_driven_event?
    end

    event :undo, after: :update_status_date_for_undo do
      transitions :to => :sent, :from => :paid, :guard => :all_items_are_not_paid_and_system_driven_event?
      transitions :to => :partially_paid, :from => :paid, :guard => :not_all_items_are_paid_and_system_driven_event?
      transitions :to => :sent, :from => :partially_paid, :guard => :all_items_are_not_paid_and_system_driven_event?
      transitions :to => :draft, :from => :approved, :guard => :current_user_is_office_staff?
      transitions :to => :approved, :from => :ready_for_esend, :guard => :current_user_is_consultant_or_ha_not_associated_with_consultant?
      transitions :to => :approved, :from => :sent, :guard => lambda {|i| i.current_user_is_consultant_or_ha_not_associated_with_consultant?}
    end

    event :mark_as_denied, after: :update_status_date do
      transitions :to => :denied, :from => [:paid, :sent, :partially_paid], :guard => :system_driven_event?
    end

    event :mark_as_paid, after: :update_status_date do
      transitions :to => :paid, :from => [:denied, :sent, :partially_paid], :guard => :system_driven_event?
    end

    event :mark_as_partially_paid, after: :update_status_date do
      transitions :to => :partially_paid, :from => [:denied, :sent, :paid], :guard => :system_driven_event?
    end

  end

  def is_claim_transmission_failure
    ['edi_generation_failure', 'trn_failure', 'ta1_failure', '999_failure', '277_failure'].include?(transmission_status)
  end



  attr_accessor :system_driven_event, :receivables_for_print



  def reset_transmission_status
    self.transmission_status = nil
  end

  def system_driven_event?
    self.system_driven_event == true
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :invoice_status
    write_attribute_without_mapping(attr, v)
  end

  def current_user_is_consultant_or_ha_not_associated_with_consultant?
    (current_user_is_consultant? or ha_not_associated_with_consultant?)
  end

  def ha_not_associated_with_consultant?
    org.consulting_companies.empty?
  end

  def ha_associated_with_consultant?
    org.consulting_companies.present?
  end

  def formatted_amount(amount)
    amount ||= 0
    number_to_currency(amount)
  end

  def billed_amount
    receivables.map(&:receivable_amount).sum
  end

  def receivables
    res = super
    return res unless self.receivables_for_print

    supplies_present = res.detect{|r| r.source.is_a?(Supply) }

    receivables_list = res.where("source_type = 'TreatmentVisit'").reorder("receivable_date")
    last_visit_receivable = receivables_list.last
    first_visit_receivable = receivables_list.first
    date = last_visit_receivable.receivable_date if last_visit_receivable
    q_code_receivable = create_qcode_receivable(first_visit_receivable) if final_or_lupa_bill?
    wound_supplies = res.select{|r| r.revenue_code == "623"}
    res -= wound_supplies
    non_wound_supplies = res.select{|r| r.revenue_code == "270"}
    res -= non_wound_supplies
    wound_item = wound_supplies.empty? ? [] : [create_receivable_for_print("623", date, wound_supplies)]
    non_wound_item = non_wound_supplies.empty? ? [] : [create_receivable_for_print("270", date, non_wound_supplies)]
    res = res.insert(1, q_code_receivable) if final_or_lupa_bill?
    res = res + wound_item + non_wound_item
    number_of_receivables = res.size
    blank_receivables = (number_of_receivables % 21)
    (21 - blank_receivables).times{|i| res << Receivable.new(:receivable_date => "", :invoice => self) }

    if (supplies_present.nil? and invoice_type == FINAL)
      service = res.detect{|r| r.purpose == "Home Health Services" }
      nrs_code = service.hcpcs_code[-1]
      nrs_number = NRS_NUMBER[nrs_code]
      if nrs_number
        service.hcpcs_code[4] = NRS_NUMBER[nrs_code]
        res = res.to_a
        res[res.index(service)] = service
      end
    end

    res
  end

  def self.get_edi_url_and_claims_mark_as_sent(approved_claims, params)
    mode_char = (params[:test_mode] == 'T' ? 'T' : 'P')
    url = nil
    errors_present= false
    if(approved_claims.size > 0)
      ActiveRecord::Base.transaction do
        url = Generate837Edi.new(approved_claims, mode_char).construct_edi_file
        errors_present = (url.is_a? Array)
        unless params[:test_mode]
          unless errors_present
            approved_claims = Invoice.claims_status_scope(params[:records], 'N')
            approved_claims.each{|claim|
              claim.sent_date = params[:sent_date].to_date
              claim.mark_as_sent! if claim.may_mark_as_sent?
            }
          end
        end
      end
    end
    if errors_present == false
      if params[:xml]
        xml_convert = EdiParsers::Edi837ToPdf.new(approved_claims, mode_char, "#{Rails.root}/tmp/#{url.split('/').last}")
        url = xml_convert.get_xml_file_url
      elsif params[:ub04_print]
        edi_to_pdf = EdiParsers::Edi837ToPdf.new(approved_claims, mode_char, "#{Rails.root}/tmp/#{url.split('/').last}")
        url = edi_to_pdf.generate_pdf_report
      end
    end
    [url, errors_present]
  end

  def self.mark_claims_as_undo(claims)
    ActiveRecord::Base.transaction do
      claims.each{|i|
        i.system_driven_event = true
        i.undo! if i.may_undo?
      }
    end
  end

  def self.mark_claims_as_esend(claims)
    ActiveRecord::Base.transaction do
      claims.each{|i|
        i.system_driven_event = true
        i.mark_as_ready_for_esend! if i.may_mark_as_ready_for_esend?
      }
    end
  end

  def self.change_claim_status_as_draft(claims)
    ActiveRecord::Base.transaction do
      claims.each{|claim|
        claim.invoice_status = :draft
        claim.transmission_status = nil
        claim.transmission_note = nil
        claim.save
      }
    end
  end

  def final_or_lupa_bill?
    (invoice_type == FINAL || invoice_type == LUPA)
  end

  def create_receivable_for_print(rev_code, date, supplies)
    date ||= supplies.first.receivable_date
    amt = supplies.map(&:receivable_amount).sum
    Receivable.new({revenue_code: rev_code, purpose: "Medical Supplies", hcpcs_code: "",
                    receivable_date: date, service_units: 1, receivable_amount: amt})
  end




  def create_qcode_receivable(receivable)
    date = receivable.receivable_date
    revenue_code = receivable.revenue_code
    oasis_doc = treatment_episode.oasis_eval_or_rc_or_roc_document
    qcode = oasis_doc.m1100_ptnt_lvg_stutn
    hcpcs_code = if (1..10).include? qcode.to_i
                   "Q5001"
                 elsif (11..15).include? qcode.to_i
                   "Q5002"
                 else
                   "Q5009"
                 end
    Receivable.new({revenue_code: revenue_code, purpose: "", hcpcs_code: hcpcs_code,
                    receivable_date: date, service_units: 1, receivable_amount: 0.01})
  end

  def self.find_patient_with_medicare_number(medicare_number)
    PatientDetail.where(:medicare_number => medicare_number)
  end

  def self.invoices_from_invoice_number(remittance, service_from_date, service_to_date, medicare_number)
    invoices = Invoice.org_scope.where(['invoice_status not in (?)',['D']])
    patient_detail = find_patient_with_medicare_number(medicare_number)
    patient = if patient_detail.present?
                patient_detail.first.patient
              else
                res = find_patient_with_medicare_number(medicare_number.downcase).first.
                res.patient if res
              end
    return if patient.blank?
    service_to_date_format = service_to_date.strftime('%m%d%y')
    service_from_date_format = service_from_date.strftime('%m%d%y')

    invoices = invoices.select{|inv| inv.patient == patient and inv.statement_covers_period_from == service_from_date_format}
    invoice = invoices.detect{|inv| (inv.statement_covers_period_through == service_to_date_format and
        inv.statement_covers_period_from == service_from_date_format) }
    remit_claim = MedicareRemittanceClaim.where(:medicare_remittance_id => remittance.id, invoice_id: invoice.id).last if invoice
    invoice = if invoice and remit_claim.blank?
                invoice
              else
                invoices.detect{|x| (x.invoice_type == "327" || x.invoice_type == "329")}
              end
  end

  def self.excel_static_fields
    {E1: :agency_name, D4: :agency_street_address, D7: :agency_suite_number, D10: :agency_city_state_zip, D12: :agency_phone_number,
     BR1: :patient_control_number, BR5: :medical_record_number, CU5: :invoice_type_display, BN12: :fed_tax_number,
     CA12: :statement_covers_period_from, CJ12: :statement_covers_period_through, R14: :patient_reference, E15: :patient_name,
     BC14: :patient_address, AQ15: :patient_city, CF15: :patient_state, CK15: :patient_zip_code, D21: :patient_dob,
     N21: :patient_gender, R21: :soc_date, AG21: :src, E30: :payer_details, AO21: :status_of_discharge, BI34: :value_codes   , BH51: :invoice_date_display,
     D56: :payer_name, AE56: :provider_number, BE56: :prior_payment, BQ56: :invoice_amount, CJ54: :agency_npi, CJ56: :provider_number,
     D63: :patient_name, AI63: :patient_relationship, AM63: :medicare_number, D69: :treatment_authorization_codes,
     C75: :diagnosis_and_procedure_qualifier, E75: :icd_9_1, N75: :icd_9_2, X75: :icd_9_3, AH75: :icd_9_4, AR75: :icd_9_5,
     BB75: :icd_9_6, CA82: :primary_physician_npi, BR86: :primary_physician_last_name, CP86: :primary_physician_first_name,
     BP49: :total_service_units, BZ49: :total_amount, BZ52: :total_amount, O51: :number_of_pages, U51: :number_of_pages}
  end

  def self.generate_zip_file(invoice_ids)
    ref = Time.current.strftime('%Y%m%dT%H%M')
    folder = "#{Rails.root}/tmp/claims_#{ref}"
    `mkdir #{folder}`

    invoices = where(["id in (?)", invoice_ids])
    invoices.each do |invoice|
      invoice.receivables_for_print = true
      file = ExcelGenerator.new(invoice, excel_static_fields).generate_excel
      `mv #{file} #{folder}`
    end

    zip_file = "#{Rails.root}/tmp/claims_#{ref}.zip"
    `zip -jr #{zip_file} #{folder}`
    `rm -rf #{folder}`
    "claims_#{ref}"
  end

  def invoice_status
    STATE_MAP.invert[read_attribute(:invoice_status)]
  end

  def all_items_are_paid_and_system_driven_event?
    all_items_are_paid? and system_driven_event?
  end

  def all_items_are_not_paid_and_system_driven_event?
    res = all_items_are_not_paid? and system_driven_event?
    res
  end

  def not_all_items_are_paid_and_system_driven_event?
    not_all_items_are_paid? and system_driven_event?
  end

  def all_items_are_paid?
    receivables.all?{|r| r.paid? }
  end

  def all_items_are_not_paid?
    receivables.all?{|r| r.paid? == false }
  end

  def not_all_items_are_paid?
    receivables.any?{|r| r.paid? == false } and receivables.any?{|r| r.paid? }
  end

  def invoice_status_change_for_pay_event
    self.system_driven_event = true
    self.pay! if may_pay?
    self.system_driven_event = false
  end

  def self.next_invoice_number
    last_invoice = self.unscoped.order("invoice_number ASC").last
    last_invoice.nil?? 1 : (last_invoice.invoice_number + 1)
  end

  def invoice_date_display
    self.invoice_date.strftime("%m%d%y")
  end

  def aged
    return false unless treatment.treatment_request
    claim_submission_due_days = treatment.treatment_request.insurance_company.claim_submission_due_days
    invoice_billed_days = (Date.current - invoice_date).to_i
    return false if self.sent? or self.paid? or self.partially_paid? or claim_submission_due_days.blank?
    due_days = claim_submission_due_days - invoice_billed_days if claim_submission_due_days
    due_days > 7 ? false : true
  end

  def oasis_doc
    oasis_document
  end

  def patient
    treatment.patient
  end

  def patient_name
    "#{oasis_doc.m0040_pat_lname.capitalize},  #{oasis_doc.m0040_pat_fname.capitalize}"
  end

  def patient_last_name
    oasis_doc.m0040_pat_lname.capitalize
  end

  def patient_first_name
    oasis_doc.m0040_pat_fname.capitalize
  end

  def formatted_patient_name
    "#{oasis_doc.m0040_pat_lname.upcase} #{oasis_doc.m0040_pat_fname.upcase}"
  end

  def patient_full_name_with_mr_number
    "#{patient.last_name.capitalize}, #{patient.first_name.capitalize} (#{patient.patient_reference})"
  end

  def patient_dob_century_format
    Date.strptime(oasis_doc.m0066_pat_birth_dt, "%m/%d/%Y").strftime("%Y%m%d") if oasis_doc.present?
  end

  def rap?
    INVOICE_TYPES[invoice_type] == "RAP"
  end

  def home_health_service
    self.receivables.detect{|receivable| receivable.home_health_service? }
  end

  def update_rap_receivable_date(date)
    receivable = receivables.first
    receivable.update_receivable_date(date)
  end

  def update_hipps_code_and_amount(params)
    return unless can_update_hipps_code_and_amount?
    service = home_health_service
    if service
      self.update_attributes!({invoice_amount: params[:amount]})
      service.update_hipps_code_and_amount(params)
    end
  end

  def can_update_hipps_code_and_amount?
    self.draft?
  end

  def status_of_discharge
    if (rap? or treatment_episode.is_recertified?)
      "30"
    else
      discharges = treatment.treatment_activities.where(["activity_type = ? and activity_reason_code is not null", "D"])
      discharges.last.activity_reason_code if discharges.size > 0
    end
  end

  def treatment_authorization_codes
    treatment_episode.treatment_authorization
  end

  def oasis_document
    treatment_episode.oasis_evaluation_or_recertification_or_roc_document
  end

  def number_of_pages
    num_of_recs = receivables.size
    (num_of_recs / 21 + ((num_of_recs % 21) == 0 ? 0 : 1))
  end

  def display_transition_window
    doc_id = treatment_episode.rap_generated_document
    doc = Document.org_scope.where(id: doc_id).first
    through_date = get_through_date
    info_date = Date.strptime(doc.m0090_info_completed_dt, '%m/%d/%Y') if doc
    res = false
    res = if (through_date and treatment_episode.start_date.between?(Date.parse('03-08-2015'), Date.parse('30-09-2015')) and through_date >= Date.parse('01-10-2015') and
        info_date < Date.parse('01-10-2015') and (self.final_claim? or self.lupa?))
            true
          elsif (doc and treatment_episode.start_date.between?(Date.parse('03-08-2015'), Date.parse('30-09-2015')) and info_date >= Date.parse('01-10-2015') and
              (self.rap?))
            true
          elsif (doc and treatment_episode.start_date >= Date.parse('01-10-2015') and info_date < Date.parse('01-10-2015') and  (self.final_claim? or self.lupa? or self.rap?))
            true
          else
            false
          end
    res
  end

  def provider_number
    MedicareAdministrativeContractor.new(org, "P").receiver_id
  end

 def primary_physician_first_name
   treatment.primary_physician.first_name
 end

  def primary_physician_last_name
    treatment.primary_physician.last_name
  end

  def primary_physician_middle_initials
    treatment.primary_physician.middle_initials
  end
  def primary_physician_npi
    treatment.primary_physician.npi_number
  end

  def partial_episode_date
    activity = treatment.treatment_activities.reorder("id DESC").detect{|a| a.activity_type == TreatmentActivity::DISCHARGE}
    activity.activity_date if TreatmentActivity::DISCHARGE_REASON_CODES.include? activity.activity_reason_code
  end

  def get_through_date
    if INVOICE_TYPES[invoice_type] == "RAP"
      treatment_episode.start_date if INVOICE_TYPES[invoice_type] == "RAP"
    elsif treatment_episode.is_recertified?
      treatment_episode.end_date
    else
      date = partial_episode_date
      date ? date : (raise 'Activity Reason code is blank')
    end
  end

  def can_display_actions?
    res = true
    t = self.treatment
    if t
      request = t.treatment_request
      res = false if (request and request.insurance_company.medicare? and invoice_type == 'R')
    end
    res
  end


  def final_claim?
    INVOICE_TYPES[invoice_type] == "Final"
  end

  def lupa?
    INVOICE_TYPES[invoice_type] == "LUPA"
  end

  def prior_payment
    "0.00"
  end

  def patient_relationship
    treatment.treatment_request.patient_relation_to_insured
  end

  def reset_final_claim
    filtered_receivables = receivables.where("purpose=?", "Home Health Services")
    filtered_receivables.delete_all
    self.invoice_status = :draft
    self.invoice_type = 'R'
    self.save
  end

  def sent_date_formatted
    self.sent_date.strftime("%m/%d/%y")   if self.sent_date
  end

  def expected_date_display
    return if sent_date.nil?
    rap? ? sent_date.to_date + 7.days :  sent_date.to_date + 15.days
  end

  def expected_amount
    amount = 0
    soc_episode = (self.treatment_episode == treatment.first_episode)
    if rap?
      amount = soc_episode ? total_amount * 0.6 : total_amount * 0.5
    elsif final_claim?
      amount = soc_episode ? total_amount * 0.4 : total_amount * 0.5
    elsif lupa?
      amount = total_amount
    end
    amount.round(2)
  end

  def claim_sent?
    [:sent, :paid, :partially_paid].include?(invoice_status)
  end

  def priority_of_visit
    "2"
  end

  def update_status_date
    if self.sent?
      self.update_attribute(:invoice_sent_date,self.sent_date)
      self.update_attribute(:status_date,self.sent_date)
    else
      self.update_attribute("#{aasm_current_state}_date",Date.current)
      self.update_attribute(:status_date,Date.current)
    end
  end

  def update_status_date_for_undo
    additional_fields_hash = {sent: additional_fields[:invoice_sent_date], partially_paid:
    additional_fields[:partially_paid_date],approved: additional_fields[:approved_date]}

    date = additional_fields_hash[aasm_current_state]

    if date.present?
      self.update_attribute(:status_date,date)
    elsif self.draft?
      self.update_attribute(:status_date,nil)
    else
      self.update_attribute(:status_date,nil)
    end
  end

  private

  def reset_sent_date
    self.sent_date = nil
    self.transmission_status = nil
  end

  def update_episode_medicare_bill_status    
    treatment_episode.update_attributes({:medicare_bill_status => :not_ready_for_billing, :rap_generated_document => ''})
  end
end
