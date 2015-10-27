# == Schema Information
#
# Table name: treatment_staffs
#
#  id                       :integer          not null, primary key
#  treatment_id             :integer          not null
#  staff_type               :string(100)
#  staff_id                 :integer
#  discipline_id            :integer
#  visit_type_id            :integer
#  lock_version             :integer          default(0), not null
#  apply_patient_preference :string(1)
#  staffing_requirement_id  :integer
#  co_pay_amt               :decimal(8, 2)
#

class TreatmentStaff < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :staff, :polymorphic => true
  belongs_to :discipline
  belongs_to :visit_type
  belongs_to :staffing_requirement
  audited :associated_with => :treatment, :allow_mass_assignment => true
  before_save :set_system_assigned_flag_if_required

  after_initialize :set_defaults, :if => :new_record?
  APPLY_PATIENT_PREFERENCE = '0'
  DONT_APPLY_PATIENT_PREFERENCE = '1'

  scope :staffed, lambda { where("treatment_staffs.staff_id is not null") }

  scope :org_scope, lambda{ includes({:treatment => {:patient => :patient_detail}}).where({:patient_details => {:org_id => Org.current.id}}) }
  scope :not_clinical_staff, lambda{|treatment_ids| org_scope.where("treatment_id = '#{treatment_ids.first}' and system_assigned='false'")}

  validate :check_requirements_are_present

  def staff_name
    if staffed?
      staff.phone_number.present? ?  "#{self.staff.full_name} - #{self.staff.phone_number}" : self.staff.full_name
    end
  end

  def staff_short_name
    if staffed?
      self.staff.full_name
    end
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

  def set_system_assigned_flag_if_required
    treatment_staff = treatment.treatment_staffs.where(:discipline_id => discipline_id, staff_id: staff_id, visit_type_id: visit_type_id, system_assigned: true).limit(1)
    if treatment_staff.present?
      treatment_staff.destroy_all
    end
  end

  def discipline_description
    discipline.discipline_description if discipline
  end

  def visit_type_description
    visit_type.visit_type_description if visit_type
  end

  def staffed?
    staff.nil? == false
  end

  def copay_amount
    number_to_currency(co_pay_amt, :format => "%n")
  end

  def self.get_visit_type(treatment_staff_id)
    find(treatment_staff_id).visit_type
  end

  def staff_phone_number
    staff.phone_number
  end

  private

  def check_requirements_are_present
    self.errors.add(:base, "Requirements can't be blank") if discipline.nil? and visit_type.nil?
  end

  def set_defaults
    self.apply_patient_preference = APPLY_PATIENT_PREFERENCE
  end
end
