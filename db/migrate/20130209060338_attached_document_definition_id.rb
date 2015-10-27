class AttachedDocumentDefinitionId < ActiveRecord::Migration
  def up
    add_column :visit_attachments, :document_definition_id, :integer
  end

  def down
  end
end
