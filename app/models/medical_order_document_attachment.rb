# == Schema Information
#
# Table name: medical_order_attached_docs
#
#  id               :integer          not null, primary key
#  medical_order_id :integer          not null
#  document_id      :integer          not null
#

class MedicalOrderDocumentAttachment < ActiveRecord::Base
  set_table_name :medical_order_attached_docs

  belongs_to :medical_order
  belongs_to :document

  audited :associated_with => :document, :allow_mass_assignment => true

  def to_pdf
    document.mo_report_flag = true
    document.to_pdf
  end

end
