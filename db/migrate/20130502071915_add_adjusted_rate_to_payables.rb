class AddAdjustedRateToPayables < ActiveRecord::Migration
  def change
    add_column :payables, :adjusted_rate, :decimal, :precision => 8, :scale => 2
    Payable.all.each{|p|
     p.update_attribute("adjusted_rate", p.payable_amount)
    }
    change_column :payables, :adjusted_rate, :decimal, :precision => 8, :scale => 2, :null => false
  end
end
