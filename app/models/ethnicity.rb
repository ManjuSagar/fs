# == Schema Information
#
# Table name: ethnicities
#
#  id          :string(2)        not null, primary key
#  description :string(100)
#

class Ethnicity < ActiveRecord::Base
  attr_accessible :id, :description

  audited :allow_mass_assignment => true

  def to_s
    self.description
  end
end
