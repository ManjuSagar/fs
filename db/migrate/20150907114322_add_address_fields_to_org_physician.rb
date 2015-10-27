class AddAddressFieldsToOrgPhysician < ActiveRecord::Migration
  def change
    add_column :org_physicians, :suite_number, :string, limit: 15
    add_column :org_physicians, :street_address, :string, limit: 50
    add_column :org_physicians, :city, :string, limit: 50
    add_column :org_physicians, :state, :string, limit: 2
    add_column :org_physicians, :zip_code, :string, limit: 10
    add_column :org_physicians, :phone_number, :string, limit: 15
    add_column :org_physicians, :suffix, :string, limit: 10
  end
end
