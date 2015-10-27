class AddDraftStatusToOrgs < ActiveRecord::Migration
  def change
    add_column :orgs, :draft_status, :boolean, :default => false
    change_column :orgs, :org_name, :string, :limit => 100, :unique => true, :null => true
    change_column :orgs, :city, :string, :limit => 50, :null => true
    change_column :orgs, :state, :string, :limit => 2, :null => true
    change_column :orgs, :zip_code, :string, :limit => 10, :null => true
    change_column :orgs, :email, :string, :limit => 100, :null => true
    change_column :orgs, :fed_tax_number, :string, :limit => 100, :null => true
    change_column :orgs, :street_address, :string, :limit => 50, :null => true
  end
end
