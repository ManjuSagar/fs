class AddNewFieldsToInsuranceCompanies < ActiveRecord::Migration
  def change

    add_column :insurance_companies, :claim_street_address, :string, :limit => 50
    add_column :insurance_companies, :claim_suite_number, :string, :limit => 10
    add_column :insurance_companies, :claim_zip_code, :string, :limit => 10
    add_column :insurance_companies, :claim_city, :string, :limit => 50
    add_column :insurance_companies, :claim_state, :string, :limit => 2
    add_column :insurance_companies, :claim_phone_number, :string, :limit => 15
    add_column :insurance_companies, :authorization_phone_number, :string, :limit => 15
    add_column :insurance_companies, :claim_submission_due_days, :integer
    add_column :insurance_companies, :draft_status, :boolean, :default => false
    change_column :insurance_companies, :company_name, :string, :null => true
    change_column :insurance_companies, :company_code, :string, :null => true
  end
end
