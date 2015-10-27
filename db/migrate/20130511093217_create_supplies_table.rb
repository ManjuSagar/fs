class CreateSuppliesTable < ActiveRecord::Migration
  def up
    create_table :supplies do |t|
      t.string :supply_hcpcs_code, :null => false, :limit => 10
      t.string :supply_description, :null => false, :limit => 4000
      t.integer :supply_quantity
      t.decimal :supply_price, :precision => 8, :scale => 2
      t.references :org, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :supplies
  end
end
