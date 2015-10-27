class TreatmentRequestAttachments < ActiveRecord::Migration
  def up
    create_table :treatment_request_attachments, :force => true do |t|
      t.integer :request_id, :null => false
      t.attachment :attachment
      t.string :attachment_name, :limit => 100
      t.datetime :created_at
    end
  end

  def down
  end
end
