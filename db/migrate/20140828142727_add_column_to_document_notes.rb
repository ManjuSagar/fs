class AddColumnToDocumentNotes < ActiveRecord::Migration
  def change
    add_column :document_notes, :event_changed, :boolean
  end
end