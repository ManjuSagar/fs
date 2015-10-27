class ModifyInvoiceTypeInInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :invoice_type, :string, :limit => 5, :null => false
  end
end
