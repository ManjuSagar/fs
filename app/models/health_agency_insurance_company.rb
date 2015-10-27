# == Schema Information
#
# Table name: ha_insurance_companies
#
#  id                   :integer          not null, primary key
#  provider_number      :string(15)       not null
#  health_agency_id     :integer          not null
#  insurance_company_id :integer          not null
#  lock_version         :integer          default(0)
#

class HealthAgencyInsuranceCompany < ActiveRecord::Base
  set_table_name "ha_insurance_companies"

  belongs_to :health_agency
  belongs_to :insurance_company

  audited :associated_with => :health_agency, :allow_mass_assignment => true

end
