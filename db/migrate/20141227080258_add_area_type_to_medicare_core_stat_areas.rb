class AddAreaTypeToMedicareCoreStatAreas < ActiveRecord::Migration
  def up
    add_column :medicare_core_stat_areas, :area_type, :string
  end

  def down
    remove_column :medicare_core_stat_areas, :area_type
  end
end
