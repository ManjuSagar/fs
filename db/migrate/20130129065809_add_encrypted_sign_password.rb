class AddEncryptedSignPassword < ActiveRecord::Migration
  def up
    add_column :users, :encrypted_sign_password, :string
  end

  def down
  end
end
