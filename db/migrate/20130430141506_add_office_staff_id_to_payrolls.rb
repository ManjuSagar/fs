class AddOfficeStaffIdToPayrolls < ActiveRecord::Migration
  def change
    add_column :payrolls, :office_staff_id, :integer
    Payroll.update_all(:office_staff_id => -1)
    change_column :payrolls, :office_staff_id, :integer, :null => false

    rename_column :payables, :txn_date, :visit_date

    remove_column :payrolls, :payroll_description
    add_column :payables, :field_staff_id, :integer
  end
end
