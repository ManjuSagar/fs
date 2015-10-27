class AddHcpcsCodeAndRevenueCodeToInsuranceCompanyVisitTypeRates < ActiveRecord::Migration
  def change
    add_column :insurance_company_visit_type_rates, :hcpcs_code, :string
    add_column :insurance_company_visit_type_rates, :revenue_code, :string

    remove_column :visit_types, :hcpcs_code, :revenue_code
  end
end
