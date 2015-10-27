# == Schema Information
#
# Table name: treat_staffing_companies
#
#  id                  :integer          not null, primary key
#  treatment_id        :integer          not null
#  staffing_company_id :integer          not null
#  lock_version        :integer          default(0)
#

class TreatmentStaffingCompany < ActiveRecord::Base
  set_table_name "treat_staffing_companies"

  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :staffing_company
  audited :associated_with => :treatment, :allow_mass_assignment => true

end
