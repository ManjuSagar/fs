class CreateOasisExport < ActiveRecord::Migration
  def up
    create_table :oasis_exports, :force => true do |t|
      t.integer :document_id, :null => false
      t.string :export_status, :limit => 1, :null => false, :default => 'R'
      t.timestamp :exported_date_time
      t.integer :exported_user_id
      t.string :export_reference, :limit => 20
    end
  end

  def down
  end
end
