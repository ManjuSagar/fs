class RenameDataTypeSuiteNumber < ActiveRecord::Migration
  def up
    change_column :orgs, :suite_number, :string, :limit => 15, :null => false
  end

  def down
  end
end
