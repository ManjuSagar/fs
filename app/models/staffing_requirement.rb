# == Schema Information
#
# Table name: staffing_requirements
#
#  id                 :integer          not null, primary key
#  staffing_master_id :integer          not null
#  discipline_id      :integer
#  visit_type_id      :integer
#  staffing_status    :string(1)        not null
#  lock_version       :integer          default(0), not null
#

class StaffingRequirement < ActiveRecord::Base
  belongs_to :staffing_master
  belongs_to :discipline
  belongs_to :visit_type
  has_many :staffing_requests, :dependent => :destroy
  has_many :request_staffs, :class_name => "TreatmentRequestStaff"
  has_many :treatment_staffs, :class_name => "TreatmentStaff"
  before_save :save_staffing_master_if_required
  netzke_attribute :narrative

  audited :associated_with => :staffing_master, :allow_mass_assignment => true
  has_associated_audits

  after_validation :raise_errors_if_any

  delegate :narrative, :narrative=, :staffable_id, :staffable_id=, :to => :staffing_master

  def raise_errors_if_any
    if discipline.nil? and visit_type.nil?
      self.errors.add(:base, "Atleast one Discipline or Visit Type required")
    end

  end


  include AASM
  STATE_MAP = {:draft => 'D', :pending_staffing => 'P', :staffed => 'A'}

  aasm :column => :staffing_status do
    state :draft, :initial => true
    state :pending_staffing, :after_enter => :broadcast
    state :staffed, :after_enter => :reject_unselected_staffs

    event :broadcast_request do
      transitions :to => :pending_staffing, :from => :draft
    end

    event :finalize_staffing do
      transitions :to => :staffed, :from => :pending_staffing, :guard => :staffed?
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :staffing_status
    write_attribute_without_mapping(attr, v)
  end

  def staffing_status
    STATE_MAP.invert[read_attribute(:staffing_status)]
  end

  def staffing_master_with_build
    staffing_master_without_build || build_staffing_master(:staffable_type => "PatientTreatment")
  end

  alias_method_chain :staffing_master, :build

  def save_staffing_master_if_required
    staffing_master.save! if staffing_master.changed?
  end

  def qualified_resources
    preferred_languages = language_preference_specified? ? patient.languages : nil
    preferred_gender =  staffing_master.staffable.preferred_gender
    patient_address = patient.address_string
    debug_log "Patient -Address = #{patient_address}"
    field_staff_list = FieldStaff.qualified_field_staff_list_for_staffing(discipline, visit_type, false,  preferred_languages, preferred_gender, patient_address)
    sc_list = StaffingCompany.qualified_sc_list_for_staffing(discipline, visit_type, false,  preferred_languages, preferred_gender, patient_address)
    field_staff_list + sc_list
  end

  def allocate_staff(staffing_request)
    staffable = staffing_master.staffable
    if staffable.is_a? TreatmentRequest
      allocate_referral_staff(staffing_request)
    else
      allocate_treatment_staff(staffing_request)
    end
  end

  def allocate_referral_staff(staffing_request)
    rec = find_request_staffs({discipline_id: staffing_request.discipline_id, visit_type_id: staffing_request.visit_type_id,
                              staff_id: nil}).first
    if rec
      rec.update_attributes!(:staff => staffing_request.staff)
    else
      request_staffs.create!(:treatment_request => staffing_master.staffable, :staff => staffing_request.staff,
                             :discipline => staffing_request.discipline, :visit_type => staffing_request.visit_type)
    end
  end

  def allocate_treatment_staff(staffing_request)
    rec = find_treatment_staffs({discipline_id: staffing_request.discipline_id, visit_type_id: staffing_request.visit_type_id,
                                staff_id: nil}).first
    if rec
      rec.update_attributes!(:staff => staffing_request.staff)
    else
      treatment_staffs.create!(:treatment => staffing_master.staffable, :staff => staffing_request.staff,
                             :discipline => staffing_request.discipline, :visit_type => staffing_request.visit_type)
    end
  end

  def deallocate_staff(staffing_request)
    staffable = staffing_master.staffable
    if staffable.is_a? TreatmentRequest
      deallocate_referral_staff(staffing_request)
    else
      deallocate_treatment_staff(staffing_request)
    end
  end

  def deallocate_treatment_staff(staffing_request)
    staffs = find_treatment_staffs({discipline_id: staffing_request.discipline_id, visit_type_id: staffing_request.visit_type_id,
                                 staff_id: staffing_request.staff_id})
    if (treatment_staffs.size > 1 and staffs.size < treatment_staffs.size)
      staffs.first.destroy
    else
      treatment_staff = staffs.first
      treatment_staff.staff = nil
      treatment_staff.save!
    end
  end

  def deallocate_referral_staff(staffing_request)
    staffs = find_request_staffs({discipline_id: staffing_request.discipline_id, visit_type_id: staffing_request.visit_type_id,
                                staff_id: staffing_request.staff_id})
    if (request_staffs.size > 1 and staffs.size < request_staffs.size)
      staffs.first.destroy
    else
      request_staff = staffs.first
      request_staff.staff = nil
      request_staff.save!
    end
  end

  def find_request_staffs(params)
    request_staffs.where(sql_string(params))
  end

  def find_treatment_staffs(params)
    treatment_staffs.where(sql_string(params))
  end

  def sql_string(params)
    sql_str = "discipline_id "
    sql_str += params[:discipline_id] ? "= #{params[:discipline_id]}" : "is NULL"
    sql_str += " AND visit_type_id "
    sql_str += params[:visit_type_id] ? "= #{params[:visit_type_id]}" : "is NULL"
    sql_str += " AND staff_id "
    sql_str += params[:staff_id] ? "= #{params[:staff_id]}" : "is NULL"
    sql_str
  end

  def reject_unselected_staffs
    staffing_requests.each do |staff|
      if staff.may_cancel? and (not staff.selected?)
        staff.cancel!
      end
      staff.staff_finalized = true
      staff.save!
    end
  end

  def to_s
    if discipline and visit_type
      "#{discipline.discipline_description} - #{visit_type.visit_type_description}"
    elsif visit_type
      "#{visit_type.visit_type_description}"
    else
      "#{discipline.discipline_description}"
    end
  end

  def staffed?
    staffing_master.staffable.staffed? || staffing_requests.any?{|s| s.selected? }
  end

  def broadcast
    qualified_resources.each do |s|
      staffing_requests.build(:staff => s, :discipline => discipline, :visit_type => visit_type)
    end
    self.save!
    if staffing_master.staffable and staffing_master.staffable.is_a?(PatientTreatment)
      staffing_master.send_email_notifications
    end
  end

  def send_email_notifications
    spawn_block do
      staffing_requests.each {|sr| sr.send_email_notification }
    end
  end

  def language_preference_specified?
    staffing_master.language_preference_specified?
  end

  def gender_requirements
    staffing_master.gender_requirements
  end

  def languages_preferred
    staffing_master.languages_preferred
  end

  def health_agency
    staffing_master.health_agency
  end

  def special_instructions_required
    staffing_master.special_instructions_required
  end

  def patient
    staffing_master.patient
  end

end
