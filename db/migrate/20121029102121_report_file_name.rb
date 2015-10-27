class ReportFileName < ActiveRecord::Migration
  def up
    add_column :document_form_templates, :report_file_name, :string, :limit => 100
  end

  def down
  end
end
