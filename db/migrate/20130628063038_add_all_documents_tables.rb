class AddAllDocumentsTables < ActiveRecord::Migration
  def change
    create_table :all_documents  do |t|
      t.string :documentable_type, :null => false
      t.integer :documentable_id, :null => false
      t.integer :lock_version, :null => false

      t.timestamps
    end
  end
end
