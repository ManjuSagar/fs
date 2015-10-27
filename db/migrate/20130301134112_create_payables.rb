class CreatePayables < ActiveRecord::Migration
  def up
    create_table :payables do |t|
      t.date :txn_date, :null => false
      t.string :payable_type, :null => false, :limit => 2
      t.string :source_type, :null => false, :limit => 50
      t.integer :source_id, :null => false
      t.string :payable_status, :null => false, :limit => 2
      t.integer :org_id, :null => false
      t.string :payee_type, :null => false, :limit => 50
      t.integer :payee_id, :null => false
      t.decimal :payable_amount, :null => false
      t.integer :payroll_id

      t.timestamps
    end
    add_index :payables, :org_id
  end
  def down
    remove_index :payables, :org_id
    drop_table :payables
  end
end
