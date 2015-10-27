# == Schema Information
#
# Table name: treatment_request_payment_sources
#
#  id                :integer          not null, primary key
#  request_id        :integer          not null
#  payment_source_id :string(255)      not null
#  lock_version      :integer          default(0), not null
#

class TreatmentRequestPaymentSource < ActiveRecord::Base
  belongs_to :treatment_request, :foreign_key => :request_id
  belongs_to :payment_source
  audited :associated_with => :treatment_request, :allow_mass_assignment => true

end
