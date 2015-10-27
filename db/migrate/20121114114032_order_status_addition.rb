class OrderStatusAddition < ActiveRecord::Migration
  def up
    add_column :medical_orders, :order_status, :string, :limit => 2, :null => false
  end

  def down
  end
end
