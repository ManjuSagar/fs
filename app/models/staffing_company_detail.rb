# == Schema Information
#
# Table name: staffing_company_details
#
#  id                  :integer          not null, primary key
#  staffing_company_id :integer          not null
#  created_org_id      :integer          not null
#  lock_version        :integer          default(0)
#

class StaffingCompanyDetail < ActiveRecord::Base
  belongs_to :staffing_company
  belongs_to :created_org, :class_name => "Org"
  audited :associated_with => :staffing_company, :allow_mass_assignment => true

end
