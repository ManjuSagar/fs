class AddArchiveToDocumentNotes < ActiveRecord::Migration
  def change
    add_column :document_notes, :archived, :boolean, :default => false
  end
end
