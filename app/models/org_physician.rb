# == Schema Information
#
# Table name: org_physicians
#
#  id                      :integer          not null, primary key
#  org_id                  :integer          not null
#  physician_id            :integer          not null
#  personal_phone_number_1 :string(255)
#  personal_phone_number_2 :string(255)
#

class OrgPhysician < ActiveRecord::Base
  belongs_to :org
  belongs_to :physician

  before_create :save_details, :set_org, unless: :skip_callbacks
  validate :check_physician, if: :new_record?
  validates :npi_number, :presence => true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true
  #after_save  :assign_org


  netzke_attribute :first_name
  netzke_attribute :last_name
  netzke_attribute :npi_number
  netzke_attribute :pecos_verification

  attr_accessor :first_name, :last_name, :npi_number,
                :physician_record, :pecos_verification, :skip_callbacks
  audited :associated_with => :org, :allow_mass_assignment => true
  scope :org_scope, -> {where(org_id: Org.current.id) if Org.current}

  validates :street_address, length: {maximum: 50}
  validates :suite_number, length: {maximum: 10}
  validates :city, length: {maximum: 50}
  validates :zip_code, length: {maximum: 5}
  validates :suffix, length: {maximum: 10}

  def save_details
    physician = Physician.where(npi_number: npi_number).first
    if physician.present?
      @physician_record = physician
    else
      physician = Physician.new
      physician.first_name =  first_name
      physician.last_name = last_name
      physician.email = nil
      physician.npi_number = npi_number
      physician.pecos_verification = pecos_verification
      physician.save!
      physician.reload
      @physician_record = physician
    end
  end

  def assign_org
    physician = self.physician
    physician.orgs << (FacilityOwner.first if Org.current.is_a? HealthAgency) unless physician.orgs.include? FacilityOwner.first
    nil
  end

  def set_org
    self.org = Org.current
    self.physician_id = physician_record.id
  end

  def check_physician
    org_phy = OrgPhysician.where("physician_id in (select id from users where npi_number = ? )",
                                 self.npi_number).where("org_id = ?", Org.current.id)
    self.errors.add(:base, "This Physician already exists") unless org_phy.empty?
  end

end
