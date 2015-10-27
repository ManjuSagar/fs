class CommunicationNotes < ActiveRecord::Migration
  def up
    create_table :communication_notes, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :treatment_episode_id, :null => false
      t.integer :physician_id, :null => false
      t.date :note_date, :null => false
      t.text :note_content
      t.string :note_status, :limit => 1, :null => false
      t.integer :created_user_id, :null => false
      t.integer :signed_user_id
      t.date :signed_date
      t.integer :lock_version, :default => 0
    end
  end

  def down
  end
end
