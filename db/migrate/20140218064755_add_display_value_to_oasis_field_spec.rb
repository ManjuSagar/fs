class AddDisplayValueToOasisFieldSpec < ActiveRecord::Migration
  def change
    add_column :oasis_field_specs, :display_value, :string
  end
end
