class CreateDosageFormsTable < ActiveRecord::Migration
  def up

    create_table :fda_drug_libraries do |t|
      t.string :drug_name, :null => false
      t.string :strength
      t.string :active_ingredients
      t.string :marketing_status, :null => false
      t.integer :form_id, :null => false
      t.integer :company_id, :null => false

      t.integer :lock_version
      t.timestamps

    end

    create_table :dosage_forms do |t|
      t.string :form, :null => false

      t.integer :lock_version
      t.timestamps
    end

    create_table :drug_companies do |t|
      t.string :name, :null => false
      t.text :app_nos_string

      t.integer :lock_version
      t.timestamps
    end

  end

  def down
    drop_table :fda_drug_libraries
    drop_table :dosage_forms
    drop_table :drug_companies
  end
end
