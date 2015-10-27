class AddPayerIdToInsuranceCompany < ActiveRecord::Migration
  def change
    add_column :insurance_companies, :payer_id, :string, limit: 25
  end
end
