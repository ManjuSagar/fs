class AddFedIdToOrgs < ActiveRecord::Migration
  def change
    add_column :orgs, :fed_tax_number, :string, :limit => 15
    Org.update_all(:fed_tax_number => "352316686")
    change_column :orgs, :fed_tax_number, :string, :null => false
  end
end
