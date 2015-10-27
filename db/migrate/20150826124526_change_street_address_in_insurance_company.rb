class ChangeStreetAddressInInsuranceCompany < ActiveRecord::Migration
  def change
    change_column :insurance_companies, :claim_street_address, :string, :limit => 1000
  end
end
