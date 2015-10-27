class ChangePrecisionOfAmountInPayablesAndPayroll < ActiveRecord::Migration
  def up
    change_column :payables, :payable_amount, :decimal, :precision => 8, :scale => 2
    change_column :payrolls, :payroll_amount, :decimal, :precision => 8, :scale => 2
  end

end
