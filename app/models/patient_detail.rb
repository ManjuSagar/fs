# == Schema Information
#
# Table name: patient_details
#
#  id                :integer          not null, primary key
#  medicare_number   :string(50)
#  medicaid_number   :string(50)
#  height            :integer
#  height_unit       :string(1)
#  weight            :integer
#  weight_unit       :string(1)
#  dob               :date             not null
#  ssn               :string(11)
#  marital_status    :string(1)
#  gender            :string(1)        not null
#  patient_id        :integer          not null
#  org_id            :integer
#  lock_version      :integer          default(0)
#  patient_reference :string(20)       not null
#

class PatientDetail < ActiveRecord::Base
  belongs_to :patient
  belongs_to :org

  scope :my_org_patients, lambda { where({:org_id => Org.current.id})}
  before_validation :set_units, :on => :create
  before_validation :reset_medicare_number
  before_create :generate_reference
  #validates :marital_status, :presence => true
  validates :dob, :presence => true
  validates :gender, :presence => true
  validates :ssn, :presence => true, :length => {:maximum => 11}
  validate :medicare_number_regex
  #validates :height, :format => { :with => /[0-9]/}
  #validates :weight, :numericality => true
  validate :check_dob
  validate :check_patient_reference_uniqness, :if => :new_record?

  before_create :set_org

  audited :associated_with => :patient, :allow_mass_assignment => true

  def check_dob
    unless dob.nil?
      if dob > Date.today
        errors.add(:dob, " is invalid.")
      end
    end
  end

  def get_sys_gen_seq_num(sequence)
    org_mr_num_start_with = Org.current.health_agency_detail.mr_num_start_with
    if org_mr_num_start_with
      org_mr_num_start_with = org_mr_num_start_with.to_i
      (sequence.to_i > org_mr_num_start_with) ? sequence : org_mr_num_start_with
    else
      sequence
    end
  end

  private

  def check_patient_reference_uniqness
    existing_record = self.class.find(:first, :conditions => ["org_id = ? AND patient_reference = ?", Org.current.id, patient_reference.to_s])
    unless existing_record.blank?
      errors.add(:base, "MR # already exists.")
    end
  end

  def reset_medicare_number
    self.medicare_number = medicare_number.split("_").first if medicare_number
  end

  def medicare_number_regex
    unless medicare_number.nil?
      if medicare_number.match(/^[a-zA-z]{1}/)
        errors.add(:medicare_number, "If the first character is a letter, then there must be 1 to 3 alphabetic characters followed by 6 or 9 numbers followed by spaces up to the field length of 12.") unless medicare_number =~ /^([a-zA-Z]){3}([0-9]{6}|[0-9]{9})(\s){0,3}$/
      elsif medicare_number.match(/^([0-9]){1}/)
        errors.add(:medicare_number, "If the first character is numeric (0 through 9), then the first 9 characters must be numeric") unless medicare_number =~ /[0-9]{9}(\d|[A-Za-z]){0,3}/
      end
   end
  end

  def set_org
    self.org = Org.current
  end

  def set_units
    self.weight_unit = "l"
    self.height_unit = "c"
  end

  def generate_reference
    sys_generated_seq = get_sys_gen_seq_num(PatientReferenceNumber.next_sequence(self))
    sys_generated_seq += 1 if sys_generated_seq.to_i == Org.current.health_agency_detail.mr_num_start_with.to_i
    if patient_reference.present?
      if sys_generated_seq != self.patient_reference
        sys_generated_seq = self.patient_reference.to_i + 1 if self.patient_reference.to_i > sys_generated_seq.to_i
        PatientReferenceNumber.decrement_sequence(sys_generated_seq.to_i - 1)
      end
    else
      begin
        self.patient_reference = sys_generated_seq
      rescue Exception => e
        raise e
      end
    end
  end

end
