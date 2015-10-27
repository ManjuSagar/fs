# == Schema Information
#
# Table name: license_types
#
#  id                       :integer          not null, primary key
#  discipline_id            :integer          not null
#  license_type_code        :string(5)        not null
#  license_type_description :string(50)       not null
#  independent_flag         :boolean
#  lock_version             :integer          default(0)
#

class LicenseType < ActiveRecord::Base
  belongs_to :discipline
  has_and_belongs_to_many :visit_types

  audited :associated_with => :discipline, :allow_mass_assignment => true

  validates :license_type_code, :presence => true, :length => {:maximum => 5}
  validates :license_type_description, :presence => true, :length => {:maximum => 50}
  validates :discipline, :presence => true

  TYPE_STORE = self.all.collect{|l| [l.id, l.license_type_code]}.unshift(["", "---"])

  def to_s
    license_type_description
  end

  def independent?
    independent_flag == true
  end
end
