docs = [OasisEvaluation.all, OasisResumptionOfCare.all, OasisRecertification.all, OasisOtherFollowup.all,
        OasisTransferredPatientWithDischarge.all, OasisTransferredPatientWithoutDischarge.all, OasisDeathAtHome.all,
        OasisDischargeFromAgency.all].flatten

Thread.current[:events] = {}
docs.each do |document|
  oasis_export = document.oasis_exports.first
  if document.completed? and oasis_export and oasis_export.exported?
    all_doc = document.all_documents.first
    all_doc.update_column(:status, "Exported (#{oasis_export.exported_date_display})") if all_doc
  end
end