class RemoveUnwantedTables < ActiveRecord::Migration
  def up
    drop_table :companies
    drop_table :user_roles
    drop_table :patients
  end

  def down
  end
end
