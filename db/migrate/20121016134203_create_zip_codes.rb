class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.string :locality, :limit => 50, :null => false
      t.string :zip_code, :limit => 10, :null => false

      t.timestamps
    end
  end
end
