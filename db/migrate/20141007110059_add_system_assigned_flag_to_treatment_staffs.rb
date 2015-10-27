class AddSystemAssignedFlagToTreatmentStaffs < ActiveRecord::Migration
  def change
    add_column :treatment_staffs, :system_assigned, :boolean, default: false
  end
end
