class Medications < ActiveRecord::Migration
  def up
    create_table :treatment_medications, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :treatment_episode_id, :null => false
      t.string :medication_name, :null => false
      t.string :medication_code, :limit => 1, :null => false, :default => 'N'
      t.string :dosage
      t.string :frequency
      t.string :purpose
      t.string :potential_side_effects
      t.timestamp :start_date
      t.timestamp :discontinued_date
      t.string :medication_status, :limit => 1, :null => false
    end
  end

  def down
  end
end
