class AddRuralSupplyToHippsCodes < ActiveRecord::Migration
  def change
    add_column :hipps_codes, :rural_supply_add_on_amount, :string
  end
end
