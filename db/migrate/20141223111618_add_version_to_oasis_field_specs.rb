class AddVersionToOasisFieldSpecs < ActiveRecord::Migration

  def change
    add_column :oasis_field_specs, :oasis_spec_version, :string
  end
end