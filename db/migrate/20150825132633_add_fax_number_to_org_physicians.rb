class AddFaxNumberToOrgPhysicians < ActiveRecord::Migration
  def change
    add_column :org_physicians, :fax_number, :string, :limit => 15
  end
end
