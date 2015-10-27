class AddPaymentDueDateToPrivateReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :payment_due_date, :date
  end
end
