class LockVersionInScContractRates < ActiveRecord::Migration
  def change
    add_column :ha_sc_contract_doc_defn_rates, :lock_version, :integer, :null => false, :default => 0
    add_column :ha_sc_contract_vt_rates, :lock_version, :integer, :null => false, :default => 0
  end
end
