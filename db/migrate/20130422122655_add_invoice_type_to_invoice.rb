class AddInvoiceTypeToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :invoice_type, :string, :limit => 1
    Invoice.update_all(:invoice_type => 'R')
    change_column :invoices, :invoice_type, :string, :limit => 1, :null => false
  end
end
