class Attachments < ActiveRecord::Migration
  def up
    create_table :visit_attachments, :force => true do |t|
      t.integer :visit_id, :null => false
      t.attachment :attachment
    end
  end

  def down
  end
end
