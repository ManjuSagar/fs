class ChangeColumnSizeInOasisExports < ActiveRecord::Migration
  def up
    change_column :oasis_exports, :export_reference, :string, :limit => 255
  end

  def down
    change_column :oasis_exports, :export_reference, :string, :limit => 20
  end
end