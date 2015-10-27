# == Schema Information
#
# Table name: org_contacts
#
#  id                 :integer          not null, primary key
#  contact_first_name :string(100)      not null
#  contact_last_name  :string(100)      not null
#  phone_number       :string(15)       not null
#  extension          :string(10)
#  email              :string(100)      not null
#  org_id             :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  contact_type_id    :integer          not null
#  lock_version       :integer          default(0)
#

class OrgContact < ActiveRecord::Base
  belongs_to :org
  belongs_to :contact_type
  validates :contact_first_name, presence: true
  validates :contact_last_name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true

  before_create :set_contact_type

  audited :associated_with => :org, :allow_mass_assignment => true
  has_associated_audits

  def full_name
    "#{contact_first_name} #{contact_last_name}"
  end

  def set_contact_type
    self.contact_type = ContactType.find_by_type_name("Authorized Representative")
  end

end
