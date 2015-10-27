class DocumentNotes < ActiveRecord::Migration
  create_table :document_notes do |t|
    t.integer :document_id, :null => false
    t.datetime :note_date, :null =>  false
    t.text :notes
    t.integer :created_user_id, :null => false
  end
end
