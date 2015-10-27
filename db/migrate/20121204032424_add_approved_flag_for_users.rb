class AddApprovedFlagForUsers < ActiveRecord::Migration
  def up
    User.update_all(:approved => true)
  end

  def down
  end
end
