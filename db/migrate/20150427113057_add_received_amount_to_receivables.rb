class AddReceivedAmountToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :received_amount, :decimal, :precision => 8, :scale => 2
  end
end
