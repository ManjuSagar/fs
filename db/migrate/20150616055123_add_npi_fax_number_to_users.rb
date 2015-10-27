class AddNpiFaxNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :npi_number, :string, limit: 15
    add_column :org_physicians, :email, :string
  end
end
