class AddPecosVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pecos_verification, :boolean, :default =>false
  end
end
