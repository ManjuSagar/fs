class CreateScheduledVisits < ActiveRecord::Migration

  def change
    create_table :scheduled_visits do |t|
      t.date :scheduled_date, :null => false
      t.string :start_time, :limit => 4
      t.string :end_time, :limit => 4
      t.integer :visit_type_id, :null => false
      t.integer :field_staff_id, :null => false
      t.integer :visit_id
      t.integer :treatment_episode_id, :null => false
      t.integer :treatment_id, :null => false

      t.integer :lock_version
      t.timestamps
    end
  end
end