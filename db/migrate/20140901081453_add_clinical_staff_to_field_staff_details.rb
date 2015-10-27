class AddClinicalStaffToFieldStaffDetails < ActiveRecord::Migration
  def change
    add_column :field_staff_details, :clinical_staff, :boolean
  end
end
