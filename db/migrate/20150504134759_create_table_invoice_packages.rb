class CreateTableInvoicePackages < ActiveRecord::Migration
  def up
    create_table :invoice_packages do |t|
      t.integer :invoice_id
      t.integer :insurance_company_id
      t.string :package_number
      t.timestamps
    end
  end

  def down
  end
end
