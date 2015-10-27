class CreateExportBatchFiles < ActiveRecord::Migration
  def change
    create_table :export_batch_files do |t|
      t.has_attached_file :oasis_export
      t.integer :lock_version
      t.timestamps
    end
  end
end
