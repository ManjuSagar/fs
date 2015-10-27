class OrgUserStatus < ActiveRecord::Migration
  def up
    add_column :org_users, :user_status, :string, :limit => 1
    OrgUser.unscoped.update_all(:user_status => 'A')
    change_column :org_users, :user_status, :string, :limit => 1, :null => false

    add_column :org_users, :verify_token, :string, :limit => 6
  end

  def down
  end
end
