# == Schema Information
#
# Table name: staffing_company_credential_types
#
#  id             :integer          not null, primary key
#  ct_code        :string(15)       not null
#  ct_description :string(100)      not null
#  expiry_flag    :boolean          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lock_version   :integer          default(0)
#

class StaffingCompanyCredentialType < ActiveRecord::Base
  before_save :set_expiry_flag
  
  validates :ct_code, presence: true, length: {maximum: 15}
  validates :ct_description, presence: true, length: {maximum: 100}

  audited :allow_mass_assignment => true

  def set_expiry_flag
    self.expiry_flag = false unless self.expiry_flag
    true
  end
  
end
