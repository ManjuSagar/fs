class AddCompCodeToInsuranceCompanies < ActiveRecord::Migration
  def change
    InsuranceCompany.delete_all
    
    add_column :insurance_companies, :company_code, :string, :limit => 10, :null => false

  end
end
