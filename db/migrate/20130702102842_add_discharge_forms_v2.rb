class AddDischargeFormsV2 < ActiveRecord::Migration
  def up
    doc_set = DocumentDefinitionSet.find_by_set_name("Default")
    template_set = DocumentFormTemplateSet.find_by_set_name("Default")
    if doc_set.present? and template_set.present?
      template_names = ["PTDischargeV2", "STDischargeV2", "OTDischargeV2", "SNDischargeV2", "MSWDischargeV2"]
      template_descriptions = ["PT Discharge V2", "ST Discharge V2", "OT Discharge V2", "SN Discharge V2", "MSW Discharge V2"]
      document_class_names = ["PTDischargeFormV2", "STDischargeFormV2", "OTDischargeFormV2", "SNDischargeFormV2", "MSWDischargeFormV2"]
      document_codes = ["PT_DISCHARGE", "ST_DISCHARGE", "OT_DISCHARGE", "SN_DISCHARGE", "MSW_DISCHARGE"]

      (0..4).each{|i|
        template = DocumentFormTemplate.create!(template_name: template_names[i], template_description: template_descriptions[i],
                                                document_class_name: document_class_names[i], status: "A", report_file_name: "generic_template")
        docs = DocumentDefinition.where(:document_code => document_codes[i])
        docs.update_all("document_form_template_id" => template.id)
        template_set.document_form_templates << template
        doc_set.document_definitions << docs
        template_set.save!
        doc_set.save!
      }
    end

  end

  def down
  end
end
