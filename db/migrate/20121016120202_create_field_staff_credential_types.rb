class CreateFieldStaffCredentialTypes < ActiveRecord::Migration
  def change
    create_table :field_staff_credential_types do |t|
      t.string :ct_code, :limit => 15, :null => false
      t.string :ct_description, :limit => 100, :null => false
      t.string :discipline_id, :limit => 3, :null => false
      t.boolean :expiry_flag, :null => false
      t.timestamps
    end
  end
end
