# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  first_name              :string(100)      not null
#  last_name               :string(100)      not null
#  suite_number            :string(15)
#  street_address          :string(50)
#  city                    :string(50)
#  state                   :string(2)
#  zip_code                :string(10)
#  phone_number            :string(15)
#  user_type               :string(50)
#  lock_version            :integer          default(0)
#  approved                :boolean          default(FALSE), not null
#  gender                  :string(1)
#  signature_file_name     :string(255)
#  signature_content_type  :string(255)
#  signature_file_size     :integer
#  signature_updated_at    :datetime
#  middle_initials         :string(2)
#  suffix                  :string(10)
#  ethnicity               :string(20)
#  encrypted_sign_password :string(255)
#

class Caregiver < User
  has_many :patient_caregivers, :class_name => "PatientCaregiver", :dependent => :destroy
  has_many :patients, :through => :patient_caregivers

  before_validation :set_random_password, :set_random_email, :set_defaults, :on => :create

  validates :phone_number, presence: true

  def set_random_password
    self.password = self.password_confirmation = Time.current.to_f
  end

  def set_defaults
    self.last_name = "." unless self.last_name.present?
  end

  def set_random_email
    random_string = Array.new(6){rand(36).to_s(36)}.join
    self.email = "#{first_name}#{last_name}#{random_string}@fasternotes.com"
  end


end
