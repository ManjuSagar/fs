class IcdCodes < ActiveRecord::Migration
  def up
    create_table :icd_9_codes, :force => true do |t|
      t.string :icd_code, :limit => 10, :null => false
      t.string :short_description, :limit => 100, :null => false
      t.string :long_description, :null => false
      t.string :code_type, :limit => 1, :null => false
    end
    add_index :icd_9_codes, :icd_code, :unique => true
  end

  def down
  end
end
