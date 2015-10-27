# == Schema Information
#
# Table name: treat_req_med_equipments
#
#  id                   :integer          not null, primary key
#  request_id           :integer          not null
#  medical_equipment_id :integer          not null
#

class TreatmentRequestMedicalEquipment < ActiveRecord::Base
  self.table_name = "treat_req_med_equipments"

  belongs_to :treatment_request, :foreign_key => :request_id
  belongs_to :medical_equipment
  audited :associated_with => :treatment_request, :allow_mass_assignment => true

end
