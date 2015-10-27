class ChangeNpiToNullableForSc < ActiveRecord::Migration
 def change
   change_column :orgs, :npi_number, :string, :limit => 15, :null => true
 end
end
