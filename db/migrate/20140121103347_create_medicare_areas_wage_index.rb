class CreateMedicareAreasWageIndex < ActiveRecord::Migration
  def up
    remove_column :medicare_core_stat_areas, :calander_year
    remove_column :medicare_core_stat_areas, :wage_index
    rename_column :medicare_core_stat_areas, :cbca_code, :cbsa_code
    rename_column :medicare_core_stat_areas, :state_code, :state_name
    change_column :medicare_core_stat_areas, :state_name, :string
    MedicareCoreStatArea.delete_all
    create_table :medicare_areas_wage_indices do |t|
      t.integer :cbsa_code_id, :null => false
      t.decimal :wage_index
      t.integer :calender_year, :null => false
      t.timestamps
    end
  end

  def down
  end
end
