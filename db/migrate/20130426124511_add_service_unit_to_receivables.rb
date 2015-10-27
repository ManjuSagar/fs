class AddServiceUnitToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :service_units, :integer
    Receivable.update_all(:service_units => 1)
    change_column :receivables, :service_units, :integer, :null => false
  end
end
