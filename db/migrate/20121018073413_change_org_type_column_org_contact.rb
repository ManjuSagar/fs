class ChangeOrgTypeColumnOrgContact < ActiveRecord::Migration
  def up
    change_column :org_contacts, :org_type, :string, :limit => 65, :null => false
  end

  def down
  end
end
