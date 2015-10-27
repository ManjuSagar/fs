class AddTypeOfFlowToInsuranceCompany < ActiveRecord::Migration
  def change
    add_column :insurance_companies, :billing_flow, :string, limit: 5
  end
end
