# == Schema Information
#
# Table name: visit_frequency_field_staffs
#
#  id             :integer          not null, primary key
#  frequency_id   :integer          not null
#  field_staff_id :integer          not null
#  lock_version   :integer          default(0)
#

class VisitFrequencyFieldStaff < ActiveRecord::Base
  belongs_to :visit_frequency, :foreign_key => :frequency_id
  belongs_to :field_staff
end
