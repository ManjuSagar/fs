class ChangeTypeOfPaidDateInPayrolls < ActiveRecord::Migration
  def up
    change_column :payrolls, :paid_date, :date
  end

  def down
    change_column :payrolls, :paid_date, :datetime
  end
end
