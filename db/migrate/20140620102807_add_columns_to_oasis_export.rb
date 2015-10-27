class AddColumnsToOasisExport < ActiveRecord::Migration
  def change
    add_column :oasis_exports, :record_type, :string
    add_column :oasis_exports, :correction_num, :integer
    add_column :oasis_exports, :created_at, :datetime
    add_column :oasis_exports, :updated_at, :datetime
  end
end
