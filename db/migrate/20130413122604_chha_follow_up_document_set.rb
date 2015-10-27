class ChhaFollowUpDocumentSet < ActiveRecord::Migration
    def change
      Discipline.find_or_create_by_discipline_code(discipline_code: "CHHA", discipline_description: "Certified Home Health Agency")
      Discipline.reset_column_information
      LicenseType.find_or_create_by_license_type_code(license_type_code: "CHHA", license_type_description: "Care Planer",
                         discipline_id: Discipline.find_by_discipline_code("CHHA").id, independent_flag: true)
      LicenseType.reset_column_information

      facility_owner = FacilityOwner.first
      if facility_owner.present?
        doc_set = DocumentDefinitionSet.find_by_set_name("Default")
        tpl_set = DocumentFormTemplateSet.find_by_set_name("Default")
        tpl = DocumentFormTemplate.create(template_name: "CHHAFollowup", template_description: "CHHA Followup",
                                          document_class_name: "CHHAFollowUpForm", status: "A", report_file_name: "chha_followup")

        doc = DocumentDefinition.create(document_code: "CHHA_FOLLOWUP", document_name: "CHHA Followup", document_form_template_id: tpl.id,
                                        org_id: facility_owner.id, payable_rate: 10)
        tpl_set.document_form_templates << tpl
        doc_set.document_definitions << doc
        tpl_set.save!
        doc_set.save!

        chha_eval = VisitType.new({:visit_type_code => "CHHA_FOLLOWUP", :visit_type_description => "Followup", :discipline => Discipline.find_by_discipline_code("CHHA"),
                                   :payable_rate => "10", :org_id => facility_owner.id, :optional_flag => false})
        chha_eval.save!(:validate => false)
        chha_eval.visit_type_document_definitions.create!({:mandatory_flag => true, :document_definition => DocumentDefinition.find_by_document_name("CHHA Followup")})
        license_type = LicenseType.find_by_license_type_code("CHHA")
        chha_eval.license_types << license_type if license_type
        chha_eval.save(:validate => false)

        vt = VisitType.find_by_visit_type_code_and_org_id("CHHA_FOLLOWUP", facility_owner.id)
        vt.state_transitions.build({:from_state => 'active', :to_state => 'active'})
        vt.save!(validate: false)
      end
    end


end
