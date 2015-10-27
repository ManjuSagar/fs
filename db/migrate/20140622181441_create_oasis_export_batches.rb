class CreateOasisExportBatches < ActiveRecord::Migration
  def change
    create_table :oasis_export_batches do |t|
      t.integer :oasis_export_id, :null => false
      t.integer :export_batch_file_id, :null => false
      t.integer :lock_version
      t.timestamps
    end
  end
end
