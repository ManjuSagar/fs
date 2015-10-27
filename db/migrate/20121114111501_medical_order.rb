class MedicalOrder < ActiveRecord::Migration
  def up
    create_table :medical_orders, :force => true do |t|
      t.date :order_date, :null => false
      t.text :order_content
      t.integer :treatment_id, :null => false
      t.integer :order_type_id, :null => false
      t.integer :treatment_episode, :null => false
      t.integer :physician_id, :null => false
      t.integer :created_user_id, :null => false
      t.integer :signed_user_id, :null => false
    end

    create_table :order_types, :force => true do |t|
      t.string :type_description, :limit => 50, :null => false
    end
  end

  def down
  end
end
