class CreateHaScContractVtRates < ActiveRecord::Migration
  def change
    create_table :ha_sc_contract_vt_rates do |t|
      t.integer :contract_id, :null => false
      t.integer :visit_type_id, :null => false
      t.decimal :chargeable_rate, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
