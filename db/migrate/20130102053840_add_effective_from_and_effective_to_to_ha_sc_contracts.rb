class AddEffectiveFromAndEffectiveToToHaScContracts < ActiveRecord::Migration
  def change
    add_column :ha_sc_contracts, :effective_from_date, :date
    add_column :ha_sc_contracts, :effective_to_date, :date
  end
end
