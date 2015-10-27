# == Schema Information
#
# Table name: treatment_vitals
#
#  id                 :integer          not null, primary key
#  systolic_bp        :integer
#  diastolic_bp       :integer
#  bp_read_position   :string(1)
#  heart_rate         :integer
#  respiration_rate   :integer
#  temperature_in_fht :float
#  blood_sugar        :integer
#  sugar_read_period  :string(1)
#  weight_in_lbs      :integer
#  oxygen_saturation  :integer
#  treatment_id       :integer          not null
#  visit_id           :integer
#  recorded_date_time :datetime
#  recorded_user_id   :integer          not null
#  bp_read_location   :string(1)
#  remarks            :text
#  pain               :integer
#

class TreatmentVital < ActiveRecord::Base
  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :visit, :class_name => "TreatmentVisit"

  default_scope order(:recorded_date_time)

  before_create :set_defaults
  before_save :set_remarks
  audited :associated_with => :treatment, :allow_mass_assignment => true

  def set_defaults
   self.recorded_user_id = User.current.id
   self.recorded_date_time = Time.current
  end

  validate :systolic_bp_check

  BP_POSITION =  [['', '---'], ['S','Sitting'], ['T', 'Standing'], ['L', 'Lying']]
  BP_LOCATION = [['', '---'], ['L', 'Left Arm'], ['R', 'Right Arm']]
  SUGAR_READ_PERIOD = [['', '---'], ['F', 'Fasting'], ['R', 'Random']]

  def systolic_bp_check
    unless ((systolic_bp.present? and diastolic_bp.present? and bp_read_position.present? and bp_read_location.present?) ||
        (systolic_bp.present? == false and diastolic_bp.present? ==false and bp_read_position.present? == false and bp_read_location.present? == false))
      self.errors.add(:systolic_bp, " is required.") unless systolic_bp.present?
      self.errors.add(:diastolic_bp, " is required.") unless diastolic_bp.present?
      self.errors.add(:bp_read_position, " is required." ) unless bp_read_position.present?
      self.errors.add(:bp_read_location, " is required." ) unless bp_read_location.present?
    end
  end

  def get_vitals_reference_range(vital_sign)
    treatment.patient.org.vitals_reference_ranges.find_by_vital_sign(vital_sign)
  end

  def fasting_blood_sugar
    blood_sugar if self.sugar_read_period == 'F'  || self.sugar_read_period == ' ' and blood_sugar.present?
  end

  def random_blood_sugar
    blood_sugar if self.sugar_read_period == 'R' and blood_sugar.present?
  end

  def set_remarks
    removable_attrs = ['bp_read_position', 'sugar_read_period', 'bp_read_location', 'treatment_id', 'id', 'visit_id', 'recorded_date_time', 'recorded_user_id', 'remarks']
    vital_attrs = TreatmentVital.attribute_names.reject{|x| removable_attrs.include?(x)}
    vital_remarks = []
    vital_attrs.each do |vital_sign|
      if vital_sign == 'blood_sugar'
        vital_sign_for_sugar = (sugar_read_period == 'F') ? "fasting_blood_sugar" : "random_blood_sugar"
      end

      vt_sign = get_vitals_reference_range(vital_sign_for_sugar || vital_sign)
      if vt_sign
        vital_sign_value = self.send(vital_sign)
        if vital_sign_value
          if vt_sign.minimum_value
            if vital_sign_value < vt_sign.minimum_value
              vital_remarks << "#{vital_sign.titleize} is #{vital_sign_value} which is less than the minimum value (#{vt_sign.minimum_value})."
            end
          end
          if vt_sign.maximum_value
            if vital_sign_value > vt_sign.maximum_value
              vital_remarks << "#{vital_sign.titleize} is #{vital_sign_value} which is greater than the maximum value (#{vt_sign.maximum_value})."
            end
          end
        end
      end
    end
      self.remarks = vital_remarks.join("\n")
  end



end
