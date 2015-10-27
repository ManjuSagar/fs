# == Schema Information
#
# Table name: treatment_requests
#
#  id                              :integer          not null, primary key
#  patient_id                      :integer          not null
#  request_date                    :datetime         not null
#  request_status                  :string(1)        default("N"), not null
#  health_agency_id                :integer          not null
#  created_user_id                 :integer          not null
#  lang_mandatory_flag             :boolean
#  special_instructions            :text
#  si_mandatory_flag               :boolean
#  known_allergies                 :text
#  reason_for_therapy              :text
#  restrictions                    :text
#  agency_contact_user_id          :integer
#  approved_agency_user_id         :integer
#  approved_date_time              :datetime
#  referred_physician_id           :integer
#  lock_version                    :integer          default(0)
#  broadcast_staffing_request_flag :boolean          default(FALSE)
#  referral_received_flag          :boolean          default(FALSE)
#  preferred_gender                :string(1)
#  referral_received_date          :date
#  eligibility_check_flag          :boolean          default(FALSE)
#  insurance_company_id            :integer
#  certification_period            :integer
#

class TreatmentRequest < ActiveRecord::Base
  belongs_to :patient
  belongs_to :health_agency
  has_one :patient_treatment
  has_and_belongs_to_many :disciplines, :join_table => "treat_req_disciplines", :foreign_key => :request_id
  has_and_belongs_to_many :visit_types, :join_table => "treat_req_visit_types", :foreign_key => :request_id
  has_and_belongs_to_many :medical_equipments, :join_table => "treat_req_med_equipments", :foreign_key => :request_id
  has_and_belongs_to_many :payment_sources, :join_table => "treatment_request_payment_sources", :foreign_key => :request_id
  has_many :request_staffs, :foreign_key => :request_id, :class_name => "TreatmentRequestStaff", :dependent => :destroy
  belongs_to :referred_physician, :class_name => "Physician"
  has_many :referral_attachments, :class_name => "TreatmentRequestAttachment", :foreign_key => :request_id, :dependent => :destroy
  has_one :staffing_master, :as => :staffable, :dependent => :destroy
  belongs_to :insurance_company
  belongs_to :insurance_case_manager

  audited :associated_with => :patient, :allow_mass_assignment => true
  has_associated_audits
  scope :org_scope, lambda { includes({:patient => :patient_detail}, :request_staffs, :referral_attachments, :disciplines).where({:patient_details => {:org_id => Org.current.id}}).order("users.last_name, users.first_name") if Org.current}
  scope :not_admitted, lambda { org_scope.where("request_status = 'R'").order("users.last_name, users.first_name") if Org.current}
  scope :pending_referrals, lambda { org_scope.where("request_status NOT IN ('A', 'R')").order("users.last_name, users.first_name") if Org.current}
  scope :user_scope, lambda { where(["health_agency_id in (select org_id from org_users where user_id = ?)", User.current.id])}
  scope :admitted_patient_referral, lambda{org_scope.includes(:patient_treatment).where(["patient_treatments.treatment_status in (?)", ['P', 'A', 'O', 'D']])}
  before_create :set_ids
  after_save :create_staffing_needs, :update_denormalized_patient_list
  before_save :set_certification_period, :revert_user_viewing_changed_attr
  before_save :submit_referral_request, :unless => :new_record?
  after_initialize :set_defaults, :if => :new_record?
  after_destroy :update_denormalized_patient_list, :unless => :new_record?
  before_destroy { disciplines.clear; visit_types.clear; medical_equipments.clear; payment_sources.clear}

  PREFERRED_GENDER_MAP = [['', '---'], ['M', 'Male'], ['F', 'Female']]
  ALIRTS_SOURCES = [["10", "10 - MSSP"], ["11", "11 - Self"], ["12", "12 - Social Service Agency"],["13", "13 - Family friend"]]
  POINT_OF_ORIGIN = [['1', "1 - Physician Referral"], ['2', "2 - Clinical Referral"], ['3', "3 - HMO Referral"], ['4', "4 - Transfer from Hospital"],
                    ['5', "5 - Transfer from SNF"], ['6', "6 - Transfer from Another Facility"], ['8', "8 - Court/Law Enforcement"],
                    ['9', "9 - Information not Available"], ['A', "A - Transfer from a rural primary care hospital (RPCH)"],
                    ['D', "D - Transfer within same facility"], ['E', "E - Transfer from ambulatory surgery center"],
                    ['F', "F - Transfer from Hospice"]] +  ALIRTS_SOURCES
  DEFAULT_INSURANCE_COMPANY_CODE = 'medicare'
  INSURANCE_COMPANIES_MAP = InsuranceCompany.where(["lower(company_code) <> ?", DEFAULT_INSURANCE_COMPANY_CODE.downcase]).map{|ic| [ic.id, ic.company_name]}
  PRIVATE_INSURANCE = "8"
  HOURLY_BILL = 'H'
  VISIT_BILL = 'V'
  after_validation :raise_errors_if_any

  validates :patient, :presence => true
  validates :referred_physician, :presence => true
  validates :request_date, :presence => true
  validates :point_of_origin, :presence => true
  validates :referral_received_date, :presence => true, :if => :referral_received?
  validate :check_referral_date

  attr_accessor :user_viewing_changed_attr_value

  def update_denormalized_patient_list
    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)
    if d.present?
      DenormalizedPatientList.update_with(patient)
    else
      DenormalizedPatientList.create_with(patient)
    end
  end

  def raise_errors_if_any
    if disciplines.empty?
      self.errors.add(:base, "Atleast one Discipline required")
    end
    if insurance_company_id.present?
      if InsuranceCompany.find(insurance_company_id.to_i).certification_period <= 0
        if certification_period.present? == false or certification_period <= 0
          self.errors.add(:base, "Certification Period is required and it should be greater than zero.")
        end
      end
    else
      self.errors.add(:base, "Select Insurance Company.")
    end
  end


  include AASM
  STATE_MAP = {:draft => 'D', :pending_staffing => 'S', :pending_referral => 'F', :pending_soc => 'P', :pending_eligibility_check => 'E',
               :admitted => 'A', :rejected => 'R', :inreview => 'I'}
  aasm :column => :request_status do
    state :draft, :initial => true, :after_enter => :reset_staffing_needs
    state :pending_staffing
    state :pending_soc
    state :pending_referral
    state :pending_eligibility_check
    state :admitted, :after_enter => :create_treatment
    state :rejected
    state :inreview

    event :submit do
      transitions :to => :pending_staffing, :from => :draft, :guard => :no_undischarged_treatment_and_system_driven_event?
    end

    event :mark_as_referral_received, :before => :submit_referral_request, :after => :update_referral_received_flag do
      transitions :to => :draft, :from => :draft, :guard => :referral_not_received?
      transitions :to => :pending_staffing, :from => :pending_staffing, :guard => :referral_not_received?
      transitions :to => :pending_eligibility_check, :from => :pending_eligibility_check, :guard => :referral_not_received?
      transitions :to => :pending_soc, :from => :pending_referral, :guard => :staffed_and_eligibility_check_completed_and_referral_not_received?
      transitions :to => :pending_eligibility_check, :from => :pending_referral, :guard => :staffed_and_referral_not_received_and_eligibility_check_not_completed?
    end

    event :eligibility_check_complete, :before => :submit_referral_request, :after => :update_eligibility_check_flag do
      transitions :to => :draft, :from => :draft, :guard => :eligibility_check_not_completed?
      transitions :to => :pending_staffing, :from => :pending_staffing, :guard => :eligibility_check_not_completed?
      transitions :to => :pending_referral, :from => :pending_referral, :guard => :eligibility_check_not_completed?
      transitions :to => :pending_referral, :from => :pending_eligibility_check, :guard => :staffed_and_referral_not_received_and_eligibility_check_completed?
      transitions :to => :pending_soc, :from => :pending_eligibility_check, :guard => :staffed_and_referral_received_and_eligibility_check_not_completed?
      transitions :to => :pending_soc, :from => :pending_eligibility_check, :guard => :staffed_and_referral_received_and_eligibility_check_completed?
    end


    event :finalize_staffing, :before => :submit_referral_request, :after => :reject_unselected_staffs do
      transitions :to => :pending_soc, :from => :pending_staffing, :guard => :staffed_and_referral_received_and_eligibility_check_completed?
      transitions :to => :pending_eligibility_check, :from => :pending_staffing, :guard => :staffed_and_eligibility_check_not_completed?
      transitions :to => :pending_referral, :from => :pending_staffing, :guard => :staffed_and_referral_not_received?
      transitions :to => :pending_soc, :from => :inreview, :guard => :staffed_and_referral_received_and_eligibility_check_completed?

    end

    event :referral_received, :after => :submit_referral_request do
      transitions :to => :pending_soc, :from => :pending_referral, :guard => :system_driven_event?
      transitions :to => :draft, :from => :draft, :guard => :system_driven_event?
      transitions :to => :pending_staffing, :from => :pending_staffing, :guard => :system_driven_event?
    end

    event :admit do
      transitions :to => :admitted, :from => [:pending_soc, :inreview], :guard => :no_undischarged_treatment?
    end

    event :donot_admit do
      transitions :to => :rejected, :from => [:draft, :pending_staffing, :pending_referral, :pending_soc, :pending_eligibility_check, :inreview]
    end

    event :reset do
      transitions :to => :inreview, :from => :admitted, :guard => :system_driven_event?
      transitions :to =>:inreview, :from => :rejected, :guard => :staffed_and_referral_received_and_eligibility_check_completed?
      transitions :to =>:pending_staffing, :from => :rejected, :guard => :not_staffed?
      transitions :to =>:pending_referral, :from => :rejected, :guard => :staffed_and_eligibility_check_completed_and_referral_not_received?
      transitions :to =>:pending_eligibility_check, :from => :rejected, :guard => :staffed_and_referral_received_and_eligibility_check_not_completed?
    end

    TreatmentRequest.aasm_states.map(&:name).each {|state|
      event "transition_to_#{state}".to_sym do
        transitions :from => TreatmentRequest.aasm_states.map(&:name), :to => state , :guard => :system_driven_event?
      end
    }

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :request_status
    write_attribute_without_mapping(attr, v)
  end

  attr_accessor :system_driven_event, :soc_date

  netzke_attribute :soc_date

  def system_driven_event?
    self.system_driven_event == true
  end

  def submit_referral_request
    self.system_driven_event = true
    self.submit! if self.may_submit?
    self.system_driven_event = false
    true
  end

  def request_status
    STATE_MAP.invert[read_attribute(:request_status)]
  end

  def status
    if self.request_status != :admitted
      if self.request_status == :rejected
        "N"
      else
        "P"
      end
    end
  end

  def to_s
    "#{patient}"
  end

  def name
    patient.full_name
  end

  def patient_location
    patient.location
  end

  def staffs_present_and_staffed?
    (not request_staffs.empty?) and staffed?
  end

  def staffing_flag
    staffs_present_and_staffed?
  end

  def ref_received_flag
    referral_received?
  end

  def eligibility_flag
    eligibility_check_completed?
  end

  def disciplines_display
    disciplines.collect{|x| {d: x.discipline_code}}.to_json
  end

  def staffed?
    request_staffs.where('staff_id is null').count == 0
  end

  def not_staffed?
    not staffed?
  end

  def no_undischarged_treatment?
    patient.treatments.none?{|t| t.discharged? == false}
  end

  def staffed_and_referral_received_and_no_undischarged_treatment?
    staffed? and referral_received? and no_undischarged_treatment?
  end

  def eligibility_check_completed?
    self.eligibility_check_flag == true
  end

  def record_type
    if self.patient_treatment.nil?
      3
    end
  end

   def referral_received?
    attached_referral.nil? == false or self.referral_received_flag == true
  end

  def update_eligibility_check_flag
    self.update_attributes!({:eligibility_check_flag => true})
  end

  def update_referral_received_flag
    self.update_attributes!({:referral_received_flag => true})
  end

  def reject_unselected_staffs
    staffing_master.reject_unselected_staffs if staffing_master
  end

  def attached_referral
    referral_attachments.detect{|attachment| attachment.attachment_type == AttachmentType.referral(patient.org.id)}
  end

  def reset_staffing_needs
    request_staffs.destroy_all
    staffing_master.destroy if staffing_master
  end

  def disciplines_list
    self.disciplines - self.request_staffs.map(&:discipline)
  end

  def treatment
    self.patient_treatment
  end

  def visit_types_list
    self.visit_types - self.request_staffs.map(&:visit_type)
  end

  def destroy_discipline_staffs
    discipline_staffs = disciplines.empty? ? request_staffs.where("discipline_id IS NOT NULL") : request_staffs.where("discipline_id IS NOT NULL and discipline_id NOT IN (?)", disciplines)
    discipline_staffs.destroy_all
  end

  def destroy_visit_staffs
    visit_staffs = visit_types.empty? ? request_staffs.where("discipline_id IS NULL") :request_staffs.where("discipline_id IS NULL and visit_type_id NOT IN (?)", visit_types)
    visit_staffs.destroy_all
  end

  def create_request_staffs_for_discipline
    disciplines_list.uniq.each do |disc|
      self.request_staffs.create!(:discipline => disc)
      create_treatment_staffs_for_discipline_if_patient_admitted?
    end
  end

  def create_treatment_staffs_for_discipline_if_patient_admitted?
    if patient_admitted?
      create_treatment_disciplines(disc)
      treatment.treatment_staffs.create!(:discipline => disc)
    end
  end

  def create_request_staffs_for_visit_types
    visit_types_list.uniq.each do |vt|
      self.request_staffs.create!(:visit_type => vt)
      create_treatment_staffs_for_visit_type_if_patient_admitted?
    end
  end

  def create_treatment_staffs_for_visit_type_if_patient_admitted?
    if patient_admitted?
      treatment.treatment_staffs.create!(:visit_type => vt)
      treatment.visit_types << vt
      treatment.save!
    end
  end

  def patient_admitted?
    self.admitted? and treatment.present?
  end

  def initiate_staffing
    master = staffing_master ? staffing_master : self.build_staffing_master
    select_request_staffs_if_discipline_present
    self.save!
    create_staffing_requirements
    master.broadcast_requirements
  end

  def select_request_staffs_if_discipline_present
    request_staffs.select{|rs| rs.discipline.present?}.each do |rs|
      if fine_grain_discipline_requirements_present?(rs.discipline)
        create_request_staffs_for_unstaffed_discipline(rs.discipline)
        rs.destroy if rs.visit_type.nil?
      end
    end
  end

  def create_staffing_requirements
     self.request_staffs(true).each do |rs|
       unless rs.staffed?
         rs.staffing_requirement = create_staffing_requirement(rs.discipline, rs.visit_type)
         rs.save!
       end
     end
  end

  def create_request_staffs_for_unstaffed_discipline(discipline)
    discipline.visit_types.mandatory.each do |vt|
      self.request_staffs.build(:discipline => discipline, :visit_type => vt) unless request_exist_for_discipline_visit_type?(discipline, vt)
    end
    self.save!
  end

  def request_exist_for_discipline_visit_type?(discipline, visit_type)
    request_staffs.any?{|rs| rs.discipline == discipline and rs.visit_type == visit_type}
  end

  # Creating staffing requirement
  def create_staffing_requirement(discipline, visit_type = nil)
    staffing_master.staffing_requirements.create!(:discipline => discipline, :visit_type => visit_type)
  end

  def treatment_reference
    "#{self.patient.patient_detail.patient_reference} - #{(patient.treatments.size + 1).to_s.rjust(4, '0')}"
  end

  def set_treatment_data(treatment)
    treatment.treatment_status = 'P'
    treatment.agency_contact = User.current
    treatment.patient = patient
    treatment.treatment_start_date = soc_date
    treatment.treatment_reference = treatment_reference
  end

  def create_treatment
    treatment = self.build_patient_treatment
    set_treatment_data(treatment)
    create_treatment_staffs
    add_visit_types
    create_treatment_physicians
    self.save!

	  self.disciplines.each do |d|
      create_treatment_disciplines(d)
    end

    create_referral_attachments
    create_clinical_staffs
  end

  def create_treatment_staffs
    self.request_staffs.each do |s|
        treatment.treatment_staffs.build(s.attributes.reject{|k,v| ["id", "request_id", "apply_patient_preference"].include? k.to_s})
    end
  end

  def create_clinical_staffs
    staffs = FieldStaff.clinical_staffs.each do |staff|
      staffing_master = treatment.staffing_masters.create!
      discipline = staff.license_type.discipline
      staffing_requirement = staffing_master.staffing_requirements.create!(:discipline => discipline, :visit_type => nil, staffing_status: "A")
      l = treatment.treatment_staffs.build(:discipline => discipline, staff: staff, staffing_requirement: staffing_requirement, system_assigned: true)
      l.save!
    end
  end

  def add_visit_types
    self.visit_types.each do |vt|
      treatment.visit_types << vt
    end
  end

  def create_treatment_physicians
    treatment.treatment_physicians.build({:physician => referred_physician, :primary_referral_flag => true, :require_cc_flag => true})
  end

  def create_treatment_disciplines(discipline)
    treatment.treatment_disciplines.create(:discipline => discipline, :treatment_status => 'P', :treatment_episode => treatment.treatment_episodes.first)
  end

  def create_referral_attachments
    referral_attachments.each do |attachment|
      treatment.attachments.create(attachment.attributes.reject{|k, v| ["id", "request_id"].include? k.to_s}.
                                       merge({:attachment => File.new("#{Rails.root}/public/#{attachment.attachment.url.split("?").first}"), :treatment_episode => treatment.treatment_episodes.first}))
    end
  end

  def self.referral_date
    Date.current
  end

  def check_referral_date
    unless request_date.nil?
      if request_date > Date.current
        errors.add(:referral_date, "is invalid.")
      end
    end
  end

  def language_preference_specified?
    lang_mandatory_flag == true
  end

  def gender_preference_specified?
    gender_mandatory_flag == true
  end

  def gender_requirements
    preferred_gender.present? ? gender_description : nil
  end

  def languages_preferred
    language_preference_specified? ? patient.languages.collect{|x| x.to_s}.join(",") : nil
  end

  def special_instructions_required
    si_mandatory_flag.present? ? special_instructions : nil
  end

  def gender_description
    gender = (self.preferred_gender == "M") ? "Male" : "Female"
  end

  netzke_attribute :medical_equipment_ids
  netzke_attribute :discipline_ids
  netzke_attribute :visit_type_ids

  def medicare_present?
    payment_sources.find_by_description("Medicare (HMO/managed care/Advantage plan)").present? || (insurance_company and insurance_company.company_code.downcase == 'medicare')
  end

  def patient_relation_to_insured
    patient_ins = patient_insurance_companies
    if patient_ins.present? and patient_ins.relation_to_insured
      patient_ins.relation_to_insured
    else
      "18"
    end
  end

  def patient_relation_ship
    patient_ins = patient_insurance_companies
    if patient_ins.present? and patient_ins.relation_to_insured
      patient_ins.relation_to_insured_display
    else
      "Self"
    end
  end

  def patient_insurance_companies
    patient.patient_insurance_companies.detect{|p_ins| p_ins.insurance_company == self.insurance_company}
  end

  def insurance_number
    patient_insurance_companies.patient_insurance_number if patient_insurance_companies
  end

  def can_remove_visit_type(visit_type_id)
    res = true
    if self.admitted?
      visit_type = treatment.visit_types.detect{|vt| vt.id == visit_type_id}
      res = false if visit_type and treatment.can_remove_visit_type?(visit_type) == false
    end
    res
  end

  def get_staffs(params)
    preferred_languages = language_preference_specified? ? patient.languages : nil
    preferred_gender =  preferred_gender
    discipline = (params[:discipline_id].nil?)? nil : Discipline.find(params[:discipline_id])
    visit_type = (params[:visit_type_id].nil?)? nil : Org.current.visit_types.find(params[:visit_type_id])
    patient_address = patient.address_string

    consider_patient_preference = params[:patient_preference] != TreatmentRequestStaff::DONT_APPLY_PATIENT_PREFERENCE

    qualified_field_staffs = FieldStaff.qualified_field_staff_list_for_staffing(discipline, visit_type, consider_patient_preference,  preferred_languages, preferred_gender, patient_address)
    qualified_scs = StaffingCompany.qualified_sc_list_for_staffing(discipline, visit_type, consider_patient_preference,  preferred_languages, preferred_gender, patient_address)
    staffs = qualified_field_staffs + qualified_scs
    staffs.uniq
  end

  def staffs_for_referral(params)
    staffs = get_staffs(params)
    sc_staffs = staffs.select{|x| x.is_a? Org}
    fs_staffs = staffs.select{|x| x.is_a? User}.flatten
    staffs = sc_staffs + fs_staffs
    request_staff_id =  params[:request_staff_id]
    if request_staff_id
      staff = request_staffs.find(request_staff_id).staff
      staffs << staff if staff
    end
    staffs.uniq
  end

  def medicare?
    insurance_company.medicare?
  end

  def private_insurance?
    insurance_company.private_insurance?
  end

  def agency
    patient.org
  end

  def hourly_rate_for_fs?
    field_staff_bill_type == HOURLY_BILL
  end

  def hourly_rate_for_insurance?
    insurance_bill_type == HOURLY_BILL
  end

  def visit_rate_for_fs?
    field_staff_bill_type == VISIT_BILL
  end

  def visit_rate_for_insurance?
    insurance_bill_type == VISIT_BILL
  end

  def request_display
    self.rejected? ? 'N' : 'P'
  end

  def events
    events_for_current_state.collect{|x| x.name.to_s}.join(",") if patient_treatment.blank?
  end

  def oasis_flag
    'f'
  end

  def poc_flag
    'f'
  end

  def dc_flag
    'f'
  end

  def fc_flag
    'f'
  end

  def rap_flag
    'f'
  end

  def doc_flag
    'f'
  end

  def mo_flag
    'f'
  end

  private

  # Checking: For particular discipline is there multiple requests(one discipline without visit_type and remaining with visit_type)
  def fine_grain_discipline_requirements_present?(discipline)
    (request_staffs.detect{|rs| rs.discipline == discipline and rs.visit_type == nil} and
        request_staffs.detect{|rs| rs.discipline == discipline and rs.visit_type}) ? true : false
  end

  def no_undischarged_treatment_and_system_driven_event?
    no_undischarged_treatment? and system_driven_event?
  end

  def referral_not_received?
    not referral_received?
  end

  def staffed_and_eligibility_check_completed_and_referral_not_received?
    staffed_and_eligibility_check_completed? and referral_not_received?
  end

  def staffed_and_referral_not_received_and_eligibility_check_not_completed?
    staffed_and_referral_not_received? and eligibility_check_not_completed?
  end

  def staffed_and_referral_not_received_and_eligibility_check_completed?
    staffed_and_referral_not_received? and eligibility_check_not_completed?
  end

  def staffed_and_referral_received_and_eligibility_check_completed?
    staffed_and_referral_received? and eligibility_check_completed?
  end

  def staffed_and_referral_received_and_eligibility_check_not_completed?
    staffed_and_referral_received? and eligibility_check_not_completed?
  end

  def staffed_and_eligibility_check_not_completed?
    staffed? and eligibility_check_not_completed?
  end

  def staffed_and_referral_not_received?
    staffed? and referral_not_received?
  end

  def eligibility_check_not_completed?
    not eligibility_check_completed?
  end

  def staffed_and_eligibility_check_completed?
    staffed? and eligibility_check_completed?
  end

  def staffed_and_referral_received?
    staffed? and referral_received?
  end

  def create_staffing_needs
    return if self.treatment.present?
    destroy_discipline_staffs
    destroy_visit_staffs
    create_request_staffs_for_discipline
    treatment.treatment_disciplines.each{|td| td.destroy unless self.disciplines.include?(td.discipline)} if self.admitted? and treatment

    create_request_staffs_for_visit_types
    treatment.visit_types.each{|vt| vt.destroy unless self.visit_types.include?(vt)} if patient_admitted?
  end

  def set_ids
    self.health_agency = patient.org
    self.created_user_id = User.current.id
  end

  def set_certification_period
    if insurance_company_id.present?
      period = InsuranceCompany.find(insurance_company_id.to_i).certification_period
      self.certification_period = period if period > 0
    end
  end

  def set_defaults
    self.request_date = Time.current
  end

  def revert_user_viewing_changed_attr
    self.certification_period = self.user_viewing_changed_attr_value if self.user_viewing_changed_attr_value
  end
end
