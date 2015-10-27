class ChangeOasisFieldSpecsDataType < ActiveRecord::Migration
  change_column :oasis_field_specs, :data_type, :string, :limit => 20
end