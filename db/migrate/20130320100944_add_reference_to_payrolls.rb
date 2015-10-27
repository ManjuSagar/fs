class AddReferenceToPayrolls < ActiveRecord::Migration
 
  def up
    Payable.update_all "payroll_id = null"
    Payroll.delete_all
    add_column :payrolls, :payroll_reference, :string, :limit => 20, :null => false
  end
  
  def down
    remove_column :payrolls, :payroll_reference
  end
end
