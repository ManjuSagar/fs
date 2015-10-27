# == Schema Information
#
# Table name: treatment_request_staffs
#
#  id                       :integer          not null, primary key
#  request_id               :integer          not null
#  staff_type               :string(100)
#  staff_id                 :integer
#  discipline_id            :integer
#  visit_type_id            :integer
#  lock_version             :integer          default(0), not null
#  apply_patient_preference :string(1)
#  staffing_requirement_id  :integer
#

class TreatmentRequestStaff < ActiveRecord::Base
  belongs_to :treatment_request, :class_name => "TreatmentRequest", :foreign_key => :request_id
  belongs_to :staff, :polymorphic => true
  belongs_to :discipline
  belongs_to :visit_type
  belongs_to :staffing_requirement
  audited :associated_with => :treatment_request, :allow_mass_assignment => true

  after_save :update_denormalized_patient_list

  APPLY_PATIENT_PREFERENCE = '0'
  DONT_APPLY_PATIENT_PREFERENCE = '1'

  after_initialize :set_defaults, :if => :new_record?

  validate :check_requirements_are_present

  def staff_name
    if staffed?
      staff.phone_number.present? ?  "#{self.staff.full_name} - #{self.staff.phone_number}" : self.staff.full_name
    end
  end

  def discipline_description
    discipline.discipline_description if discipline
  end

  def visit_type_description
    visit_type.visit_type_description if visit_type
  end

  def to_s
    if discipline and visit_type
      "#{discipline.discipline_description} - #{visit_type.visit_type_description}"
    elsif visit_type
      "#{visit_type.visit_type_description}"
    elsif discipline
      "#{discipline.discipline_description}"
    end
  end

  def staffed?
    staff_id.present? #staff.nil? == false
  end

  def self.get_visit_type(request_staff_id)
    find(request_staff_id).visit_type
  end

  def update_denormalized_patient_list
    patient = treatment_request.patient
    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id)
      DenormalizedPatientList.update_with(patient) if d.present?
  end

  private

  def check_requirements_are_present
    self.errors.add(:base, "Requirements can't be blank") if discipline.nil? and visit_type.nil?
  end

  def set_defaults
    self.apply_patient_preference = APPLY_PATIENT_PREFERENCE
  end
end
