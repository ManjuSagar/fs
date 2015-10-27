class Document1 < ActiveRecord::Base
  set_table_name "documents"
  include OasisExtension
  def valid_document?
    true
  end

  def hipps_code_required_doc?
    false
  end
end

docs = Document1.where(["document_type in (?)", ["OasisEvaluation", "OasisResumptionOfCare", "OasisRecertification", "OasisOtherFollowup",
 "OasisTransferredPatientWithDischarge", "OasisTransferredPatientWithoutDischarge", "OasisDeathAtHome",
 "OasisDischargeFromAgency"]])
docs.each do |doc|
  if (doc.m0014_branch_state.present? and ['N', 'P'].include?(doc.m0016_branch_id))
    doc.m0014_branch_state = nil
    doc.save(:validate => false)
  end
end