# == Schema Information
#
# Table name: staffing_request_visit_types
#
#  id                  :integer          not null, primary key
#  staffing_request_id :integer          not null
#  visit_type_id       :integer          not null
#  request_status      :string(1)        default("N"), not null
#

class StaffingRequestVisitType < ActiveRecord::Base

end
