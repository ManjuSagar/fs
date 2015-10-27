class RemoveCompanyTypeFromInsuranceCompany < ActiveRecord::Migration
  def up
    remove_column :insurance_companies, :company_type
  end

  def down
  end
end
