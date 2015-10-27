class AddFieldStaffIdToMedicalOrder < ActiveRecord::Migration
  def change
    add_column :medical_orders, :field_staff_id, :integer, :null => true
  end
end
