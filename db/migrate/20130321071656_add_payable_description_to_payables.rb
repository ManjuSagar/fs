class AddPayableDescriptionToPayables < ActiveRecord::Migration
  def up
    add_column :payables, :payroll_description, :string
  end
  def down
    remove_column :payables, :payroll_description
  end
end
