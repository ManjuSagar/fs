# == Schema Information
#
# Table name: treatment_visits
#
#  id                        :integer          not null, primary key
#  discipline_id             :integer
#  treatment_episode_id      :integer          not null
#  visited_user_id           :integer          not null
#  visit_start_time          :datetime         not null
#  visit_end_time            :datetime         not null
#  visit_type_id             :integer          not null
#  visit_status              :string(1)
#  frequency_string          :string(100)
#  lock_version              :integer          default(0)
#  treatment_id              :integer          not null
#  supervised_user_id        :integer
#  visited_staff_type        :string(100)      not null
#  visited_staff_id          :integer          not null
#  created_user_id           :integer          not null
#  visit_entry_type          :string(1)        default("E"), not null
#  fs_sign_required          :boolean
#  supervisor_sign_required  :boolean
#  os_sign_required          :boolean
#  count_for_frequency_flag  :boolean          default(TRUE)
#  agency_approved_user_id   :integer
#  fs_sign_date              :date
#  supervised_user_sign_date :date
#  os_sign_date              :date
#

class TreatmentVisit < ActiveRecord::Base
  include VitalsDisplay
  has_many :payables, :as => :source, :dependent => :destroy
  has_many :receivables, :as => :source, :dependent => :destroy
  has_many :private_receivables, :as => :source, :dependent => :destroy
  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :discipline
  belongs_to :treatment_episode
  belongs_to :visited_user, :class_name => "User"
  belongs_to :supervised_user, :class_name => "User"
  belongs_to :created_user, :class_name => "User"
  belongs_to :visited_staff, :polymorphic => true
  belongs_to :visit_type
  has_many :documents, :foreign_key => :visit_id, :dependent => :destroy
  has_many :attachments, :class_name => "VisitAttachment", :foreign_key => :visit_id, :dependent => :destroy
  has_many :medications, :class_name => "TreatmentMedication", :foreign_key => :visit_id, :dependent => :destroy
  has_one :electronic_routesheet, :foreign_key => :visit_id, :dependent => :destroy
  has_one :vital, :class_name => "TreatmentVital", :foreign_key => :visit_id, :dependent => :destroy
  belongs_to :agency_approved_user, :class_name => "User"
  has_many :medical_orders, :dependent => :destroy
  has_one :scheduled_visit, :dependent => :nullify, :foreign_key => :visit_id

  audited :associated_with => :treatment, :allow_mass_assignment => true
  has_associated_audits

  after_save :update_denormalized_patient_list
  after_destroy :update_rap_service_date

  after_destroy :inform_visit_frequency_visit_is_deleted, :unless => :draft_status
  after_destroy :update_denormalized_patient_list, :unless => :new_record?

  default_scope lambda {order("visit_start_time")}
  scope :org_scope, lambda {|org = Org.current| includes(:treatment => {:patient => :patient_detail}).where({:patient_details => {:org_id => org.id}}) if org}
  scope :not_draft, lambda { org_scope.where("treatment_visits.draft_status = false") }
  scope :skilled_visits, lambda {includes(:discipline).where("disciplines.discipline_code IN ('PT','OT','ST', 'SN')")}
  scope :user_scope, lambda {|user = User.current| where(["(treatment_visits.draft_status = false and
                         (treatment_visits.visited_user_id = ? OR treatment_visits.supervised_user_id = ?))",user.id, user.id])}

  attr_accessor :from_electronic_routesheet, :schedule_entry

  validate :check_errors
  validate :check_mo_cannot_change
  validate :check_visit_time

  validates :supervised_user, :presence => true, :if => :supervised_user_required?
  validates :treatment_episode_id, :presence => true
  validates :visited_user, :presence => true
  validates :visit_start_time, :presence => true
  validates :visit_end_time, :presence => true
  validates :visit_type, :presence => true
  validates :visited_staff, :presence => true, :if => :visited_user
  validate :check_visit_date_valid
  validate :check_entered_visited_user_can_do_visit
  validate :check_staffing_company_contract_period
  validate :schedule_visit_time_in_and_time_out_format_check, :if => :schedule_entry
  PAPER_ENTRY = 'P'
  ELECTRONIC_ENTRY = 'E'
  VISIT_ENTRY_TYPES = [[PAPER_ENTRY, "Paper"], [ELECTRONIC_ENTRY, "Electronic"]]

  STATE_MAP = {:draft => 'D', :pending_supervisor_signature => 'S', :pending_staff_signature => 'P', :pending_field_staff_signature => 'F', :completed => 'C'}

  include AASM

  aasm :column => :visit_status do
    state :draft, :initial => true, :before_exit => :reset_sign_required_flags, :after_exit => :create_payable
    state :pending_supervisor_signature, :before_exit => :reset_sign_required_flags
    state :pending_staff_signature, :before_exit => :reset_sign_required_flags
    state :pending_field_staff_signature, :before_exit => :reset_sign_required_flags, :after_exit => :create_payable
    state :completed, :after_enter => [:create_payable, :create_or_update_receivables, :update_invoice, :generate_rap_bill_if_required]

    event :submit do
      transitions :to => :pending_staff_signature, :from => :draft, :guard => lambda{|r| r.can_change_status_based_on_documents_status?}
      transitions :to => :pending_field_staff_signature, :from => :draft, :guard => lambda{|r| r.can_change_status_based_on_documents_status?}
      transitions :to => :pending_supervisor_signature, :from => :draft, :guard => lambda{|r| r.can_change_status_based_on_documents_status?}
    end

    event :sign do
      transitions :to => :pending_field_staff_signature, :from => :draft, :guard => lambda{|r| r.can_change_status_based_on_documents_status?}
      transitions :to => :completed, :from => :draft, :guard => lambda{|r|  r.mandatory_docs_present? and r.route_sheet_present? and r.all_docs_are_completed?}

      transitions :to => :completed, :from => :pending_staff_signature, :guard => lambda{|r| r.all_docs_are_completed?}

      transitions :to => :pending_field_staff_signature, :from => :pending_staff_signature, :guard => lambda{|r| r.all_documents_are_valid? and r.current_user_is_office_staff_and_field_staff_signature_required?}
      transitions :to => :pending_supervisor_signature, :from => :pending_staff_signature, :guard => lambda{|r| r.all_documents_are_valid? and r.current_user_is_office_staff_and_supervisor_signature_required?}

      transitions :to => :completed, :from => :pending_field_staff_signature, :guard => lambda{|r| r.all_docs_are_completed?}
      transitions :to => :completed, :from => :pending_supervisor_signature, :guard => lambda{|r| r.all_docs_are_completed?}
    end

    event :unlock, :before => :set_os_sign_required do
      transitions :to => :pending_staff_signature, :from => [:pending_supervisor_signature, :pending_field_staff_signature, :completed], :guard => lambda{|r| r.all_documents_are_valid? and r.current_user_is_office_staff?}
    end

    event :complete do
      transitions :to => :completed, :from => [:draft, :pending_supervisor_signature, :pending_staff_signature, :pending_field_staff_signature],
                  :guard => lambda{|r| ((r.all_docs_are_completed? or r.all_docs_are_optional?) and r.route_sheet_present?) or r.paper_entry?}
    end

  end


  def update_denormalized_patient_list
    patient = treatment.patient
    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)

    if d.present?
      DenormalizedPatientList.update_with(patient)
    end
  end
  
  def visit_date_display
    visit_start_time.strftime('%m/%d/%Y')
  end
  
  def to_s
    discipline ? "#{discipline} - #{visit_type}" : "#{visit_type}"
  end

  def can_change_status_based_on_documents_status?
    mandatory_docs_present? and route_sheet_present? and all_docs_are_signed?
  end
  
  def field_staff_signature_required?
    self.fs_sign_required
  end

  def office_staff_signature_required?
   self.os_sign_required
  end

  def supervisor_signature_required?
    self.supervisor_sign_required
  end

  def field_staff_signature_not_required?
    self.fs_sign_required == false and self.supervisor_sign_required == false
  end

  def only_field_staff_signature_required?
    self.fs_sign_required == true and self.supervisor_sign_required == false and self.os_sign_required == false
  end

  def only_supervisor_signature_required?
    self.supervisor_sign_required == true and self.fs_sign_required == false and self.os_sign_required == false
  end

  def visit_entry_type_description
    case visit_entry_type
      when PAPER_ENTRY
        'Paper'
      when ELECTRONIC_ENTRY
        'Electronic'
    end
  end

  def paper_entry?
    visit_entry_type == PAPER_ENTRY
  end

  def electronic_entry?
    vsit_entry_type == ELECTRONIC_ENTRY
  end
  
  def review_agency_changes_flag?
    supervisor_present? and supervised_user.review_agency_changes_flag?
  end

  def route_sheet_present_and_supervisor_not_present_and_current_user_is_visited_fs?
    mandatory_docs_present? and route_sheet_present? and supervisor_not_present_and_current_user_is_visited_fs? and
        self.vital.valid?
  end

  def route_sheet_present_and_supervisor_present_and_current_user_is_supervised_user?
    mandatory_docs_present? and route_sheet_present? and supervisor_present_and_current_user_is_supervised_user? and
        self.vital.valid?
  end

  def route_sheet_present_and_supervisor_present_and_current_user_is_visited_fs?
    mandatory_docs_present? and route_sheet_present? and supervisor_present_and_current_user_is_visited_fs? and
        self.vital.valid?
  end

  def route_sheet_and_current_user_is_office_staff_and_field_staff_signature_required?
    mandatory_docs_present? and route_sheet_present? and current_user_is_office_staff? and
        field_staff_signature_required? and self.vital.valid?
  end

  def route_sheet_and_current_user_is_office_staff_and_field_staff_signature_not_required?
    mandatory_docs_present? and route_sheet_present? and current_user_is_office_staff? and
        field_staff_signature_not_required? and self.vital.valid?
  end

  def current_user_is_office_staff_and_office_staff_signature_required_and_field_staff_signature_not_required?
    current_user_is_office_staff? and office_staff_signature_required? and field_staff_signature_not_required?
  end
  
  def current_user_is_office_staff_and_field_staff_signature_required?
    current_user_is_office_staff? and field_staff_signature_required?
  end
  
  def current_user_is_office_staff_and_supervisor_signature_required?
    current_user_is_office_staff? and supervisor_signature_required? and not field_staff_signature_required?
  end
  
  def current_user_is_visited_fs_and_only_field_staff_signature_required?
    (current_user_is_visited_fs? or current_user_is_visited_user?) and only_field_staff_signature_required?
  end
  
  def current_user_is_supervised_user_and_only_supervisor_signature_required?
    current_user_is_supervised_user? and only_supervisor_signature_required?
  end
  
  def current_user_is_visited_fs_and_field_staff_signature_required_and_supervised_signature_required?
    current_user_is_visited_fs? and field_staff_signature_required? and supervisor_signature_required?
  end
  
  def current_user_is_supervised_user_and_supervisor_signature_required_and_field_staff_signature_required?
    current_user_is_supervised_user? and supervisor_signature_required? and field_staff_signature_required?
  end

  def current_user_is_visited_user?
    visited_user == User.current
  end

  def current_user_is_supervised_user?
    return false if self.supervised_user.nil?
    User.current == self.supervised_user
  end

  def supervisor_not_present?
    not supervisor_present?
  end

  def is_route_sheet_mandatory?
    treatment.patient.org.health_agency_detail.routesheet_mandatory == true
  end

  def is_route_sheet_not_mandatory?
    not is_route_sheet_mandatory?
  end

  def route_sheet_present?
    return true if is_route_sheet_not_mandatory?
    self.attachments.any?{|x| x.attachment_type == AttachmentType.route_sheet(treatment.patient.org.id)}
  end

  def supervisor_present?
    self.supervised_user.present?
  end

  def created_user_is_field_staff?
    self.created_user.is_a? FieldStaff
  end

  def current_user_is_created_user?
    User.current == self.created_user
  end

  def current_user_is_office_staff?
    User.current.office_staff?
  end
  
  def current_user_is_visited_fs?
    User.current == visited_user
  end

  def current_user_is_field_staff?
    current_user_is_visited_fs? and !User.current.clinical_staff?
  end

  def created_user_is_office_staff?
    self.created_user.is_a? OrgStaff
  end

  def visited_staff_is_a_user?
    visited_staff.is_a? User
  end

  def visited_staff_is_a_staffing_company
    visited_staff.is_a? StaffingCompany
  end

  def payable_rate
    org = treatment.patient.org
    params = {visit_type: visit_type, org: org, treatment: treatment, time_in_hour: time_taken_for_visit_in_hours, visit_date: visit_date}
    rate = visited_staff.payable_rate(params)
    rate.present? ? rate : 0
  end

  def editable?
    return true if draft_status
    result = false
    if self.draft?
      result = true if (current_user_is_visited_fs? or current_user_is_office_staff? or current_user_is_supervised_user?)
    elsif current_user_is_office_staff? and self.pending_staff_signature?
      result = true
    end
    result
  end

  def can_delete?
    payables.paid_payables.empty? and documents.empty?
  end

  def docs_signed?
    return unless mandatory_docs_present?
    documents.all?{|d| d.signed?}
  end

  def all_docs_are_optional?
    visit_type.mandatory_documents.empty? if visit_type
  end

  def mandatory_docs_present?
    pending_mandatory_docs.empty?
  end

  def pending_documents(status)
    return [] if documents.empty?
    documents.where(['status not in (?)', status])
  end

  def pending_mandatory_docs
    return [] unless visit_type
    if paper_entry?
      visit_type.mandatory_documents.reject{|d| attachments.any?{|a| a.document_definition == d}}
    else
      visit_type.mandatory_documents.reject{|d| documents.any?{|a| a.document_definition == d}}
    end
  end

  def all_documents_are_valid?
    documents.all?{|d| d.valid_document? }
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :visit_status
    write_attribute_without_mapping(attr, v)
  end

  def visit_status
    STATE_MAP.invert[read_attribute(:visit_status)]
  end

  netzke_attribute :systolic_bp
  netzke_attribute :diastolic_bp
  netzke_attribute :bp_read_position
  netzke_attribute :heart_rate
  netzke_attribute :respiration_rate
  netzke_attribute :temperature_in_fht
  netzke_attribute :blood_sugar
  netzke_attribute :sugar_read_period
  netzke_attribute :weight_in_lbs
  netzke_attribute :oxygen_saturation
  netzke_attribute :bp_read_location
  netzke_attribute :pain

  netzke_attribute :visit_date, type: :date
  netzke_attribute :visit_end_date, type: :date
  netzke_attribute :start_time
  netzke_attribute :end_time
  netzke_attribute :start_time_hour, type: :integer
  netzke_attribute :end_time_hour, type: :integer
  netzke_attribute :start_time_min, type: :integer
  netzke_attribute :end_time_min, type: :integer

  attr_accessor :visit_date, :start_time, :end_time, :start_time_hour, :start_time_min, :end_time_hour, :end_time_min, :visit_end_date

  delegate :systolic_bp, :systolic_bp=, :diastolic_bp, :diastolic_bp=, :bp_read_position, :bp_read_position=, :heart_rate,
           :heart_rate=, :respiration_rate, :respiration_rate=, :temperature_in_fht, :temperature_in_fht=, :blood_sugar,
           :blood_sugar=, :sugar_read_period, :sugar_read_period=, :weight_in_lbs, :weight_in_lbs=,
           :oxygen_saturation, :oxygen_saturation=, :bp_read_location, :bp_read_location=, :pain, :pain=,
           :fasting_blood_sugar, :random_blood_sugar, :to => :vital
  #validates_associated :vital

  def vital_with_build
    vital_without_build || build_vital
  end

  alias_method_chain :vital, :build

  def save_treatment_vitals
      self.vital.treatment = self.treatment
      vital.save! if vital.changed?
  end

  def order_content(eval_doc)
    content = ""
    content = ("Frequency : " + frequency_string + "\n") unless frequency_string.nil?
    content += ("Vitals : " + self.vitals_display + "\n\n") unless vitals_display.nil?
    content += eval_doc.medical_order_content
    content
  end

  def check_errors
    unless vital.valid?
      vital.errors.each do |k, v|
       self.errors.add(k, v)
      end
    end
  end

  def visit_start_date
  visit_start_time.to_date
  end

  def receivable_amount(payer)
    if payer.is_a? InsuranceCompany
      payer.amount_for_visit({treatment: treatment, visit_type_id: visit_type_id, time_in_hour: time_taken_for_visit_in_hours})
    else
			treatment_staffs = treatment.treatment_staffs.select{|s| s.staff == visited_staff }
      staff = treatment_staffs.detect{|s| s.discipline == discipline and s.visit_type == visit_type}
      staff = staff.present?? staff : treatment_staffs.detect{|s| s.discipline == discipline}
      staff.co_pay_amt
    end
  end

  def visit_type_rate(payer)
    if payer.is_a? InsuranceCompany and payer.private_insurance?
      payer.visit_type_rate({treatment: treatment, visit_type_id: visit_type_id, time_in_hour: time_taken_for_visit_in_hours})
    end
  end

  def set_sign_date(date)
    if current_user_is_office_staff?
      self.os_sign_date = date
    elsif current_user_is_visited_fs?
      self.fs_sign_date = date
    elsif current_user_is_supervised_user?
      self.supervised_user_sign_date = date
    end
    self.save
  end

  def requirements_code
    if visit_type
      visit_type.visit_type_code.gsub(/_/, " ")
    end
  end

  def requirement
    if discipline and visit_type
      "#{discipline} - #{visit_type}"
    elsif visit_type
      "#{visit_type}"
    end
  end

  def all_docs_are_signed?
    return false if documents.empty?
    documents.all?{|d| (not d.draft?) }
  end

  def all_docs_are_completed?
    return false if documents.empty?
    documents.all?{|d| d.completed? }
  end

  def sign_visit_if_required
    self.complete! if self.may_complete?
  end

  def draft_status_changed?
    self.changed.include?("draft_status")
  end

  def format_date_and_time(date, time_hour, time_min, time)
    begin
      obj = Time.zone.parse(date.to_s + " " + time_hour.to_s + ":"+ time_min.to_s) unless time_hour.blank?
      obj = Time.zone.parse(date.to_s + " "+ time[0..1] + ":" + time[2..3] ) unless time.blank?
    rescue Exception::ArgumentError
      obj = nil
    end
    obj
  end

  def set_dates
    if visit_date
      self.visit_start_time = format_date_and_time(visit_date, start_time_hour, start_time_min, start_time)
    end
    if visit_end_date
      self.visit_end_time = format_date_and_time(visit_end_date, end_time_hour, end_time_min, end_time)
    end
  end

  def pre_fill_supervised_user
    return nil if self.visited_user.nil?
    if visited_staff.is_a? User
      debug_log visited_staff.to_s
      if visited_user.license_type.independent_flag
        self.supervised_user = nil
      else
        treatment_staff = treatment.treatment_staffs.detect{|ts| ts.staff.is_a? User and ts.staff.license_type.independent_flag}
        self.supervised_user = treatment_staff.staff
      end
    end
  end

  def pre_fill_visited_staff
    return nil if self.visited_user.nil?
    self.visited_staff = if visited_user.is_a? LiteFieldStaff
       org = treatment.patient.org
       org.staffing_companies.detect{|sc| sc.staffs.include?(visited_user)} # visited_user.orgs.detect{|o| o.is_a? StaffingCompany }
    else
      visited_user
    end
  end

  def set_draft_status_visit_details
    set_visit_times_for_new_record
    if User.current.field_staff?
      self.visited_staff = User.current
      self.visited_user = User.current
    end
  end

  def set_visit_times_for_new_record
    self.visit_date = Date.current
    self.visit_end_date = Date.current
    self.start_time_hour = Time.current.hour
    self.start_time_min = Time.current.min
    self.end_time_hour = (Time.current + 3600).hour
    self.end_time_min = (Time.current + 3600).min
  end

  #start_time_hour,start_time_min,end_time_hour,end_time_min
  def reset_visit_times_for_schd_visit_entry
    self.start_time_hour = nil
    self.start_time_min = nil
    self.end_time_hour = nil
    self.end_time_min = nil
  end

  def schedule_visit_entry_defaults(params)
    if params[:from_schedule]
      self.visit_date = scheduled_visit.scheduled_date
      self.visit_end_date = scheduled_visit.scheduled_end_date
      self.start_time = scheduled_visit.start_time
      self.end_time = scheduled_visit.end_time
      self.visit_type = scheduled_visit.visit_type
      self.visited_user = scheduled_visit.field_staff
      self.treatment = scheduled_visit.treatment
      self.treatment_episode = scheduled_visit.treatment_episode
    else
      self.treatment_id = params[:treatment_id]
      self.treatment_episode_id = params[:treatment_episode_id]
    end
    self.visit_entry_type = PAPER_ENTRY
    self.schedule_entry = true
    pre_fill_visited_staff
    pre_fill_supervised_user
    reset_visit_times_for_schd_visit_entry
    self.valid?
  end

  def schedule_visit_time_in_and_time_out_format_check
    return unless visit_date
    raise_time_format_error(start_time, "Time In")
    raise_time_format_error(end_time, "Time Out")
  end

  def raise_time_format_error(time, error_prefix = "")
    if (time.match(/^\d{4}$/) == nil or time[0..1].to_i > 23 or time[2..3].to_i > 59)
      errors.add(:base, "#{error_prefix} should be in 'HHMM' format")
    end
  end

  def visited_user_is_belongs_to_organization?
    visited_user.is_a? FieldStaff and visited_user.orgs.include?(self.treatment.patient.org)
  end

  def is_dirty?
    not (self.changed - ["visit_status", "fs_sign_required", "supervisor_sign_required", "os_sign_required",
                         "agency_approved_user_id", "draft_status"]).empty? or
        self.vital.changed?
  end

  def generate_rap_bill_if_required
    return unless treatment.medicare?
    episode = self.treatment_episode
    invoice = rap_invoice
    if invoice
      update_rap_invoice(invoice)
    else
      episode.visit_is_completed
    end
  end

  def rap_invoice
    return nil if self.treatment_episode.nil?
    self.treatment_episode.invoices.detect{|i| ['322'].include?(i.invoice_type)}
  end

  def update_rap_service_date
    update_rap_invoice(rap_invoice)
  end

  def visit_date_changed?
    (self.changed.include?("visit_start_time") or self.changed.include?("visit_end_time"))
  end

  def can_not_edit_field?(params = {vitals_flag: false})
    if current_user_is_office_staff?
      params[:vitals_flag] ? false : final_claim_approved?
    else
      (not editable?)
    end
  end

  def vitals_editable?
    if treatment_episode.medicare?
      treatment_episode.final_claim_editable?
    else
      vitals_editable_for_pvt_ins_patient?
    end
  end

  def vitals_editable_for_pvt_ins_patient?
    private_receivables.empty? ? false : private_receivables.first.invoice_id.present?
  end

  def final_claim_approved?
    final_claim = treatment_episode.final_claim
    res = final_claim ? final_claim.draft? : true
    not res
  end

  def create_or_update_receivables
    request = self.treatment.treatment_request
    insurance_company = request.insurance_company
    if insurance_company.present?
      if insurance_company.co_pay_applicable
        create_or_update_receivable(treatment.patient, receivable_amount(treatment.patient))
      end
      create_or_update_receivable(insurance_company, receivable_amount(insurance_company))
    end
  end

  def first_visit_in_episode?
    treatment_episode.first_visit == self
  end

  def update_rap_receivable_date
    treatment_episode.update_rap_receivable_date(visit_date)
  end

  def can_update_rap_date?
    treatment_episode.can_update_rap_date?
  end

  def reset_dependents_dates
    if visit_date_changed? and (not draft_status_changed?) and self.schedule_entry != true
      create_or_update_receivables
      SyncInfoVisitAndDocument.update_documents_date(self)
      update_rap_receivable_date if first_visit_in_episode? and can_update_rap_date?
      medical_orders.each{|mo| mo.update_attributes!({:order_date => visit_date})} if medical_orders.size > 0
    end
  end

  def atleast_one_mo_is_signed?
    medical_orders.any?{|mo| mo.draft? == false }
  end

  def get_active_field_staff(treatment_id, visited_user_id, treatment)
    if treatment_id.present?
      staffs = PatientTreatment.find(treatment_id).treatment_staffs.staffed
      staffs = staffs.inject([]){|r, s|
        r << s.staff
        r
      }
      staffs = staffs.select do |staff|
        if staff.is_a? StaffingCompany
          true
        else
          org_user = staff.org_users.find_by_org_id(treatment.patient.org.id)
          org_user.present?
        end
      end
      staffs = staffs.select{|s| s == User.current} if (User.current.is_a?(FieldStaff) and User.current.clinical_staff.blank?)
      if visited_user_id
        field_staff = FieldStaff.find(visited_user_id)
        staffs << field_staff
        {:data => staffs.collect{|x| ["#{x.class.name}_#{x.id}", x.full_name]}.uniq}
      else
        {:data => staffs.collect{|x| ["#{x.class.name}_#{x.id}", x.full_name]}.uniq}
      end
    else
      {}
    end
  end

  #Class Methods Start

  def self.create_visit_instance(treatment_id, episode_id)
    sample_visit = TreatmentVisit.new(treatment_id: treatment_id, treatment_episode_id: episode_id)
    sample_visit.draft_status = true
    sample_visit.visit_status = :draft
    sample_visit.set_draft_status_visit_details
    sample_visit.set_dates
    sample_visit.save(:validate => false)
    sample_visit
  end

  #Class Methods End

  def bp_read_location_display
    if bp_read_location
      loc = TreatmentVital::BP_LOCATION.detect{|x| x[0] == bp_read_location}
      loc[1] unless loc.nil?
    end
  end

  def bp_read_position_display
    if bp_read_position
      pos = TreatmentVital::BP_POSITION.detect{|x| x[0] == bp_read_position}
      pos[1] unless pos.nil?
    end
  end

  def sugar_read_period_display
    if sugar_read_period
      p = TreatmentVital::SUGAR_READ_PERIOD.detect{|x| x[0] == sugar_read_period}
      p[1] unless p[1].nil?
    end
  end

  def weight_gain_loss_in_lbs
    weight_in_lbs
  end

  def visited_staff_signature
    visited_staff.signature?  if visited_staff
  end

  def visited_staff_signature_path
    visited_staff.signature.path if visited_staff
  end

  def visited_staff_full_name
    visited_staff.full_name if visited_staff
  end

  def created_user_full_name
    created_user.full_name if created_user
  end

  def supervised_user_full_name
    supervised_user.present? ? supervised_user.full_name : nil
  end

  def agency_approved_user_full_name
    agency_approved_user.full_name if agency_approved_user
  end

  def primary_physician
    treatment.primary_physician
  end

  def primary_physician_name
    primary_physician.full_name
  end

  def mr
    treatment.patient_reference
  end

  def patient_name
    treatment.patient_name
  end

  def discipline_code
    discipline.discipline_code if discipline
  end

  def document_is_signed
    self.complete! if self.may_complete?
    nil
  end

  def self.format_date_value(date)
    unless date.nil?
      if date.include?('/')
        Date.strptime(date, "%m/%d/%Y").strftime("%d/%m/%Y")
      else
        "#{date[8..9]}/#{date[5..6]}/#{date[0..3]}"
      end
    end
  end

  def self.check_visit_is_overlapped(treatment_id, values, visit_id = nil, schedule_visits = [], schedule_visit = false)
    treatment = PatientTreatment.find(treatment_id)
    visit = TreatmentVisit.find(visit_id) if visit_id
    date = values[:visit_date] || values["visit_date"]
    end_date = values[:visit_end_date] || values["visit_end_date"]
    start_time_hour = values[:start_time_hour] || values["start_time_hour"]
    start_time_min = values[:start_time_min] || values["start_time_min"]
    start_time = values[:start_time] || values["start_time"]
    end_time_hour = values[:end_time_hour] || values["end_time_hour"]
    end_time_min = values[:end_time_min] || values["end_time_min"]
    end_time = values[:end_time] || values["end_time"]
    field_staff_id = values[:visited_user__full_name] || values["visited_user__full_name"]

    date = self.format_date_value(date)
    end_date = self.format_date_value(end_date)
    res = if schedule_visit
      (start_time.blank? or end_time.blank?)
    else
      (start_time_hour.blank? or start_time_min.blank? or end_time_hour.blank? or end_time_min.blank?)
    end
    return false if (res or field_staff_id.blank?)

    visit_start_time = Time.zone.parse(date.to_s + " " + start_time_hour + ":"+ start_time_min) if start_time_hour
    visit_start_time = Time.zone.parse(date.to_s + " "+ start_time[0..1] + ":" + start_time[2..3] ) if start_time
    visit_end_time = Time.zone.parse(end_date.to_s + " "+ end_time_hour + ":" + end_time_min) if end_time_hour
    visit_end_time = Time.zone.parse(end_date.to_s + " "+ end_time[0..1] + ":" + end_time[2..3]) if end_time

    modified_schedule_visits = schedule_visits.collect do |sv|
      date = sv["visit_date"]
      date = "#{date[8..9]}/#{date[5..6]}/#{date[0..3]}"
      sv["visit_start_time"] = Time.zone.parse(date.to_s + " "+ sv["start_time"][0..1] + ":" + sv["start_time"][2..3] )
      sv["visit_end_time"] = Time.zone.parse(end_date.to_s + " "+ sv["end_time"][0..1] + ":" + sv["end_time"][2..3])
      sv["visited_user_id"] = sv["visited_user__full_name"]
      sv["treatment_id"] = treatment_id
      sv
    end

    visits = org_scope(treatment.health_agency).where(["date(visit_start_time) = ? AND treatment_visits.draft_status = ?", visit_start_time.in_time_zone('UTC').strftime("%Y-%m-%d"), false])

    visits = visits - [visit] if visit

    visits += modified_schedule_visits

    existing_visits = (visits).select do |v|
      range = (v["visit_start_time"].to_i .. v["visit_end_time"].to_i)
      (range.include?(visit_start_time.to_i) or range.include?(visit_end_time.to_i))
    end

    existing_visit = existing_visits.detect{|v|
      (v["visited_user_id"] == field_staff_id.to_i or v["treatment_id"] == treatment_id)
    }

    res = if existing_visit
      visit_start_time = existing_visit["visit_start_time"].strftime("%H:%M")
      visit_end_time = existing_visit["visit_end_time"].strftime("%H:%M")
      visit_date = existing_visit["visit_start_time"].strftime('%m/%d/%Y')

      if (existing_visit["treatment_id"].to_i == treatment_id)
        fs = User.find(existing_visit['visited_user_id'])
        "Another visit exists for this patient with a conflicting time: " +
        "(#{fs}) (#{visit_date}) (#{visit_start_time} - #{visit_end_time})."
      else
        treatment = PatientTreatment.find(existing_visit["treatment_id"])
        debug_log treatment
        "Another visit exists for this field staff with a conflicting time: " +
        "(#{treatment}) (#{visit_date}) (#{visit_start_time} - #{visit_end_time})."
      end
    else
      false
    end
    res
  end

  def time_taken_for_visit_in_seconds
    end_time = (visit_end_time < visit_start_time) ? (visit_end_time + 1.day) : visit_end_time
    (end_time - visit_start_time)
  end

  def time_taken_for_visit_in_hours

    end_time = (visit_end_time < visit_start_time) ? (visit_end_time + 1.day) : visit_end_time
    res = ((end_time - visit_start_time)/1.hour).round(2)
    res
  end

  def ins_no_of_units
    if(treatment.treatment_request.insurance_bill_type == 'V')
      1
    else
      time_taken_for_visit_in_hours
    end
  end

  def number_of_units
    res = if(treatment.treatment_request.field_staff_bill_type == 'V')
            1
          else
            time_taken_for_visit_in_hours
          end
    res
  end

  def rate
    org = treatment.patient.org
    params = {visit_type: visit_type, org: org, treatment: treatment, time_in_hour: time_taken_for_visit_in_hours, visit_date: visit_date}
    rate = visited_staff.visit_type_rate(params)
    rate.present? ? rate : 0
  end

  def inform_visit_frequency_visit_is_added
    params = {discipline_id: discipline_id, treatment_id: treatment_id, treatment_episode_id: treatment_episode_id, date: visit_date}
    visit_frequency= VisitFrequency.get_visit_frequency_using_date(params)
    if visit_frequency and discipline_id
      episode_visit_count = treatment_episode.treatment_visits.where(["treatment_visits.discipline_id = ?", discipline.id]).
          select {|tv| tv.visit_date.between?(visit_frequency.frequency_start_date, visit_frequency.frequency_end_date)}.count
      visit_frequency.update_attribute(:visits_count, episode_visit_count)
    end
  end

  def visit_start_time_display
    visit_start_time.strftime('%H:%M')
  end

  def visit_end_time_display
    visit_end_time.strftime('%H:%M')
  end

  def visit_end_date_display
    visit_end_time.strftime('%m/%d/%Y')
  end

  private

  def check_mo_cannot_change
    if visit_date_changed? and (not draft_status_changed?)
      errors.add(:base, "Some of the Medical Orders attached to this Visit are already signed.") if atleast_one_mo_is_signed?
    end
  end

  def check_visit_time
    if visit_start_time && visit_end_time
      res = "Selected visit timing is invalid, either change the end time or the end date"
      errors.add(:base, "Visit timing cannot be same") if visit_start_time == visit_end_time
      errors.add(:base, res) if visit_start_time > visit_end_time
    end
  end

  def check_entered_visited_user_can_do_visit
    return nil if self.visited_user.nil? or self.visit_type.nil?
    staff = treatment.treatment_staffs.any?{|ts| ts.staff == visited_user }
    if ((visit_type.license_types.include?(visited_user.license_type) == false) or staff.nil?)
      errors.add(:base, "Visited user can't do this visit.")
    end
  end

  def check_staffing_company_contract_period
    staffing_company= self.visited_staff
    if staffing_company.is_a? StaffingCompany
      contract = staffing_company.contract_period_with_in_from_date_and_to_date(visit_date)
      errors.add(:base, "We are unable to post this visit because the Staffing Company contract has expired.
                        Please renew or extend the contract in the Staffing Company profile to allow visit posting.") unless contract
    end
  end

  def submit_documents
    self.documents.each{|d| d.submit! if d.may_submit? }
  end

  def sign_documents
    self.documents.each{|d| d.sign! if d.may_sign?}
  end

  def update_invoice
    return unless treatment.medicare?
    treatment_episode.regenerate_final_claim_if_required
  end

  def update_rap_invoice(invoice)
    if invoice
        visit_date = treatment_episode.first_visit_date
        return unless visit_date
        invoice.update_column(:invoice_date, visit_date)
        invoice.receivables.first.update_column(:receivable_date, visit_date)
    end
  end

  def supervised_user_required?
    res = false
    if self.visited_staff.is_a? User and self.visited_user
      res = true unless self.visited_user.license_type.independent_flag
    end
    res
  end

  def set_os_sign_required
    self.os_sign_required = true
  end
  
  def reset_sign_required_flags
    self.agency_approved_user = User.current if current_user_is_office_staff?
    self.fs_sign_required = false if current_user_is_visited_fs? 
    self.os_sign_required = false if current_user_is_office_staff?
    self.supervisor_sign_required = false if current_user_is_supervised_user?
  end

  def check_visit_date_valid
    errors.add(:visit_date, "should be with in the Episode.") if visit_date_not_with_in_episode?
    errors.add(:visit_date, "Should be before the discharge date") if visit_date_not_in_discharge_date?
  end

  def visit_date_not_with_in_episode?
    if visit_start_time.present? and visit_end_time.present?
      date = visit_start_time.to_date
      end_date = visit_end_time.to_date
      date < treatment_episode.start_date or end_date > treatment_episode.end_date
    end
  end

  def visit_date_not_in_discharge_date?
    if ((treatment.discharged? == true) and visit_start_time.present? and visit_end_time.present?)
      date = visit_start_time.to_date
      end_date = visit_end_time.to_date
      discharge_date = treatment.treatment_activities.where(:activity_type => "D").first.activity_date.to_date
      (date > discharge_date) or (end_date > discharge_date)
    end
  end

  def create_payable
    if (current_user_is_visited_fs? or visit_status == :completed)
      payable = payables.detect{|p| p.payee == visited_staff}
      payable = payable ? payable : payables.build
      unit = treatment.treatment_request.field_staff_bill_type
      no_of_units = number_of_units
      last_completed_doc = documents.order('id DESC').where(:status => ["C", "E"]).first
      submission_date = last_completed_doc.present?  ? last_completed_doc.fs_sign_date : visit_start_date
      payable.update_attributes!(:treatment => treatment, :payable_type => 'V', :visit_date => visit_start_date, :payee => visited_staff,
                                 :submission_date => submission_date, :payable_amount => payable_rate, :org => treatment.health_agency,
                                 :field_staff => visited_user, purpose: requirements_code, unit: unit, no_of_units: no_of_units, rate: rate)
    end
  end

  def service_units
    res = ((visit_end_time - visit_start_time)/60)/15
    (res == 0)? 1 : res
  end

  def inform_visit_frequency_visit_is_deleted
    params = {discipline_id: discipline_id, treatment_id: treatment_id, treatment_episode_id: treatment_episode_id, date: visit_date}
    visit_frequency= VisitFrequency.get_visit_frequency_using_date(params)
    visit_frequency.visit_is_deleted if visit_frequency
  end

  def create_or_update_receivable(payer, amount)
    amt = (amount.nil? || amount == 0)? 0 : amount
    hcpcs_code = ""
    revenue_code = ""
    if payer.is_a? InsuranceCompany
      vt = payer.insurance_company_visit_type_rates.find_by_visit_type_id(visit_type_id)
      hcpcs_code = vt.hcpcs_code
      revenue_code = vt.revenue_code
    end

    if (payer.is_a? InsuranceCompany and payer.medicare?)
      create_or_update_medicare_receivables(payer, amt, hcpcs_code, revenue_code)
    elsif (payer.is_a? InsuranceCompany and payer.private_insurance?)
      create_or_update_private_receivables(payer, amt, hcpcs_code, revenue_code)
    end
  end


  def create_or_update_medicare_receivables(payer, amt, hcpcs_code, revenue_code)
    receivable = receivables.detect{|r| r.payer == payer }
    receivable = receivable ? receivable : receivables.build
    invoice =  self.treatment_episode.invoices.detect{|i| ['327', '329', 'R'].include?(i.invoice_type) } ||
        self.treatment_episode.invoices.new(org: treatment.health_agency, payer: payer, invoice_amount: 0,
                                            invoice_description: "Home Health Services", invoice_number: Invoice.next_invoice_number, invoice_date: Date.current,
                                            invoice_type: "R", treatment: self.treatment, treatment_episode: self.treatment_episode, invoice_status: "D")
    invoice.invoice_amount += amt
    invoice.save!

    receivable.update_attributes!(:receivable_type => 'V', :payer => payer, :receivable_amount => amt, :org => treatment.health_agency,
                                  :treatment => treatment, :hcpcs_code => hcpcs_code, :revenue_code => revenue_code,
                                  :treatment_episode => treatment_episode, :receivable_date => visit_start_date, :service_units => service_units, invoice: invoice,
                                   :visit_type_rate => visit_type_rate(payer))
  end

  def create_or_update_private_receivables(payer, amt, hcpcs_code, revenue_code)
    receivable = private_receivables.detect{|r| r.payer == payer }
    receivable = receivable ? receivable : private_receivables.build
    invoice = ([:sent, :received].include? receivable.receivable_status) ? receivable.private_insurance_invoice : nil
    receivable.update_attributes!(:receivable_type => 'V', :payer => payer, :receivable_amount => amt, :org => treatment.health_agency,
                                  :treatment => treatment, :hcpcs_code => hcpcs_code, :revenue_code => revenue_code,
                                  :treatment_episode => treatment_episode, :receivable_date => visit_start_date, :service_units => service_units, private_insurance_invoice: invoice,
                                  :visit_type_rate => visit_type_rate(payer))

  end
end
