# == Schema Information
#
# Table name: medical_equipments
#
#  id             :integer          not null, primary key
#  equipment_name :string(50)       not null
#  lock_version   :integer          default(0)
#

class MedicalEquipment < ActiveRecord::Base

  audited :allow_mass_assignment => true

  def to_s
    equipment_name
  end
end
