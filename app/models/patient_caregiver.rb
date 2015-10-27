# == Schema Information
#
# Table name: patient_caregivers
#
#  id                  :integer          not null, primary key
#  patient_id          :integer          not null
#  caregiver_id        :integer          not null
#  relation_to_patient :string(50)       not null
#  primary_flag        :boolean          not null
#  lock_version        :integer          default(0)
#

class PatientCaregiver < ActiveRecord::Base
  belongs_to :patient
  belongs_to :caregiver

  before_save :save_caregiver
  before_create :set_defaults
  after_validation :check_errors

  netzke_attribute :first_name
  netzke_attribute :last_name
  netzke_attribute :phone_number

  validates :relation_to_patient, presence: true
  validates :relation_to_patient, length: {:maximum => 50}
  delegate :first_name, :first_name=, :last_name, :last_name=, :phone_number, :phone_number=, :to => :caregiver

  audited :associated_with => :patient, :allow_mass_assignment => true

  def to_s
    "#{caregiver.full_name}"
  end

  def caregiver_with_build
    caregiver_without_build || build_caregiver
  end
  alias_method_chain :caregiver, :build

  def save_caregiver
    caregiver.save! if caregiver.changed?
  end

  def set_defaults
    self.primary_flag = true
  end

  def check_errors
    unless caregiver.valid?
      caregiver.errors.each do |k, v|
        self.errors.add(k, v)
      end
    end
  end

end
