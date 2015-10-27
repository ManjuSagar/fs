class AddOasisFormsToFacilityOwner < ActiveRecord::Migration
  def change
    template_names = ["SNFollowup", "SNDischarge", "Oasis ROC", "Oasis RR", "Oasis OF", "Oasis TIFPND", "Oasis TIFPD", "Oasis DAH", "Oasis DFA"]

    template_descriptions = ["SN Followup", "SN Discharge", "Oasis Resumption Of Care", "Oasis Recertification", "Oasis Other Followup", "Oasis Transferred to an inpatient facility - patient not discharged from agency",
        "Oasis Transferred to an inpatient facility - patient discharged from agency", "Oasis Death at Home", "Oasis Discharge from agency"]

    document_class_names = ["SNFollowUpForm", "SNDischargeForm", "OasisResumptionOfCareForm", "OasisRecertificationForm", "OasisOtherFollowupForm", "OasisTransferredPatientWithoutDischargeForm",
                            "OasisTransferredPatientWithDischargeForm", "OasisDeathAtHomeForm", "OasisDischargeFromAgencyForm"]

    report_file_names = ["sn_followup", "sn_discharge", "oasis_roc", "oasis_rr", "oasis_of", "oasis_tifpnd", "oasis_tifpd", "oasis_dah", "oasis_dfa"]

    document_codes = ["SN_FOLLOWUP", "SN_DISCHARGE", "OASIS_ROC", "OASIS_RR", "OASIS_OF", "OASIS_TIFPND", "OASIS_TIFPD", "OASIS_DAH", "OASIS_DFA"]

    document_names = ["SN Followup", "SN Discharge", "Oasis Resumption Of Care", "Oasis Recertification", "Oasis Other Followup", "Oasis Transferred to an inpatient facility - patient not discharged from agency",
                      "Oasis Transferred to an inpatient facility - patient discharged from agency", "Oasis Death at Home", "Oasis Discharge from agency"]

    doc_set = DocumentDefinitionSet.find_by_set_name("Default")
    tpl_set = DocumentFormTemplateSet.find_by_set_name("Default")

    facility_owner = FacilityOwner.first
    if facility_owner.present?
      template_names.each_with_index do |name, index|
        tpl = DocumentFormTemplate.create(template_name: template_names[index], template_description: template_descriptions[index],
                                          document_class_name: document_class_names[index], status: "A", report_file_name: report_file_names[index])

        doc = DocumentDefinition.create(document_code: document_codes[index], document_name: document_names[index], document_form_template_id: tpl.id,
                                        org_id: facility_owner.id, payable_rate: 10)
        tpl_set.document_form_templates << tpl
        doc_set.document_definitions << doc
      end
      tpl_set.save!
      doc_set.save!

      sn_followup = VisitType.new({:visit_type_code => "SN_FOLLOWUP", :visit_type_description => "Followup", :discipline => Discipline.find_by_discipline_code("SN"),
                          :payable_rate => "10", :org_id => facility_owner.id, :optional_flag => false})
      sn_followup.save!(:validate => false)
      sn_followup.visit_type_document_definitions.create!({:mandatory_flag => true, :document_definition => DocumentDefinition.find_by_document_name("SN Followup")})
      sn = LicenseType.find_by_license_type_code("SN")
      sn_followup.license_types << sn if sn
      sna = LicenseType.find_by_license_type_code("SNA")
      sn_followup.license_types << sna if sna
      sn_followup.save(:validate => false)

      vt_docs = ["Evaluation", "Followup", "Discharge", "Evaluation", "Followup", "Discharge",
                 "Evaluation", "Followup", "Discharge", "Evaluation", "Followup", "Discharge",
                 "Evaluation", "Followup", "Discharge"]

      visit_type_codes = ["PT_EVAL", "PT_FOLLOWUP", "PT_DISCHARGE", "OT_EVAL", "OT_FOLLOWUP", "OT_DISCHARGE",
                          "SN_EVAL", "SN_FOLLOWUP", "SN_DISCHARGE", "ST_EVAL", "ST_FOLLOWUP", "ST_DISCHARGE",
                          "MSW_EVAL", "MSW_FOLLOWUP", "MSW_DISCHARGE"]

      visit_type_codes.each_with_index do |code, index|
        #Oasis documents
        vt = VisitType.find_by_visit_type_code_and_org_id(code, facility_owner.id)

        if vt_docs[index] == "Evaluation"
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("SOC_OASIS")})
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_ROC")})
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_RR")})
        elsif vt_docs[index] == "Followup"
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_RR")})
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_OF")})
        elsif vt_docs[index] == "Discharge"
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_TIFPND")})
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_TIFPD")})
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_DAH")})
          vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_DFA")})
        end
      end
    end
  end
end
