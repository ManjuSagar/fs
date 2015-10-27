class UpdateDocumentTemplateReportFileName < ActiveRecord::Migration
  def change
    template_report_names = ["pt_eval", "pt_followup", "pt_discharge", "ot_eval", "ot_followup", "ot_discharge",
                            "st_eval", "st_followup", "st_discharge", "msw_eval", "msw_followup", "msw_discharge",
                            "sn_eval", "sn_followup", "sn_discharge"]
    template_report_names.each{|name|
      doc_template = DocumentFormTemplate.find_by_report_file_name(name)
      doc_template.update_attribute("report_file_name", "generic_template") if doc_template.present?
    }
  end
end
