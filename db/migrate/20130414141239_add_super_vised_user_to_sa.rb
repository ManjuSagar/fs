class AddSuperVisedUserToSa < ActiveRecord::Migration
  def change
    facility_owner = FacilityOwner.first
    if facility_owner.present?
      doc_set = DocumentDefinitionSet.find_by_set_name("Default")
      tpl_set = DocumentFormTemplateSet.find_by_set_name("Default")
      tpl = DocumentFormTemplate.create(template_name: "SuperVisorVisit", template_description: "Super Visor Visit",
                                        document_class_name: "SuperVisoryVisitForm", status: "A", report_file_name: "super_visor_visit")

      doc = DocumentDefinition.create(document_code: "SUPERVISOR_VISIT", document_name: "Super Visor Visit", document_form_template_id: tpl.id,
                                      org_id: facility_owner.id, payable_rate: 10)
      tpl_set.document_form_templates << tpl
      doc_set.document_definitions << doc
      tpl_set.save!
      doc_set.save!
    end
  end


end
