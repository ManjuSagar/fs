class TreatmentFieldStaff < ActiveRecord::Migration
  def up
    create_table :treatment_field_staffs, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :field_staff_id, :null => false
      t.integer :lock_version, :default => 0
    end
  end

  def down
  end
end
