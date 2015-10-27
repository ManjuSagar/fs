class CreateMedicalOrderSequence < ActiveRecord::Migration

  def change
    create_table :medical_order_sequences do |t|
      t.integer :org_id, :null => false
      t.date :date, :null => false
      t.integer :sequence, :null => false
      t.integer :lock_version
    end

    add_column :medical_orders, :order_reference, :string
    MedicalOrder.update_all(:order_reference => "1")
    change_column :medical_orders, :order_reference, :string, :null => false

  end
end