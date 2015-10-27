class CreatePhysicians < ActiveRecord::Migration
  def change
    create_table :physicians do |t|
      t.string :physician_first_name, :limit => 100, :null => false
      t.string :physician_last_name, :limit => 100, :null => false
      t.integer :suite_number, :limit => 10, :null => false
      t.string :street_address, :limit => 50, :null => false
      t.string :city, :limit => 50, :null => false
      t.string :state, :limit => 2, :null => false
      t.string :zip_code, :limit => 10, :null => false
      t.string :phone_number, :limit => 15, :null => false
      t.string :npi_number, :limit => 15, :null => false
      t.timestamps
    end
  end
end
