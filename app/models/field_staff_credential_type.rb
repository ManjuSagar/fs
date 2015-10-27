# == Schema Information
#
# Table name: field_staff_credential_types
#
#  id             :integer          not null, primary key
#  ct_code        :string(15)       not null
#  ct_description :string(100)      not null
#  expiry_flag    :boolean          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lock_version   :integer          default(0)
#  discipline_id  :integer
#

class FieldStaffCredentialType < ActiveRecord::Base
  belongs_to :discipline

  DISCIPLINE = [['PT', 'Physio Therapy'], ['OT', 'Operation Therapy'], ['N', 'Nursing']]

  before_save :set_expiry_flag

  audited :associated_with => :discipline, :allow_mass_assignment => true

  validates :ct_code, presence: true, length: {maximum: 15}
  validates :ct_description, presence: true, length: {maximum: 100}


  def set_expiry_flag
    self.expiry_flag = false unless self.expiry_flag
    true
  end
end
