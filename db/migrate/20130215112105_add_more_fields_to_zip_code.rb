class AddMoreFieldsToZipCode < ActiveRecord::Migration
  def change
    change_table :zip_codes do |t|
      t.string :admin_name_1      
      t.string :admin_code_1      
      t.string :admin_name_2
      t.string :admin_code_2
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lng, {:precision=>10, :scale=>6}      
    end
  end
end
