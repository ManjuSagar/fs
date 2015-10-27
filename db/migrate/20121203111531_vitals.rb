class Vitals < ActiveRecord::Migration
  def up
    create_table :treatment_vitals, :force => true do |t|
      t.integer :systolic_bp
      t.integer :diastolic_bp
      t.string :bp_read_position, :limit => 1
      t.integer :heart_rate
      t.integer :respiration_rate
      t.float :temperature_in_fht
      t.integer :blood_sugar
      t.string :sugar_read_period, :limit => 1
      t.integer :weight_gain_loss_in_lbs
      t.integer :oxygen_saturation
      t.integer :treatment_id, :null => false
      t.integer :visit_id
      t.datetime :recorded_date_time
      t.integer :recorded_user_id, :null => false
    end

    create_table :vitals_reference_ranges, :force => true do |t|
      t.integer :org_id, :null => false
      t.string :vital_sign, :null => false
      t.float :minimum_value
      t.float :maximum_value
      t.datetime :last_updated_datetime, :null => false
    end
  end

  def down
  end
end
