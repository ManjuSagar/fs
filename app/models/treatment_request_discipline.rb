# == Schema Information
#
# Table name: treat_req_disciplines
#
#  id            :integer          not null, primary key
#  request_id    :integer          not null
#  discipline_id :integer          not null
#  lock_version  :integer          default(0)
#

class TreatmentRequestDiscipline < ActiveRecord::Base
  self.table_name = "treat_req_disciplines"
  belongs_to :treatment_request, :foreign_key => :request_id
  belongs_to :discipline
  has_many :staffing_requests, :dependent => :destroy, :foreign_key => :request_discipline_id
  has_many :internal_staffing_requests, :dependent => :destroy, :foreign_key => :request_discipline_id
  has_many :external_staffing_requests, :dependent => :destroy, :foreign_key => :request_discipline_id

  audited :associated_with => :treatment_request, :allow_mass_assignment => true

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
