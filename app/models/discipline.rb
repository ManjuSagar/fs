# == Schema Information
#
# Table name: disciplines
#
#  id                     :integer          not null, primary key
#  discipline_code        :string(15)       not null
#  discipline_description :string(100)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  lock_version           :integer          default(0)
#

class Discipline < ActiveRecord::Base
  has_many :license_types, :dependent => :destroy
  has_many :visit_types
  has_many :field_staff_credential_types

  validates :discipline_code, :presence => true, :length => {:maximum => 15}
  validates :discipline_description, :presence => true, :length => {:maximum => 100}
  validates :sort_order, :presence => true


  scope :default_scope, order("sort_order")

  audited :allow_mass_assignment => true


  COMBO_STORE_DISPLAY = Discipline.all.collect{|d| [d.id, d.discipline_code] }.unshift(['', "---"])

  DISCIPLINE_DESCRIPTION_COMBO_STORE_DISPLAY = Discipline.all.collect{|d| [d.id, d.discipline_description] }.unshift(['', "---"])

  def to_s
    discipline_code
  end
end
