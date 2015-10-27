class AddHippsCodeWeightAndSupplyAddOnsTable < ActiveRecord::Migration
  def up
    create_table :hipps_codes do |t|
      t.string :hipps_code
      t.string :hipps_code_definition
      t.decimal :hhrg_weight
      t.decimal :supply_add_on_amount
      t.integer :calander_year
    end
  end

  def down
  end
end
