class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :phone_type, :limit => 1, :null => false
      t.string :phone_number, :limit => 15, :null => false
      t.string :extension, :limit => 10, :null => true
      t.boolean :default_number, :default => false, :null => false
      t.integer :org_id, :limit => 10, :null => false
      t.timestamps
    end
  end
end
