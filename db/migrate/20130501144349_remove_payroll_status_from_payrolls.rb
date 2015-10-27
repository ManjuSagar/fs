class RemovePayrollStatusFromPayrolls < ActiveRecord::Migration
  def change
    remove_column :payrolls, :payroll_status
  end
end
