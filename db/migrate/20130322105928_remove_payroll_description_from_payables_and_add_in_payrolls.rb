class RemovePayrollDescriptionFromPayablesAndAddInPayrolls < ActiveRecord::Migration
  def up
    remove_column :payables, :payroll_description
    add_column :payrolls, :payroll_description, :string
  end

  def down
    remove_column :payrolls, :payroll_description
  end
end
