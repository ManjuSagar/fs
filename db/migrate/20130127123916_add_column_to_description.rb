class AddColumnToDescription < ActiveRecord::Migration
  def change
    add_column :oasis_field_specs, :field_description, :string
  end
end
