document_class_names = ["OasisEvalFormC1",
"OasisResumptionOfCareFormC1",
"OasisRecertificationFormC1",
"OasisOtherFollowupFormC1",
"OasisTransferredPatientWithoutDischargeFormC1",
"OasisTransferredPatientWithDischargeFormC1",
"OasisDeathAtHomeFormC1",
"OasisDischargeFromAgencyFormC1",
]

document_class_names.each{|document_class_name|
  doc_form_templates = DocumentFormTemplate.where(document_class_name: document_class_name)
  next if doc_form_templates.size < 2
  doc_form_template_ids = doc_form_templates.map(&:id)
  doc_def = DocumentDefinition.where(document_form_template_id: doc_form_template_ids[1])
  doc_def.update_all(:document_form_template_id => doc_form_template_ids[0])
  doc_form_templates.last.destroy
}


