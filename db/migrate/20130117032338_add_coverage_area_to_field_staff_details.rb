class AddCoverageAreaToFieldStaffDetails < ActiveRecord::Migration
  def change
    add_column :field_staff_details, :coverage_areas, :text  
  end
end
