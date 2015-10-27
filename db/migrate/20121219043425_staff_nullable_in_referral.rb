class StaffNullableInReferral < ActiveRecord::Migration
  def up
    change_column :treatment_request_staffs, :staff_type, :string, :limit => 100, :null => true
    change_column :treatment_request_staffs, :staff_id, :integer, :null => true
  end

  def down
  end
end
