# == Schema Information
#
# Table name: license_types_visit_types
#
#  id              :integer          not null, primary key
#  license_type_id :integer          not null
#  visit_type_id   :integer          not null
#  lock_version    :integer          default(0), not null
#

class LicenseTypesVisitType < ActiveRecord::Base
  belongs_to :license_type
  belongs_to :visit_type

  audited :associated_with => :license_type, :allow_mass_assignment => true
end
