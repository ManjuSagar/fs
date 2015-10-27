class AddOasisColumnToDocumentDefinition < ActiveRecord::Migration
  def change
     add_column :document_form_templates, :oasis, :boolean, :default => false
     add_column :document_form_templates, :document_type, :string
  end

end
