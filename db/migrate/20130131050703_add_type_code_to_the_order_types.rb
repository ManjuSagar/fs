class AddTypeCodeToTheOrderTypes < ActiveRecord::Migration
  def change
    add_column :order_types, :type_code, :string
    OrderType.update_all(:type_code => "CODE")
    change_column :order_types, :type_code, :string, :null => false
  end
end
