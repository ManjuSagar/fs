ActiveRecord::Base.transaction do
  facility_owner = FacilityOwner.first

  template_names = ["SOC Oasis C1", "Oasis ROC C1", "Oasis RR C1", "Oasis OF C1", "Oasis TIFPND C1", "Oasis TIFPD C1", "Oasis DAH C1", "Oasis DFA C1"]

  template_descriptions = ["OASIS Evaluation C1", "Oasis Resumption Of Care C1", "Oasis Recertification C1", "Oasis Other Followup C1", "Oasis Transferred to an inpatient facility - patient not discharged from agency C1",
                           "Oasis Transferred to an inpatient facility - patient discharged from agency C1", "Oasis Death at Home C1", "Oasis Discharge from agency C1"]

  document_class_names = ["OasisEvalFormC1", "OasisResumptionOfCareFormC1", "OasisRecertificationFormC1", "OasisOtherFollowupFormC1", "OasisTransferredPatientWithoutDischargeFormC1",
                          "OasisTransferredPatientWithDischargeFormC1", "OasisDeathAtHomeFormC1", "OasisDischargeFromAgencyFormC1"]

  report_file_names = ["oasis_generic_template", "oasis_generic_template", "oasis_generic_template", "oasis_generic_template", "oasis_generic_template",
                       "oasis_generic_template", "oasis_generic_template", "oasis_generic_template" ]
  document_codes = ["SOC_OASIS_C1", "OASIS_ROC_C1", "OASIS_RR_C1", "OASIS_OF_C1", "OASIS_TIFPND_C1", "OASIS_TIFPD_C1",
                    "OASIS_DAH_C1", "OASIS_DFA_C1"]

  document_names = ["OASIS Evaluation C1", "Oasis Resumption Of Care C1", "Oasis Recertification C1", "Oasis Other Followup C1", "Oasis Transferred W/O DC C1",
                    "Oasis Transferred DC C1", "Oasis Death C1", "Oasis Discharge C1"]


  doc_sets = ["Default", "HHA"]
  tpl_sets = ["Default", "HHA"]

  doc_sets.each_with_index do |doc_set_name, index|
    doc_set = DocumentDefinitionSet.find_by_set_name(doc_set_name)
    tpl_set = DocumentFormTemplateSet.find_by_set_name(tpl_sets[index])
    template_names.each_with_index do |name, index|
      tpl = DocumentFormTemplate.create!(template_name: template_names[index], template_description: template_descriptions[index],
                                         document_class_name: document_class_names[index], status: "A", report_file_name: report_file_names[index])

      doc = DocumentDefinition.create!(document_code: document_codes[index], document_name: document_names[index], document_form_template_id: tpl.id,
                                       org_id: facility_owner.id, payable_rate: 20)
      tpl_set.document_form_templates << tpl
      doc_set.document_definitions << doc
    end
  end


  orgs = HealthAgency.all

  document_codes.each_with_index do |document_code, index|
    document_form_template_id = DocumentDefinition.find_by_document_code(document_code).document_form_template_id
    orgs.each do |org|
      DocumentDefinition.create!(document_code: document_code, document_name: document_names[index], document_form_template_id: document_form_template_id,
                                   org_id: org.id, payable_rate: 20)
    end
  end
end