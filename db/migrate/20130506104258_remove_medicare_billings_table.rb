class RemoveMedicareBillingsTable < ActiveRecord::Migration
  def change
    drop_table :medicare_billings
  end
end
