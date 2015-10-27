# == Schema Information
#
# Table name: staffing_requests
#
#  id                       :integer          not null, primary key
#  staff_type               :string(100)      not null
#  staff_id                 :integer          not null
#  requested_date_time      :datetime         not null
#  request_status           :string(1)        not null
#  lock_version             :integer          default(0)
#  staffing_requirement_id  :integer          not null
#  discipline_id            :integer
#  visit_type_id            :integer
#  apply_patient_preference :string(1)
#

class InternalStaffingRequest < StaffingRequest
end
