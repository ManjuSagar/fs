class AddMedicareCbcaTable < ActiveRecord::Migration
  def up
    create_table :medicare_core_stat_areas do |t|
      t.string :cbca_code
      t.string :county_code
      t.string :county_name
      t.string :state_code
      t.integer :calander_year
      t.decimal :wage_index
    end
  end

  def down
  end
end
