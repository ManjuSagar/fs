class FieldStaffCredentials < ActiveRecord::Migration
  def up
    create_table :field_staff_credentials, :force => true do |t|
      t.integer :field_staff_id, :null => false
      t.integer :credential_type_id, :null => false
      t.date :expiry_date
      t.attachment :attachment
      t.string :comments
      t.string :credential_status, :limit => 1, :null => false
    end
  end

  def down
  end
end
