class AddPaymentReferenceToInvoicePayment < ActiveRecord::Migration
  def change
    Invoice.destroy_all
    Receivable.destroy_all
    InvoicePayment.destroy_all
    add_column :invoice_payments, :payment_reference_number, :string, :null => false
  end
end
