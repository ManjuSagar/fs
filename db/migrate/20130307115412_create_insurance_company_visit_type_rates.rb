class CreateInsuranceCompanyVisitTypeRates < ActiveRecord::Migration
  def change
    create_table :insurance_company_visit_type_rates do |t|
      t.integer :org_id, :null =>false
      t.integer :insurance_company_id, :null => false
      t.integer :visit_type_id, :null => false
      t.decimal :rate, :precision => 8, :scale => 2, :null => false
      t.string :external_visit_type_code, :limit => 20, :null => false
      t.integer :lock_version, :default => 0

    end
    add_index :insurance_company_visit_type_rates, [:org_id, :insurance_company_id, :visit_type_id], :unique => true, name: "indexes_for_insurance_company_visit_type_rates"
  
  end
end
