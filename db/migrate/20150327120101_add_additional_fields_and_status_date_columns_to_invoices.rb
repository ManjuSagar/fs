class AddAdditionalFieldsAndStatusDateColumnsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :additional_fields, :text
    add_column :invoices, :status_date, :date
  end
end
