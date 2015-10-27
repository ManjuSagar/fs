class RemoveCompanyCodeFromInsuranceCompanies < ActiveRecord::Migration
  def up
    remove_column :insurance_companies, :company_code
  end

  def down
    add_column :insurance_companies, :company_code, :string
  end
end
