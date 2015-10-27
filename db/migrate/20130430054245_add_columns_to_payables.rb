class AddColumnsToPayables < ActiveRecord::Migration
  def change
    add_column :payables, :submission_date, :date

    add_column :payables, :treatment_id, :integer
    Payable.update_all(:treatment_id => -1)
    change_column :payables, :treatment_id, :integer, :null => false
  end
end
