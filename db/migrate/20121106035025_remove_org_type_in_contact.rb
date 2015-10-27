class RemoveOrgTypeInContact < ActiveRecord::Migration
  def up
    remove_column :org_contacts, :org_type
    add_column :users, :user_type, :string, :limit => 50
    remove_column :users, :user_detail_id
    remove_column :orgs, :org_detail_id
    add_column :physician_details, :physician_id, :integer
    add_column :health_agency_details, :health_agency_id, :integer
  end

  def down
  end
end
