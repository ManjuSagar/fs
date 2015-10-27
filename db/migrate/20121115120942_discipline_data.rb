class DisciplineData < ActiveRecord::Migration
  def up
    change_column :license_types, :license_type_description, :string, :limit => 50, :null => false
  end

  def down
  end
end
