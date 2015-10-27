class AddNpiNumberToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :npi_number, :string, :limit => 15
    Org.update_all(:npi_number => "123456789")
    change_column :orgs, :npi_number, :string, :limit => 15, :null => false
  end
end
