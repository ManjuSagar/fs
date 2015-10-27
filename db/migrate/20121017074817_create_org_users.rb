class CreateOrgUsers < ActiveRecord::Migration
  def change
    create_table :org_users do |t|
      t.integer :org_id, :limit => 10, :null => false
      t.integer :user_id, :limit => 10, :null => false

      t.timestamps
    end
  end
end
