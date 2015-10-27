class AddSentDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :sent_date, :date
  end
end
