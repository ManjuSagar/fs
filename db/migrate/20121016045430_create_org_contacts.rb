class CreateOrgContacts < ActiveRecord::Migration
  def change
    create_table :org_contacts do |t|
      t.string :org_type, :limit => 2, :null => false
      t.string :contact_first_name, :limit => 100, :null => false
      t.string :contact_last_name, :limit => 100, :null => false
      t.string :phone_number, :limit => 15, :null => false
      t.string :extension, :limit =>10, :null => true
      t.string :email, :limit => 100, :null => false
      t.integer :org_id, :limit => 10, :null => false

      t.timestamps
    end
  end
end
