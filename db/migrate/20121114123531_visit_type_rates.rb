class VisitTypeRates < ActiveRecord::Migration
  def up
    rename_column :document_definitions, :status, :defn_status

    add_column :visit_types, :payable_rate, :decimal, :precision => 8, :scale => 2
    add_column :visit_types, :chargeable_rate, :decimal, :precision => 8, :scale => 2

    add_column :document_definitions, :payable_rate, :decimal, :precision => 8, :scale => 2
    add_column :document_definitions, :chargeable_rate, :decimal, :precision => 8, :scale => 2
  end

  def down
  end
end
