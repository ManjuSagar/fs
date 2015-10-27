class AddBillAmountToMedicareBilling < ActiveRecord::Migration
  def change
    add_column :medicare_billings, :bill_amount, :decimal
  end
end
