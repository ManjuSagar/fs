# == Schema Information
#
# Table name: patient_treatments
#
#  id                     :integer          not null, primary key
#  treatment_request_id   :integer
#  treatment_status       :string(1)        default("N"), not null
#  agency_contact_user_id :integer
#  treatment_start_date   :date
#  treatment_end_date     :date
#  patient_id             :integer          not null
#  lock_version           :integer          default(0)
#  treatment_reference    :string(20)       not null
#

class PatientTreatment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :treatment_request
  belongs_to :agency_contact, :class_name => "User", :foreign_key => :agency_contact_user_id
  has_many :medications, :class_name => "TreatmentMedication", :foreign_key => :treatment_id, :dependent => :destroy
  has_many :treatment_disciplines, :dependent => :destroy, :foreign_key => :treatment_id
  #has_many :treatment_visit_types, :dependent => :destroy, :foreign_key => :treatment_id
  has_many :treatment_visits, :dependent => :destroy, :foreign_key => :treatment_id, :conditions => ["treatment_visits.draft_status = ?", false]
  has_many :treatment_physicians, :dependent => :destroy, :foreign_key => :treatment_id
  has_many :treatment_staffing_companies, :dependent => :destroy, :foreign_key => :treatment_id
  has_many :staffing_companies, :through => :treatment_staffing_companies
  has_many :communication_notes, :dependent => :destroy, :foreign_key => :treatment_id
  has_many :disciplines, :through => :treatment_disciplines
  has_many :physicians, :through => :treatment_physicians
  has_many :vitals, :class_name => "TreatmentVital", :foreign_key => :treatment_id, :dependent => :destroy
  has_many :documents, :foreign_key => :treatment_id, :dependent => :destroy
  has_many :treatment_episodes, :dependent => :destroy, :foreign_key => :treatment_id, :order => "start_date ASC"
  has_many :treatment_field_staffs, :dependent => :destroy, :foreign_key => :treatment_id
  has_many :medical_orders, :foreign_key => :treatment_id, :dependent => :destroy
  has_many :attachments, :class_name => "TreatmentAttachment", :foreign_key => :treatment_id, :dependent => :destroy
  has_many :staffing_masters, :as => :staffable
  has_many :treatment_staffs, :foreign_key => :treatment_id, :dependent => :destroy
  has_many :payrolls, :foreign_key => :treatment_id
  has_many :payables, :foreign_key => :treatment_id, :dependent => :destroy
  #has_and_belongs_to_many :disciplines, :join_table => "treatment_disciplines", :foreign_key => :treatment_id
  has_and_belongs_to_many :visit_types, :join_table => "treatment_visit_types", :foreign_key => :treatment_id
  has_many :visit_frequencies, :foreign_key => "treatment_id", :dependent => :destroy, :order => :id
  has_many :treatment_activities, :foreign_key => :treatment_id, :dependent => :destroy
  has_many :receivables, :foreign_key => :treatment_id, :dependent => :destroy
  has_many :invoices, :foreign_key => :treatment_id, :dependent => :destroy

  netzke_attribute :treatment_status_filter
  netzke_attribute :search_by_field_staff
  netzke_attribute :search_by_staffing_company
  netzke_attribute :search_by_patient
  attr_accessor :treatment_status_filter, :search_by_field_staff, :search_by_staffing_company, :search_by_patient

  has_associated_audits
  audited :associated_with => :patient, :allow_mass_assignment => true

  scope :org_scope, lambda { includes(:patient => :patient_detail).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}
  scope :ins_scope, lambda {|ins_id| org_scope.includes(:treatment_request => :insurance_company).where({:insurance_companies => {:id => ins_id}})}

  scope :fs_treatment_scope, lambda {|fs=User.current.id| includes(:patient).where(["patient_treatments.id  IN (SELECT DISTINCT pt.id FROM patient_treatments pt INNER JOIN treatment_staffs ts
        ON ts.treatment_id = pt.id INNER JOIN users p ON p.id = pt.patient_id INNER JOIN patient_details pd ON pd.patient_id = p.id
        AND ts.staff_type = 'User' AND ts.staff_id = ? AND pd.org_id IN (SELECT DISTINCT ou.org_id FROM org_users ou WHERE ou.user_id = ?
        AND ou.user_status = 'A'))", fs, User.current.id]).order("users.last_name, users.first_name")
  }

  scope :os_field_staff_scope, lambda {|user_ids|  includes(:patient).where(["patient_treatments.id IN (?)", unique_patient_list(user_ids, Org.current.id)]).order("users.last_name, users.first_name")
  }
  scope :filter_based_on_treatment_status, lambda {|treatment_status_arr| fs_treatment_scope.where({:patient_treatments => {:treatment_status => treatment_status_arr}})}

  scope :user_scope, lambda { where(["treatment_request_id in (select id from treatment_requests where health_agency_id
                     in (select org_id from org_users where user_id = ?) )", User.current.id]) }

  def self.unique_patient_list(user_ids, org_id)
    arr = connection.execute("SELECT DISTINCT( pt.patient_id), pt.id
    FROM patient_treatments pt INNER JOIN treatment_staffs ts ON ts.treatment_id = pt.id INNER JOIN users p ON p.id = pt.patient_id
    INNER JOIN patient_details pd ON pd.patient_id = p.id AND ts.staff_type = 'User' AND ts.staff_id IN (#{user_ids.join(', ')}) AND pd.org_id = #{org_id}").to_a
    arr.uniq_by!{|a| a["patient_id"]}
    arr.collect{|a| a["id"]}
  end

  scope :sc_treatment_scope, lambda { sort_scope.includes(:treatment_staffs).where({:treatment_staffs => {
                              :staff_id => User.current.orgs.first.id, :staff_type => "Org"}})}

  scope :sort_scope, lambda{ includes(:patient).order("users.last_name ASC", "users.first_name ASC")}

  before_validation :update_patient_from_request
  before_save :revert_user_viewing_changed_attr
  after_save :update_denormalized_patient_list
  before_destroy { visit_types.clear}
  after_destroy :update_denormalized_patient_list, :unless => :new_record?

  attr_accessor :user_viewing_changed_attr_value

  def primary_physician
    primary_physician = treatment_physicians.detect{|p| p.primary?}
    (primary_physician.present?)? primary_physician.physician : nil
  end

  STATUS_DISPLAY = {pending_evaluation: 'PE', active: 'AC', on_hold: 'HD', discharged: 'DC'}
  STATUS_DISPLAY_COLOR = {pending_evaluation: '#8B3AB2', active: '#000000', on_hold: '#4F9FB2', discharged: '#267FFF'}
  COMBO_STORE_DISPLAY = [["", "---"], ['P', 'PE'], ['A', 'AC'], ['O', 'HD'], ['D', 'DC']]

  include AASM
  STATE_MAP = {:pending_evaluation => 'P', :active => 'A', :on_hold => 'O', :discharged => 'D'}
  aasm :column => :treatment_status do
    state :pending_evaluation, :initial => true, :after_enter => [:create_episode, :create_face_to_face_medical_order_if_required]
    state :active
    state :on_hold
    state :discharged, before_enter: :generate_final_claim_bill

    event :activate do
      transitions :to => :active, :from => :pending_evaluation, :guard => :system_driven_event?
    end

    event :deactivate, :before => :set_undo_process_flag do
      transitions :to => :pending_evaluation, :from => :active, :guard => :all_disciplines_are_in_pending_evaluation?
    end

    event :hold, :after => :hold_all_disciplines do
      transitions :to => :on_hold, :from => [:pending_evaluation, :active], :guard => :current_user_is_office_staff?
    end

    event :recertification do
      transitions :to => :active, :from => :active, :guard => :current_user_is_office_staff?
    end

    event :discharge do
      transitions :to => :discharged, :from => [:pending_evaluation, :active, :on_hold], :guard => :current_user_is_office_staff?
    end

    event :unhold, :after => :active_all_disciplines do
      transitions :to => :active, :from => :on_hold, :guard => :current_user_is_office_staff?
    end

    event :undo, :after => [:reset_claims, :reset_end_date] do
      transitions :to => :active, :from => [:discharged], :guard => :current_user_is_office_staff?
    end

    PatientTreatment.aasm_states.map(&:name).each {|state|
      event "transition_to_#{state}".to_sym do
        transitions :from => PatientTreatment.aasm_states.map(&:name), :to => state , :guard => :system_driven_event?
      end
    }

  end

  attr_accessor :system_driven_event, :undo_process


  def update_denormalized_patient_list
    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)

    if d.present?
      DenormalizedPatientList.update_with(patient)
    end
  end

  def set_undo_process_flag
    self.undo_process = true
  end

  def system_driven_event?
    self.system_driven_event == true
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :treatment_status
    write_attribute_without_mapping(attr, v)
  end

  def record_type
    1
  end

  def treatment_status
    STATE_MAP.invert[read_attribute(:treatment_status)]
  end

  def treatment_short_status
    status = {'P'=> "PE",'A'=>"AC", 'O'=> "HD", 'D'=>"DC"}
    status[read_attribute(:treatment_status)]
  end

  def treatment_status_display
    STATE_MAP[treatment_status]
  end

  def current_user_is_office_staff?
    User.current.office_staff?
  end

  def to_s
    patient.full_name if patient
  end

  def ptnt_last_name
    patient.last_name if patient
  end

  def ptnt_first_name
    patient.first_name if patient
  end

  def language_preference_specified?
    treatment_request and treatment_request.language_preference_specified?
  end

  def src
    treatment_request.point_of_origin if treatment_request
  end

  def preferred_gender
     treatment_request ? treatment_request.preferred_gender : nil
  end

  def gender_requirements
    treatment_request ? treatment_request.gender_requirements : nil
  end

  def languages_preferred
    treatment_request ? treatment_request.languages_preferred : nil
  end

  def special_instructions_required
    treatment_request ? treatment_request.special_instructions_required : nil
  end

  def health_agency
    patient.org
  end

  def oasis_eval_or_roc_document
    documents.order("document_date DESC").detect{|d| d.oasis_evaluation? }  #TO Do:: Not yet implemented ROC flow
  end

  def frequencies_for_discipline(discipline)
    visit_frequencies.where(["discipline_id = ?", discipline.id]).reorder("frequency_start_date")
  end

  def current_frequency(visit)
    possible_frequencies = visit_frequencies.select{|f| f.current_frequency?(visit) }
    frequency = possible_frequencies.detect{|x| x.day_frequency? }
    frequency = possible_frequencies.detect{|x| x.week_frequency? } if frequency.nil?
    frequency = possible_frequencies.detect{|x| x.month_frequency? } if frequency.nil?
    frequency
  end

  def previous_frequency_for_discipline(visit_frequency)
    #TODO
    visit_frequency.discipline.present? ?
    visit_frequencies.where(["discipline_id = ?", visit_frequency.discipline.id]).reorder("frequency_start_date").last : nil
  end

  def first_visit_start_date(visit_frequency)
    if visit_frequency.discipline.present?
      visit = treatment_visits.where(["discipline_id = ?", visit_frequency.discipline.id]).first
      return visit.present?? visit.visit_start_date : treatment_start_date
    else
      return treatment_start_date
    end
  end

  def org_week_start_day
    patient.org_week_start_day
  end

  def order_content(last_frequency_detail, current_detail, number_of_visits_missed)
    from_date = last_frequency_detail.visit.visit_start_time.strftime("%m-%d-%Y")
    to_date = (current_detail.visit.visit_start_time.to_date - 1).strftime("%m-%d-%Y")
    content = []
    content << "Visits from #{from_date} to #{to_date} not happen."
    content << "There are #{number_of_visits_missed} visits missed."
    content.join("\n")
  end

  def staffed?
    false
  end

  def fs_and_sc_staffs
    staffs = treatment_staffs.staffed
    treatment_staff_from_sc= staffs.where("staff_type= ?", "Org")
    field_staffs = staffs - treatment_staff_from_sc
    sc_staffs = treatment_staff_from_sc.inject([]){|st, ts| st << ts.staff.staffs}.flatten
    fs_list = field_staffs.inject([]){|r, s|  r << s.staff}
    fs_list.select! do |staff|
      org_user = staff.org_users.find_by_org_id(patient.org.id)
      org_user.present?
    end
    fs_list + sc_staffs
  end

  def discipline_visit_types_list(episode_id)
    disciplines = treatment_disciplines.where(:treatment_episode_id => episode_id).map(&:discipline)
    staffs = treatment_staffs.staffed
    only_visit_type_staffs = staffs.select{|s| s.discipline_id.nil? }
    values = only_visit_type_staffs.collect{|s| [nil, s.visit_type] }
    disciplines.each{|d|
      values += d.visit_types.active_scope(patient.org.id).collect{|v| [d, v]}
    }
    values
  end

  def current_episode
    e = treatment_episodes.detect{|e| Date.current >= e.start_date and Date.current <= e.end_date}
    if e.nil? and treatment_episodes.count == 1
      e = treatment_episodes.first
    end
    e
  end

  def all_disciplines_are_discharged?
    treatment_disciplines.all?{|x| x.discharged? }
  end

  DISCHARGE_REASONS = [['01', 'Discharged to home or self care (routine discharge)'],
                       ['02', 'Discharged/transferred to another short-term general hospital'],
                       ['03', 'Discharged/transferred to skilled nursing facility (SNF)'],
                       ['04', 'Discharged/transferred to an intermediate care facility (ICF)'],
                       ['05', 'Discharged/transferred to another type of institution'],
                       ['06', 'Discharged/transferred to home under care of organized home health service organization'],
                       ['07', 'Left against medical advice'],
                       ['09', 'Admitted as an inpatient to this hospital(Medicare Outpatient Only)'],
                       ['20', 'Expired (or did not recover - Christian Science patient)'],
                       ['30', 'Still a patient'],
                       ['40', 'Expired at home'],
                       ['41', 'Expired in a medical facility'],
                       ['42', 'Expired - place unknown (Medicare Hospice Care Only)'],
                       ['43', 'Discharged to Federal Health Care Facility'],
                       ['50', 'Hospice - Home'],
                       ['51', 'Hospice - Medical Facility'],
                       ['61', 'Discharge to Hospital Based Swing Bed'],
                       ['62', 'Discharged to Inpatient Rehab'],
                       ['63', 'Discharged to Long Term Care Hospital'],
                       ['64', 'Discharged to Nursing Facility'],
                       ['65', 'Discharged to Psychiatric Hospital'],
                       ['66', 'Discharged to Critical Access Hospital'],
                      ]

  NON_MEDICARE_DC_REASONS = [['A', 'Lack of Funds'],
                             ['B', 'Lack of Progress'],
                             ['C', 'Family/Friends Assummed Responsibility'],
                             ['D', 'Patient Moved out of Area'],
                             ['E', 'Patient Refused Service'],
                             ['F', 'Physician Request'],
                             ['G', 'Transferred to Outpatient Rehabilitation']]
  HOLD_REASONS = [['1', 'Hospitalization'], ['2', 'Patient Request'], ['3', 'Physician Request'],['4','Transfer Without Discharge']]
  UNHOLD_REASONS = [['1', 'Return From Hospitalization'], ['2', 'Patient Request'], ['3', 'Physician Request']]




  def initiate_staffing
    treatment_staffs.reject{|s| s.staffed? }.each do |staff|
      staffing_master = self.staffing_masters.create!
      staffing_requirement = staffing_master.staffing_requirements.create!(:discipline => staff.discipline, :visit_type => staff.visit_type)
      staff.staffing_requirement = staffing_requirement
      staff.save!
      staffing_master.broadcast_requirements
    end
    self.save!

  end

  def health_agency_name
    patient.org.to_s
  end

  def active_medications_as_on_date(date)
    medications.select{|m| m.active_as_on_date?(date)}
  end

  def medicare_present?
    treatment_request.medicare_present?
  end


  def first_episode
    treatment_episodes.detect{|e| e.start_date == treatment_start_date}
  end

  def last_episode
    treatment_episodes.order("end_date").last
  end

  def zip_code
    patient.zip_code
  end

  def certification_period
    last_episode.to_s
  end

  def first_lupa_for_treatment?
    result = true
    treatment_episodes.each{|episode|
      episode.receivables.each{|receivable|
        result = false if receivable.invoice and receivable.invoice.invoice_type == '327'
      }
    }
    result
  end

  def previous_episode(episode)
    treatment_episodes.order("end_date DESC").detect{|e| e.end_date == (episode.start_date - 1)}
  end

  def episode_sequence_number(episode)
    episode_ids = treatment_episodes.order("end_date").map(&:id)
    episode_ids.index(episode.id) + 1
  end

  def next_episode(episode)
    treatment_episodes.order("start_date DESC").detect{|e| e.start_date == (episode.end_date + 1)}
  end

  def generate_final_claim_bill
    insurance = treatment_request.insurance_company
    if insurance and insurance.medicare?
      treatment_episodes.last.generate_final_claim_for_episode
    end
  end

  def can_remove_visit_type?(visit_type)
    visit_type_staffs = treatment_staffs.where(["visit_type_id = ? and staff_type = ?", visit_type.id, "User"]).map(&:staff_id)
    not (visit_type_visits_present?(visit_type) or documents_present?(visit_type_staffs) or medical_orders_present?(visit_type_staffs))
  end

  def visit_type_visits_present?(visit_type)
    treatment_visits.where(["visit_type_id = ?", visit_type.id]).size > 0
  end

  def documents_present?(staffs)
    return false if staffs.empty?
    staffs = staffs.join(", ")
    documents.where(["field_staff_id IN (#{staffs}) OR supervised_user_id IN (#{staffs})"]).size > 0
  end

  def medical_orders_present?(staffs)
    return false if staffs.empty?
    staffs = staffs.join(", ")
    medical_orders.where(["field_staff_id IN (#{staffs})"]).size > 0
  end

  def document_definition(document_class_name)
    org = self.patient.org
    template = DocumentFormTemplate.find_by_document_class_name(document_class_name)
    template.document_definitions.org_document_definitions(org.id).first if template
  end

  def primary_physician_name
    primary_physician.full_name
  end

  def staffs_for_treatment(params)
    staffs = treatment_request.get_staffs(params)
    sc_staffs = staffs.select{|x| x.is_a? Org}
    fs_staffs = staffs.select{|x| x.is_a? User}.flatten
    staffs = sc_staffs + fs_staffs
    if params[:treatment_staff_id]
      treatment_staff = treatment_staffs.find(params[:treatment_staff_id]).staff
      staffs << treatment_staff if treatment_staff
    end
    staffs.uniq
  end

  def agency_email
    patient.agency_email
  end

  def patient_reference
    patient.patient_reference
  end

  def patient_name
    patient.full_name
  end

  def insurance_company
    treatment_request.insurance_company
  end

  def medicare?
    treatment_request.medicare?
  end

  def private_insurance?
    treatment_request.private_insurance?
  end

  def number_of_epsiodes
    treatment_episodes.count
  end

  def episode_start_date_is_changed(date)
    self.update_attribute(:treatment_start_date, date)
  end

  def agency
    patient.org
  end

  def print_insurance_company_contact?
    agency.health_agency_detail.print_insurance_address? and private_insurance?
  end

  def transfer_from_hha
    treatment_request.transfer_from_hha.present?
  end

  def soc_date
   self.treatment_start_date.strftime("%m/%d/%Y")
  end

  def episodes_actions
    res = if (User.current.office_staff? && medicare? and treatment_episodes.size == 1)
            [:edit_in_form.action, :del.action]
          elsif (User.current.office_staff? && medicare?)
            [:del.action]
          elsif User.current.office_staff?
            [:add_in_form.action, :edit_in_form.action, :del.action]
          end
  end

  def insurance_bill_type
    treatment_request.insurance_bill_type
  end

  def hourly_rate_for_fs?
    treatment_request.hourly_rate_for_fs?
  end

  def hourly_rate_for_insurance?
    treatment_request.hourly_rate_for_insurance?
  end

  def primary_poc_doc
    poc_docs = documents.where("document_type='PlanOfCare'").order("document_date")
    poc_docs.each do |poc|
      return poc if poc.get_primary_diagnosis_code.present?
    end
    nil
  end

  def episode_period
    self.treatment_request.certification_period || InsuranceCompany.where(["lower(company_code) = ?", TreatmentRequest::DEFAULT_INSURANCE_COMPANY_CODE.downcase]).first.certification_period
  end

  def private_insurance?
    treatment_request.private_insurance?
  end

  def co_signature_optional?
    health_agency.health_agency_detail.co_signature_optional?
  end

  def insurance_number
    treatment_request.insurance_number
  end

  def reset_end_date
    self.update_column(:treatment_end_date, nil)
  end

  private

  def create_face_to_face_medical_order_if_required
      order_type = OrderType.face_to_face(self.patient.org)
      return if self.medical_orders.where(order_type_id: order_type.id).size > 0 or self.undo_process
      order = MedicalOrder.new
      order.treatment = self
      order.treatment_episode = first_episode
      order.physician = primary_physician
      order.created_user = User.current
      order.order_content = " "
      order.order_type = order_type
      order.order_date = treatment_start_date
      order.save!
  end

  def hold_all_disciplines
    treatment_disciplines.each{|td| td.hold! if td.may_hold? }
  end

  def active_all_disciplines
    treatment_disciplines.each{|td| td.unhold! if td.may_unhold? }
  end

  def create_episode
    return if self.undo_process
    self.treatment_episodes.clear
    period = self.treatment_request.certification_period || InsuranceCompany.where(["lower(company_code) = ?", TreatmentRequest::DEFAULT_INSURANCE_COMPANY_CODE.downcase]).first.certification_period
    episode = self.treatment_episodes.build(:start_date => treatment_start_date, :end_date => (treatment_start_date - 1) + period)
    self.save!
    treatment_disciplines.update_all(:treatment_episode_id => episode.id)
  end

  def update_patient_from_request
    self.patient = treatment_request.patient if treatment_request
  end

  def revert_user_viewing_changed_attr
    self.treatment_status = self.user_viewing_changed_attr_value if self.user_viewing_changed_attr_value
  end

  def reset_claims
    list = treatment_episodes.last.invoices.where("invoice_type IN (?)", ["327", "329"])
    list.each do |invoice|
      invoice.reset_final_claim
    end
  end

  def all_disciplines_are_in_pending_evaluation?
    treatment_disciplines.all?{|td| td.pending_evaluation? } and system_driven_event?
  end

end
