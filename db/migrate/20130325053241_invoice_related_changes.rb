class InvoiceRelatedChanges < ActiveRecord::Migration
  def up

    create_table :receivables do |t|
      t.string :payer_type, :null =>false
      t.integer :payer_id, :null => false
      t.integer :treatment_id, :null => false
      t.integer :org_id, :null => false
      t.integer :invoice_id
      t.integer :invoice_payment_id
      t.string :receivable_status, :null => false, :limit => 1
      t.string :source_type, :null => false, :limit => 50
      t.integer :source_id, :null => false
      t.string :purpose, :limit => 100

      t.timestamps
    end

    create_table :invoices do |t|
      t.integer :invoice_number, :null => false
      t.date :invoice_date, :null => false
      t.integer :org_id, :null => false
      t.string :payer_type, :null => false
      t.integer :payer_id, :null => false
      t.decimal :invoice_amount, :null => false, :precision => 8, :scale => 2
      t.string :invoice_status, :null => false, :limit => 1
      t.text :invoice_description

      t.timestamps
    end

    create_table :invoice_payments do |t|
      t.integer :invoice_id, :null => false
      t.integer :org_id, :null => false
      t.date :payment_date, :null => false
      t.string :payer_type, :null => false
      t.integer :payer_id, :null => false
      t.decimal :payment_amount, :null => false, :precision => 8, :scale => 2
      t.string :payment_status, :null => false, :limit => 1
      t.text :payment_description

      t.timestamps
    end

  end

  def down
  end
end
