class CreateHealthAgencies < ActiveRecord::Migration
  def change
    create_table :health_agencies do |t|
      t.string :agency_name, :limit => 100, :null => false
      t.string :agency_type, :limit => 1, :null => false
      t.string :provider_number, :limit => 100, :null => false
      t.string :week_start_day, :limit => 3, :null => false
      t.string :suite_number, :limit => 10, :null => false
      t.string :street_address, :limit => 50, :null => false
      t.string :city, :limit => 50, :null => false
      t.string :state, :limit => 2, :null => false
      t.string :zip_code, :limit => 10, :null => false
      t.string :email, :limit => 100, :null => false
      t.string :preferred_alert_mode, :limit => 1, :null => false
      t.text :notes
      t.timestamps
    end
  end
end
