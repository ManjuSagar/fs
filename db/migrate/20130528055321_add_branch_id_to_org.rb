class AddBranchIdToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :branch_id, :string, :limit => 10
  end
end
