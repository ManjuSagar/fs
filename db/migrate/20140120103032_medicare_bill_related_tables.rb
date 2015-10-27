class MedicareBillRelatedTables < ActiveRecord::Migration
  def change

    drop_table :hipps_codes

    create_table :hipps_codes do |t|
      t.string :code, :null => false, :unique => true
      t.string :description
      t.integer :lock_version
      t.timestamps
    end

    create_table :hhrg_weights do |t|
      t.integer :hipps_code_id, :null => false
      t.decimal :weight, :null => false
      t.integer :calender_year, :null => false
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_nrs_rates do |t|
      t.integer :calender_year, :null => false
      t.string :nrs_score, :null => false
      t.decimal :nrs_amt, :scale => 2, :null => false
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_labor_percentages do |t|
      t.integer :calender_year, :null => false
      t.decimal :labor_percentage, :null => false
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_lupa_rates do |t|
      t.integer :calender_year, :null => false
      t.string :discipline_code, :null => false
      t.decimal :base_amt, :scale => 2, :null => false
      t.integer :lock_version
      t.timestamps
    end

    create_table :medicare_standard_rates do |t|
      t.integer :calender_year, :null => false
      t.decimal :base_amt, :scale => 2, :null => false
      t.decimal :rural_percentage, :null => false
      t.integer :lock_version
      t.timestamps
    end

  end
end
