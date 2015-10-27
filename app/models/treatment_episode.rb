# == Schema Information
#
# Table name: treatment_episodes
#
#  id                 :integer          not null, primary key
#  treatment_id       :integer          not null
#  start_date         :date             not null
#  end_date           :date             not null
#  lock_version       :integer          default(0)
#  initial_hipps_code :string(255)
#
class TreatmentEpisode < ActiveRecord::Base
  include EpisodeColumns
  include AASM

  belongs_to :treatment, :class_name => "PatientTreatment"
  has_many :treatment_visits, :conditions => ["treatment_visits.draft_status = ?", false], :dependent => :destroy
  has_many :invoices, :dependent => :destroy
  has_many :medications, :class_name => "TreatmentMedication", :dependent => :destroy
  has_many :documents, :dependent => :destroy
  has_many :medical_orders, :dependent => :destroy
  has_many :communication_notes, :dependent => :destroy
  has_many :attachments, :class_name => "TreatmentAttachment", :dependent => :destroy
  has_many :receivables, :dependent => :destroy
  has_many :treatment_disciplines, :dependent => :destroy
  has_many :disciplines, :through => :treatment_disciplines
  has_many :visit_frequencies
  has_many :scheduled_visits, :dependent => :destroy

  scope :org_scope, lambda {|org = Org.current| includes(:treatment => {:patient => :patient_detail}).where({:patient_details => {:org_id => org.id}}).order("users.last_name, users.first_name") if org}
  scope :filter_based_on_treatment_status, lambda {|treatment_status_arr| org_scope.includes(:treatment).where({:patient_treatments => {:treatment_status => treatment_status_arr}})}
  scope :rap_scope, lambda {org_scope.where(:medicare_bill_status => ["B", "R", "L", "F"])}
  scope :episodes_using_patient_name, lambda {|first_name, last_name| includes(:treatment => :patient).where(["users.first_name = ? and users.last_name = ?", first_name, last_name])}
  scope :treatments_latest_episode, lambda {org_scope.joins(:treatment).where("end_date IN (SELECT MAX(te.end_date) from treatment_episodes te where te.treatment_id = patient_treatments.id)")}
  scope :treatments_first_episode, lambda {org_scope.joins(:treatment).where("start_date IN (SELECT MIN(te.start_date) from treatment_episodes te where te.treatment_id = patient_treatments.id)")}
  scope :treatments, lambda{|from_date, to_date| org_scope.where("start_date >= ? and start_date <= ?", from_date, to_date)}
  scope :treatments_end_date, lambda{|from_date, to_date| org_scope.where("end_date >= ? and end_date <= ?", from_date, to_date)}
  scope :treatments_start_date, lambda{|from_date, to_date| org_scope.where("start_date >= ? and start_date <= ?", from_date, to_date)}
  scope :active_during_based_on_date, lambda{|from_date, to_date| org_scope.includes(:treatment).where("(? BETWEEN start_date and end_date or ? BETWEEN start_date and end_date or start_date BETWEEN ? and ? or end_date BETWEEN ? and ?) and treatment_status = ?",from_date, to_date, from_date, to_date, from_date, to_date, 'A')}
  scope :list, lambda{|from_date, to_date| org_scope.joins(:treatment => :treatment_activities).where("(treatment_end_date BETWEEN ? and ?) or (? BETWEEN ? and treatment_end_date) or ((activity_date BETWEEN ? and ? or (activity_date > ? and start_date BETWEEN ? and ?)) and treatment_status = ?)", from_date, to_date, to_date, from_date, from_date, to_date, to_date, from_date, to_date, 'O')}
  scope :active_treatments, lambda{|from_date, to_date| treatments(from_date, to_date).joins(:treatment).where({:patient_treatments => {:treatment_status => 'A'}})}
  scope :treatment_by_soc, lambda{|from_date, to_date| org_scope.includes(:treatment).where("treatment_start_date >= ? and treatment_start_date <= ?",from_date, to_date)}
  scope :discharge_treatments, lambda{|from_date, to_date| org_scope.joins(:treatment => :treatment_activities).where("treatment_activities.activity_date >= ? and treatment_activities.activity_date <= ? and treatment_activities.activity_type = ? and treatment_activities.discipline_id is null and patient_treatments.treatment_status = 'D'", from_date, to_date, 'D')}
  scope :user_scope, lambda { where(["treatment_id in (select id from patient_treatments where treatment_request_id in (
                      select id from treatment_requests where health_agency_id in (select org_id from org_users
                      where user_id = ?) ) )", User.current.id]) }

  audited :associated_with => :treatment, :allow_mass_assignment => true

  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :treatment_id, :uniqueness => {:scope => [:start_date, :end_date], :message => " should don't have Certification Period with same start date and end date"}

  before_save :set_soc_date, :unless => :new_record?
  before_create :assign_treatment_to_treatment_disciplines
  after_create :generate_final_claim_bill_for_previous_episode_if_required
  after_validation :check_start_date_before_the_visit_start_date, :unless => :new_record?
  after_initialize :set_episode_type, :if => :medicare_epi_and_new_record?
  after_save :update_denormalized_patient_list
  after_destroy :reset_the_referral
  before_destroy :delete_invoices_if_required
  after_destroy :update_denormalized_patient_list, :unless => :new_record?

  RECERT = 'RC'

  STATE_MAP = {:not_ready_for_billing => 'N', :ready_for_bill => 'B', :rap_billed => "R", :lupa_billed => "L",
               :final_claim_billed => 'F'}

  STATUS_DISPLAY = {:rap_billed => "RAP", :lupa_billed => "LUPA", :final_claim_billed => 'FC', :not_ready_for_billing => "NB",
                    :ready_for_bill => 'NB'}

  EPISODE_TYPES = [["FEWOO", "Full Episode with out Outliers"], [ "FEWTO", "Full Episode with outliers"],
                  ["LUPA", "LUPA Episodes"], ["PEP", "PEP Only Episodes"], ["SCICP", "SCIC within a PEP"], [ "SCIC", "SCIC Only Episodes"]]

  attr_accessor :system_driven_event, :record_type

  netzke_attribute :record_type

  aasm :column => :medicare_bill_status do
    state :not_ready_for_billing, :initial => true
    state :ready_for_bill
    state :rap_billed, before_enter: :generate_rap_bill
    state :lupa_billed, before_enter: :generate_lupa_bill
    state :final_claim_billed, before_enter: :generate_final_claim_bill

    event :mark_as_ready_for_billing do
      transitions :to => :ready_for_bill, :from => :not_ready_for_billing, :guard => :system_driven_event?
    end

    event :rap_bill do
      transitions :to => :rap_billed, :from => :ready_for_bill
    end

    event :lupa_bill do
      transitions :to => :lupa_billed, :from => [:ready_for_bill, :rap_billed, :final_claim_billed], :guard => :four_or_less_visits?
    end

    event :final_claim_bill do
      transitions :to => :final_claim_billed, :from => [:rap_billed, :lupa_billed], :guard => :more_than_four_visits?
    end

    event :undo_final_bill do
      transitions :to => :rap_billed, :from => [:lupa_billed, :final_claim_billed], :guard => :system_driven_event?
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :medicare_bill_status
    write_attribute_without_mapping(attr, v)
  end

  def medicare_bill_status
    STATE_MAP.invert[read_attribute(:medicare_bill_status)]
  end

  def update_denormalized_patient_list
    patient = treatment.patient
    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)

    if d.present?
      DenormalizedPatientList.update_with(patient)
    end
  end

  def self.active_during(from_date, to_date)
    active_episodes = TreatmentEpisode.active_during_based_on_date(from_date, to_date).collect{|x| x.id}
    discharge_episodes_without_filter = TreatmentEpisode.list(from_date, to_date)
    discharged_episodes = discharge_episodes_without_filter.where("(? BETWEEN start_date and end_date or ? BETWEEN start_date and end_date or start_date BETWEEN ? and ? or end_date BETWEEN ? and ?)",from_date, to_date, from_date, to_date, from_date, to_date).collect{|x| x.id}
    res = active_episodes + discharged_episodes
    list = TreatmentEpisode.where(id: res)
    list
  end

  def record_type
    'E'
  end

  def to_s
    certification_period
  end

  def certification_period
    "#{start_date.strftime("%m/%d/%y")} - #{end_date.strftime("%m/%d/%y")}"
  end

  def certification_period_mmddyyyy
    "#{start_date.strftime("%m/%d/%Y")} - #{end_date.strftime("%m/%d/%Y")}"
  end

  def patient_name
    treatment.to_s
  end

  def treatment_patient
    treatment.patient
  end

  def treatment_soc_date
    treatment.soc_date
  end

  def patient_mr_no
    treatment.patient_reference
  end

  def rap_bill_generated?
    self.rap_billed? || self.lupa_billed? || self.final_claim_billed?
  end

  def treatment_last_episode?
    treatment.last_episode == self
  end

  def score_hipps_code_and_bill_amount(params = {})
    final_claim_flag = (params[:final_claim_flag] == true)
    doc = params[:doc]
    regenerate_hipps_code = (params[:regenerate_hipps_code] == true)
    score = get_hipps_code(regenerate_hipps_code, doc)
    hipps_code = if regenerate_hipps_code == true
                   score.nil? ? nil : score.hipps_code
                 else
                   score
                 end

    return nil if hipps_code.nil?
    bill_amount = medicare_bill_amount({doc: doc, final_claim_flag: final_claim_flag, hipps_code: hipps_code})
    return score, bill_amount
  end

  def recertified_doc
    documents.order('document_date DESC').detect{|d| (d.oasis_recertification_and_valid?) }
  end

  def valid_roc_doc
    documents.order('document_date DESC').detect{|d| (d.valid_roc_doc) }
  end

  def valid_oasis_doc
    documents.order('document_date ASC').detect{|d| (d.oasis_recertification_and_valid? or d.oasis_evaluation_and_valid? or d.oasis_resumption_of_care_and_valid?) }
  end

  def generate_final_claim_bill
    ActiveRecord::Base.transaction do
      hipps_code, bill_amount = score_hipps_code_and_bill_amount({final_claim_flag: true})

      invoice = final_claim #Find LUPA/Final Claim
      invoice ||= invoice_for_invoice_type("R") #Find Pending Claim

      receivable = find_or_create_receivable(invoice, hipps_code)

      update_invoice_to_final(invoice, receivable, bill_amount)
    end
  end

  def eval_documents
    documents.where(document_type: "OasisEvaluation")
  end

  def generate_lupa_bill
    ActiveRecord::Base.transaction do
      rate = lupa_rate
      doc ||= Document.find(rap_generated_document)
      hipps_code = doc.subm_hipps_code

      invoice = final_claim #Find LUPA/Final Claim
      invoice ||= invoice_for_invoice_type("R") #Find Pending Claim

      receivable =  find_or_create_receivable(invoice, hipps_code)

      update_invoice_to_lupa(invoice, receivable, rate)
    end
  end

  def generate_final_claim_for_episode
    self.lupa_bill! if self.may_lupa_bill?
    self.final_claim_bill! if self.may_final_claim_bill?
  end

  def final_billed?
    self.lupa_billed? || self.final_claim_billed?
  end

  def service_units
    supply_receivables = self.receivables.where(:receivable_type => "S")
    supply_receivables.sum(:receivable_amount).to_i
  end

  def medicare?
    treatment.medicare? if treatment
  end

  def is_recertified?
    episode_status == "RC"
  end

  def medicare_epi_and_new_record?
    self.new_record? and medicare?
  end

  def set_episode_type
    self.episode_type = "FEWOO"
  end

  def is_deletable?
    invoice_list = invoices.where("invoice_type !='R'")
    [treatment_visits, invoice_list, medications, documents.where("visit_id IS NULL OR (visit_id IN (SELECT v.id FROM
      treatment_visits v WHERE v.treatment_episode_id = #{self.id}))"), medical_orders, communication_notes,
     receivables].all?{|x| x.empty?}
  end

  def reset_medicare_status
    self.system_driven_event = true
    self.undo_final_bill! if self.may_undo_final_bill?
    self.system_driven_event = false
    nil
  end

  def oasis_evaluation_document
    documents.order("document_date DESC").detect{|d| d.oasis_evaluation? }
  end

  def oasis_recertification_document
    documents.order("document_date DESC").detect{|d| d.oasis_recertification? }
  end

  def oasis_resumption_of_care_document
    documents.order("document_date DESC").detect{|d| d.oasis_resumption_of_care? }
  end


  def plan_of_care_document
    documents.order("document_date DESC").detect{|d| d.respond_to?("is_poc?") }
  end

  def transfer_without_discharge_document
    documents.order("document_date DESC").detect{|d| d.oasis_transfer_without_dc_and_valid? }
  end

  def oasis_evaluation_or_recertification_or_roc_document
    rap_doc = documents.where(id: rap_generated_document).first
    if rap_doc
      rap_doc
    else
      oasis = oasis_evaluation_document
      oasis ||= oasis_recertification_document
      oasis ||= oasis_resumption_of_care_document
    end
  end

  def oasis_eval_or_rc_or_roc_document
    documents.order("document_date ASC").detect{|d| d.oasis_evaluation? or d.oasis_resumption_of_care? or d.oasis_recertification?}
  end

  def health_agency_name
    org = Org.current
    "<b>#{org}</b> #{org.phone_number}"
  end

  def rap_invoice
    self.invoices.detect {|i| i.rap? }
  end

  def rap_approved?
    rap_invoice.invoice_status != :draft if rap_invoice
  end

  def final_claim_approved?
    final_claim.invoice_status != :draft if final_claim
  end

  def document_is_completed(doc)
    # doc = self.valid_oasis_doc
    unless self.rap_generated_document.present?
      self.update_attributes!({rap_generated_document: doc.id})
    end

    self.update_attributes!({initial_hipps_code: doc.subm_hipps_code, treatment_authorization: doc.treatment_authorization_code,
                             hipps_version: doc.subm_hipps_version})
    return if treatment.private_insurance?
    create_or_update_rap_claim(doc)
  end

  def get_recent_oasis_doc
    documents.order('document_date DESC').detect{|d| (d.oasis_recertification_and_valid? or d.oasis_evaluation_and_valid? or d.oasis_resumption_of_care_and_valid?) }
  end

  def get_oasis_document
    treatment.private_insurance? ? get_recent_oasis_doc : Document.org_scope(treatment.patient.org).where(id: rap_generated_document).first
  end

  def create_or_update_rap_claim(doc)
    if completed_visits.count > 0
      if self.may_rap_bill?
        self.rap_bill!
      else
        rap = self.rap_invoice
        bill_amount = medicare_bill_amount({hipps_code: initial_hipps_code, doc: doc})
        rap.update_hipps_code_and_amount({hipps_code: initial_hipps_code, amount: bill_amount})
      end
    end
  end

  def visit_is_completed
    if self.valid_oasis_doc
      self.rap_bill! if self.may_rap_bill?
    end
  end

  def final_claim
    invoices.detect{|i| i.final_claim? or i.lupa? }
  end

  def can_update_rap_date?
    rap = invoice_for_invoice_type('322')
    rap ? rap.draft? : false
  end

  def update_rap_receivable_date(date)
    rap = rap_invoice
    rap.update_rap_receivable_date(date)
  end

  def first_visit_date
    visit = first_visit
    visit.visit_date if visit
  end

  def four_or_less_visits?
    treatment_visits.size <= 4
  end

  def regenerate_final_claim_if_required
    generate_final_claim_for_episode if final_billed?
  end

  def first_visit
    completed_visits.order("visit_start_time").first
  end

  def completed_visits
    treatment_visits.where(["visit_status = 'C'"])
  end

  def oasis_evaluation_or_recertification_document
    oasis = oasis_evaluation_document
    oasis ||= oasis_recertification_document
    oasis ||= oasis_resumption_of_care_document
    end

  def get_recent_oasis_document(final_claim_flag = false)
    if final_claim_flag == true
            documents.where(["document_type in (?)", Document::OASIS_DOCUMENTS]).order('document_date DESC').first
          elsif date_range_in_within_55_days?
            oasis_evaluation_or_recertification_document
          elsif date_range_in_recertified_period_without_rc_doc?
            valid_roc_doc
          elsif date_range_in_recertified_period_with_rc_doc?
            get_doc_based_on_roc_and_rc_hipps_code_match
          else
            documents.order('document_date DESC').select{|d| ["OasisEvaluation", "OasisRecertification", "OasisResumptionOfCare"].include? d.document_type}.first
          end

  end

  def date_range_in_within_55_days?(final_claim_flag = false)
    (final_claim_flag == false and unhold_activity_date.present? and unhold_activity_date.between?(start_date, episode_55th_day))
  end

  def date_range_in_recertified_period_without_rc_doc?(final_claim_flag = false)
    (final_claim_flag == false and recertified_doc.blank? and !first_episode? and unhold_activity_date.present? and unhold_activity_date.between?(previous_episode.episode_55th_day, previous_episode.end_date+1))
  end

  def date_range_in_recertified_period_with_rc_doc?(final_claim_flag = false)
    (final_claim_flag == false  and !first_episode? and valid_roc_doc.present? and
        recertified_doc.present?and unhold_activity_date.present? and unhold_activity_date.between?(previous_episode.episode_55th_day, previous_episode.end_date))

  end

  def get_doc_based_on_roc_and_rc_hipps_code_match
    (recertified_doc.subm_hipps_code == valid_roc_doc.subm_hipps_code) ? recertified_doc : valid_roc_doc
  end

  def unhold_activity_date
    treatment_activity = treatment.treatment_activities.where("activity_type = 'U'").order("id DESC").first
    treatment_activity.activity_date if treatment_activity.present?
  end

  def episode_55th_day
    end_date - 4.days
  end

  def previous_episode
    treatment.previous_episode(self)
  end

  def five_days_window
    "#{episode_55th_day.strftime("%m/%d/%Y")} - #{end_date.strftime("%m/%d/%Y")}"
  end

  def census_disciplines_display
    disciplines.collect{|x| x.discipline_code}.join(", ")
  end

  def episode_id
    self.id
  end

  def get_hipps_code(regenerate_hipps_code, doc)
    return initial_hipps_code unless regenerate_hipps_code

    doc ||= valid_oasis_doc
    return nil if doc.nil?
    score = doc.calculate_hipps_code(doc)
    score ? score : nil
  end


  def first_episode?
    treatment.first_episode == self
  end

  def delete_invoices_if_required
    pending_invoices = invoices.where(invoice_type: "R")
    if pending_invoices.present?
      pending_invoices.destroy_all
    end
    nil
  end

  def final_claim_editable?
    claim_status = [:sent, :paid, :partially_paid, :esent, :denied]
    final_claim ? claim_status.include?(final_claim.invoice_status) : false
  end

  private

  def invoice_for_invoice_type(invoice_type)
    invoices.detect{|i| i.invoice_type == invoice_type}
  end

  def find_or_create_receivable(invoice, hipps_code)
    if (invoice and invoice.home_health_service)
      receivable = invoice.home_health_service
      receivable.hcpcs_code = hipps_code
      receivable.save!
      receivable
    else
      create_receivable({hipps_code: hipps_code})
    end
  end

  def generate_rap_bill
    return if rap_invoice.present?
    ActiveRecord::Base.transaction do
      hipps_code, bill_amount = score_hipps_code_and_bill_amount
      receivable = create_receivable({hipps_code: hipps_code, bill_amount: bill_amount})
      create_invoice(receivable, "322", first_visit_date, bill_amount)
    end
  end

  def create_invoice(receivable, invoice_type, invoice_date, amount = 0)
    invoice = invoices.build(org: receivable.org, payer: receivable.payer, invoice_amount: amount,
                             invoice_description: "Home Health Services", invoice_number: Invoice.next_invoice_number,
                             invoice_date: invoice_date, invoice_type: invoice_type, treatment: self.treatment)
    invoice.receivables << receivable
  end

  def update_invoice_to_final(invoice, receivable, amount)
    update_invoice(invoice, receivable, "329", amount)
  end

  def update_invoice_to_lupa(invoice, receivable, amount)
    update_invoice(invoice, receivable, "327", amount)
  end

  def update_invoice(invoice, receivable, invoice_type, amount)
    invoice.invoice_type = invoice_type
    invoice.invoice_amount = amount
    invoice.invoice_date = Date.current
    invoice.receivables << receivable
    invoice.save!
  end

  def create_receivable(params)
    treatment = self.treatment
    receivable = receivables.build
    receivable.payer = treatment.insurance_company
    receivable.org = treatment.patient.org
    receivable.treatment = treatment
    receivable.receivable_amount = (params[:bill_amount] || 0)
    receivable.receivable_type = 'V'
    receivable.receivable_date = first_visit_date
    receivable.service_units = 1
    receivable.purpose = "Home Health Services"
    receivable.hcpcs_code = params[:hipps_code]
    receivable.revenue_code = "0023" if params[:hipps_code]
    receivable.save!
    receivable
  end

  def lupa_rate
    disciplines_codes = completed_visits.collect {|v| v.discipline_code }.compact
    medicare_bill_amount({final_claim_flag: true, disciplines_codes: disciplines_codes})
  end

  def medicare_bill_amount(params)
    doc = params[:doc]
    doc ||= get_recent_oasis_document(params[:final_claim_flag])
    rfa_year = end_date.year
    zip = ZipCode.find_by_zip_code(doc.m0060_pat_zip)
    inputs = {
        episode_sequence_num: treatment.episode_sequence_number(self),
        rfa_year: rfa_year,
        county_name: zip.admin_name_2,
        state: zip.admin_name_1,
    }.merge(params)
    ProspectivePaymentSystem::PPSGrouper.medicare_bill_amount(inputs)
  end

  def system_driven_event?
    self.system_driven_event == true
  end

  def more_than_four_visits?
    treatment_visits.size > 4
  end

  def is_only_episode_in_treatment?
    first_episode? and treatment.number_of_epsiodes == 1
  end


  def check_start_date_before_the_visit_start_date
    if treatment
      visit = first_visit
      if visit.present? and is_only_episode_in_treatment?
        errors.add(:start_date, "should be before the visit date.") if visit.visit_start_date < start_date
      end
    end
  end

  def set_soc_date
    if is_only_episode_in_treatment? and self.changes.include?("start_date")
      treatment.episode_start_date_is_changed(self.changes["start_date"][1])
    end
  end

  def generate_final_claim_bill_for_previous_episode_if_required
    previous_episode = treatment.previous_episode(self)
    if previous_episode
      previous_episode.update_attribute(:episode_status, RECERT)
      previous_episode.generate_final_claim_for_episode
    end
  end

  def assign_treatment_to_treatment_disciplines
    treatment_disciplines.each{|td| td.treatment = treatment}
  end

  def reset_the_referral
    if treatment.treatment_episodes.empty?
      request = treatment.treatment_request
      request.system_driven_event = true
      request.reset! if request.may_reset?
      request.system_driven_event = false
      treatment.destroy
    end
  end

end
