class AddStaffingRequirementIdToStaffsAllocation < ActiveRecord::Migration
  def change
    add_column :treatment_request_staffs, :staffing_requirement_id, :integer
    add_column :treatment_staffs, :staffing_requirement_id, :integer
    change_column :treatment_staffs, :staff_type, :string, :limit => 100, :null => true
    change_column :treatment_staffs, :staff_id, :integer, :null => true
  end
end
