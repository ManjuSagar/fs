class AddVisitTypeRateToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :visit_type_rate, :decimal, :precision => 8, :scale => 2
  end
end
