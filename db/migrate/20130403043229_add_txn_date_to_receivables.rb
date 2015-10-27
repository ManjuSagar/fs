class AddTxnDateToReceivables < ActiveRecord::Migration
  def change
    Receivable.destroy_all
    add_column :receivables, :receivable_date, :date, :null =>  false
    add_column :receivables, :receivable_amount, :decimal, :precision => 8, :scale => 2, :null => false
  end
end
