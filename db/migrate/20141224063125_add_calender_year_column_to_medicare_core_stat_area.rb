class AddCalenderYearColumnToMedicareCoreStatArea < ActiveRecord::Migration
  def change
     add_column :medicare_core_stat_areas, :calender_year, :integer
  end
end
