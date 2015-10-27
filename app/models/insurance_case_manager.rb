class InsuranceCaseManager < ActiveRecord::Base
  belongs_to :insurance_company

  audited :associated_with => :insurance_company, :allow_mass_assignment => true

  def full_name
    "#{first_name} #{last_name} #{phone_number}"
  end

  def name
    "#{first_name} #{last_name}"
  end
end