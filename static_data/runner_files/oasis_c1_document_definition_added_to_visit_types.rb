
oasis_c_klass_names = ["OasisEvalForm", "OasisResumptionOfCareForm", "OasisRecertificationForm", "OasisOtherFollowupForm", "OasisTransferredPatientWithoutDischargeForm",
                       "OasisTransferredPatientWithDischargeForm", "OasisDeathAtHomeForm", "OasisDischargeFromAgencyForm"]
oasis_c1_klass_names = ["OasisEvalFormC1", "OasisResumptionOfCareFormC1", "OasisRecertificationFormC1", "OasisOtherFollowupFormC1", "OasisTransferredPatientWithoutDischargeFormC1",
                        "OasisTransferredPatientWithDischargeFormC1", "OasisDeathAtHomeFormC1", "OasisDischargeFromAgencyFormC1"]
VisitType.all.each do |visit_type|
  oasis_c_klass_names.each_with_index do |doc_klass_name, index|
    existing_dd = visit_type.document_definitions.detect{|dd| dd.document_form_template.document_class_name == doc_klass_name}    
    next unless existing_dd.present?
    org_doc_defs = DocumentDefinition.where("org_id = #{existing_dd.org_id}")
    new_dd = org_doc_defs.detect{|dd| dd.document_form_template.document_class_name == oasis_c1_klass_names[index] }    
    visit_type.visit_type_document_definitions.create!({document_definition_id: new_dd.id})
  end
end