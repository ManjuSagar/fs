class ChangingTheReportFileNameInOasis < ActiveRecord::Migration
  def change
    DocumentFormTemplate.where("document_class_name like '%Oasis%'").update_all(:report_file_name => 'oasis_generic_template')
  end
end
