class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration
  users = User.all
  users.each do |user|
    user.first_name = "default"
    user.last_name = "default"
  end

  def change
    add_column :users, :first_name, :string, :limit => 100, :null => false

    add_column :users, :last_name, :string, :limit => 100, :null => false

  end
end
