class DropPhysiciansTable < ActiveRecord::Migration
  def change
    drop_table :physicians
  end
end
