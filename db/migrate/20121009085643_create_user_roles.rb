class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :role_type, :limit => 2, :null => false
      t.integer :user_id, :limit => 10, :null => false
      t.timestamps
    end
  end
end
