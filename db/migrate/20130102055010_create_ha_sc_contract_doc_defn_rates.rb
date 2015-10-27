class CreateHaScContractDocDefnRates < ActiveRecord::Migration
  def change
    create_table :ha_sc_contract_doc_defn_rates do |t|
      t.integer :contract_id, :null => false
      t.integer :document_definition_id, :null => false
      t.decimal :chargeable_rate, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
