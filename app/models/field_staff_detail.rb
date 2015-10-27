# == Schema Information
#
# Table name: field_staff_details
#
#  id                         :integer          not null, primary key
#  field_staff_id             :integer          not null
#  license_type_id            :integer          not null
#  lock_version               :integer          default(0)
#  license_number             :string(10)
#  coverage_areas             :text
#  review_agency_changes_flag :boolean          default(FALSE)
#

class FieldStaffDetail < ActiveRecord::Base
  belongs_to :field_staff
  belongs_to :license_type
  validates :license_number, :length => {:maximum => 10}
  validates :license_type, :presence => true
    
  store :coverage_areas, :accessors => ["areas_covered"]

  audited :associated_with => :field_staff, :allow_mass_assignment => true
    
end
