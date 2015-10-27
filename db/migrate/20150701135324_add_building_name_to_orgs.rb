class AddBuildingNameToOrgs < ActiveRecord::Migration
  def up
    add_column :orgs, :building_name, :string, :limit => 40
  end

end
