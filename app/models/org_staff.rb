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

class OrgStaff < User
  before_save :save_signatures
  after_initialize :set_role_type, :unless => :new_record?
  before_create :assign_org
  after_save :update_role_type, :unless => :new_record?
  after_save :update_user_status
  after_initialize :set_user_status
  after_validation :check_signature_and_sign_password_present, :unless => :new_record?

  attr_accessor :org_staff_signature_data, :role_type, :user_status, :org_id, :zip_code_part2

  netzke_attribute :org_staff_signature_data
  netzke_attribute :role_type
  netzke_attribute :user_status, type: :boolean
  netzke_attribute :org_id

  scope :user_scope, lambda{where(:id => User.current.id) if User.current}

  private

  def update_role_type
    if self.role_type
      os = OrgUser.unscoped.find_by_user_id self.id
      os.role_type = self.role_type
      os.save!
    end
  end

  def assign_org
    self.org_users.build(:org_id => self.org_id, :role_type => self.role_type)
  end

  def save_signatures
    if org_staff_signature_data
      file = Tempfile.new(["signature", ".png"])
      file.binmode
      require 'base64'
      file.write(Base64.decode64(org_staff_signature_data))
      file.close
      file = File.open(file.path)
      self.signature = file
    end
  end

  def set_role_type
    os = OrgUser.unscoped.find_by_user_id self.id unless new_record?
    self.role_type = os.role_type if os
  end

  def set_user_status
    os = OrgUser.unscoped.find_by_user_id self.id unless new_record?
    if os
      self.user_status = os.user_status == :active
    end
  end

  def update_user_status
    org_user = OrgUser.unscoped.find_by_user_id self.id
    org_user.user_status = (self.user_status == true)? 'A' : 'D'
    org_user.save!
    nil
  end

  def check_signature_and_sign_password_present
    if User.current == self
      errors.add(:base, "Signature is required") if self.org_staff_signature_data.nil? and (not self.signature?)
      errors.add(:base, "Sig Password is required") if self.sign_password.nil? and self.encrypted_sign_password.nil?
    end
  end

end
