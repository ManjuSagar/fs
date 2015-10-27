class SignedUserInMo < ActiveRecord::Migration
  def up
    change_column :medical_orders, :signed_user_id, :integer, :null => true
  end

  def down
  end
end
