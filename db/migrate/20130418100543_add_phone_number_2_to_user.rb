class AddPhoneNumber2ToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_number_2, :string, :limit => 15
    add_column :users, :fax_number, :string, :limit => 15
  end
end
