class AddRoleTypeToOrgUsers < ActiveRecord::Migration
  def up
    add_column :org_users, :role_type, :string, :limit => 1
  end

  def down
    remove_column :org_users, :role_type
  end
end
