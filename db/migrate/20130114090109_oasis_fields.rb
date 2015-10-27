class OasisFields < ActiveRecord::Migration
  def up
    create_table :oasis_field_specs, :force => true do |t|
      t.integer :field_sequence
      t.string :field_name, :limit => 100, :null => false
      t.integer :length
      t.integer :start_position
      t.integer :end_position
      t.boolean :rfa_1
      t.boolean :rfa_2
      t.boolean :rfa_3
      t.boolean :rfa_4
      t.boolean :rfa_5
      t.boolean :rfa_6
      t.boolean :rfa_7
      t.boolean :rfa_8
      t.boolean :rfa_9
      t.boolean :rfa_10
    end
  end

  def down
  end
end
