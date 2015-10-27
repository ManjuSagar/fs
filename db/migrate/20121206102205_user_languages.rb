class UserLanguages < ActiveRecord::Migration
  def up
    create_table :user_languages, :force => true do |t|
      t.integer :user_id, :null => false
      t.integer :language_id, :null => false
      t.integer :lock_version, :null => false, :default => 0
    end
    drop_table :patient_languages
  end

  def down
  end
end
