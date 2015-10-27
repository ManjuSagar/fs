# == Schema Information
#
# Table name: contact_types
#
#  id           :integer          not null, primary key
#  type_name    :string(50)       not null
#  lock_version :integer          default(0)
#

class ContactType < ActiveRecord::Base

  audited :allow_mass_assignment => true

  def to_s
    type_name
  end

end
