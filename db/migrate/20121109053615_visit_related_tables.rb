class VisitRelatedTables < ActiveRecord::Migration
  def up
    add_column :documents, :treatment_episode_id, :integer
    add_column :documents, :physician_id, :integer

    create_table :treatment_episodes, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false
    end

    create_table :visit_frequencies, :force => true do |t|
      t.integer :treatment_discipline_id, :null => false
      t.integer :treatment_episode_id, :null => false
      t.integer :medical_order_id, :null => false
      t.string :frequency_string, :limit => 10, :null => false
      t.integer :unit_count, :null => false
      t.string :frequency_unit, :limit => 1, :null => false
      t.integer :visits_per_unit, :null => false
      t.string :frequency_status, :null => false
    end

    create_table :visit_frequency_field_staffs, :force => true do |t|
      t.integer :frequency_id, :null => false
      t.integer :field_staff_id, :null => false
    end

    create_table :visit_frequency_details, :force => true do |t|
      t.integer :frequency_id, :null => false
      t.integer :visit_id
      t.string :detail_status, :limit => 1, :null => false
    end

    create_table :treatment_visits, :force => true do |t|
      t.integer :treatment_discipline_id, :null => false
      t.integer :treatment_episode_id, :null => false
      t.integer :visited_user_id, :null => false
      t.timestamp :visit_start_time, :null => false
      t.timestamp :visit_end_time, :null => false
    end
  end

  def down
  end
end
