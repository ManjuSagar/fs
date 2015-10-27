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

class LiteFieldStaff < FieldStaff
  # To change this template use File | Settings | File Templates.
  has_many :staffing_company_users, :class_name => "StaffingCompanyUser", :dependent => :destroy, foreign_key: :user_id
  has_many :staffing_companies, :through => :staffing_company_users

  before_validation :set_defaults, :set_random_password, if: :new_record?
  before_create :set_approved_flag_lite_field_staff
  attr_accessible :license_number

  def set_defaults
    self.email = "#{first_name}@#{license_number}.com"
  end

  def set_random_password
    self.password = self.password_confirmation = Time.current.to_f
  end

  def set_approved_flag_lite_field_staff
    self.approved = false
    nil
  end

  def associate_to_ha
  end

  def upgrade_to_a_full_fledged_field_staff(email)
    self.email = email
    self.user_type = "FieldStaff"
    self.reset_password
    self.approved = true
    self.save!
  end

  def reset_password
    self.password = self.password_confirmation = Array.new(6){rand(36).to_s(36)}.join
    spawn_block do
      FasternotesMailer.fasternotes_user_access_information(self).deliver
    end
  end

  def send_activation_email?
    false
  end


end
