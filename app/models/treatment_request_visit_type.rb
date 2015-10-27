# == Schema Information
#
# Table name: treat_req_visit_types
#
#  id            :integer          not null, primary key
#  request_id    :integer          not null
#  visit_type_id :integer          not null
#  lock_version  :integer          default(0), not null
#

class TreatmentRequestVisitType < ActiveRecord::Base
  self.table_name = "treat_req_visit_types"
  belongs_to :treatment_request, :foreign_key => :request_id
  belongs_to :visit_type
  audited :associated_with => :treatment_request, :allow_mass_assignment => true

  before_create :set_defaults

  def set_defaults
    self.request_status = "A"
  end

  def discipline_display
    (User.current.user_type == "FieldStaff")? "#{discipline.discipline_code}" : "#{treatment_request.name}-#{discipline.discipline_code}"
  end

  def health_agency_name
    treatment_request.health_agency.to_s
  end

  def patient_location
    treatment_request.patient_location
  end

end
