class AddFaxNumberToPhysician < ActiveRecord::Migration
  def change
    add_column :physician_details, :fax_number, :string, limit: 15
  end
end
