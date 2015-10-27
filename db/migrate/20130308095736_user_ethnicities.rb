class UserEthnicities < ActiveRecord::Migration
  def up
    create_table :user_ethnicities, :force => true do |t|
      t.integer :user_id, :null => false
      t.string :ethnicity_id, :null => false
      t.integer :lock_version, :null => false, :default => 0
    end
  end

  def down
  end
end
