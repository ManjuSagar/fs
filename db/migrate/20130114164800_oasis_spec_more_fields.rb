class OasisSpecMoreFields < ActiveRecord::Migration
  def up
    add_column :oasis_field_specs, :record_type, :string, :limit => 1
    add_column :oasis_field_specs, :default_value, :string
    add_column :oasis_field_specs, :data_type, :string, :limit => 5
  end

  def down
  end
end
