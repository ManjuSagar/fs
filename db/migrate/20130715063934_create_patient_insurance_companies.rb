class CreatePatientInsuranceCompanies < ActiveRecord::Migration
  def up
    create_table :patient_insurance_companies  do |t|
      t.integer :patient_id, :null => false
      t.integer :insurance_company_id, :null => false
      t.integer :lock_version, :null => false
    end
  end

  def down
    drop_table :patient_insurance_companies
  end
end
