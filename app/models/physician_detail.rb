# == Schema Information
#
# Table name: physician_details
#
#  id           :integer          not null, primary key
#  npi_number   :string(15)       not null
#  physician_id :integer
#  lock_version :integer          default(0)
#  fax_number   :string(15)
#

class PhysicianDetail < ActiveRecord::Base
  belongs_to :physician
  validates :npi_number, :presence => true, length: {:minimum => 10, :maximum => 10}
  validates :fax_number, length: {maximum: 15}
  audited :associated_with => :physician, :allow_mass_assignment => true

end
