# == Schema Information
#
# Table name: treatment_field_staffs
#
#  id             :integer          not null, primary key
#  treatment_id   :integer          not null
#  field_staff_id :integer          not null
#  lock_version   :integer          default(0)
#

class TreatmentFieldStaff < ActiveRecord::Base
  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :field_staff
  #scope :org_scope, lambda { includes(:treatment => {:patient => :patient_detail}).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}
  audited :associated_with => :treatment, :allow_mass_assignment => true


end
