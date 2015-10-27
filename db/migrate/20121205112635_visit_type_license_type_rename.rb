class VisitTypeLicenseTypeRename < ActiveRecord::Migration
  def up
    drop_table :visit_type_licence_types
    create_table :license_types_visit_types, :force => true do |t|
      t.integer :license_type_id, :null => false
      t.integer :visit_type_id, :null => false
      t.integer :lock_version, :default => 0, :null => false
    end

  end

  def down
  end
end
