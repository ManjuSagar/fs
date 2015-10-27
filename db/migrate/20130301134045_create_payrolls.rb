class CreatePayrolls < ActiveRecord::Migration
  def up
    create_table :payrolls do |t|
      t.date :payroll_date, :null => false
      t.integer :org_id, :null => false
      t.string :payee_type, :null => false, :limit => 50
      t.integer :payee_id, :null => false
      t.decimal :payroll_amount, :null => false
      t.string :payroll_status, :null => false, :limit => 2
      t.datetime :paid_date

      t.timestamps
    end
  end
  def down
    drop_table :payrolls
  end
end
