class FieldStaffDetails < ActiveRecord::Migration
  def up
    create_table :field_staff_details, :force => true do |t|
      t.integer :field_staff_id, :null => false
      t.integer :license_type_id, :null => false
    end

  end

  def down
  end
end
