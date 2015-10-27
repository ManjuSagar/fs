class NullifySourceInPayables < ActiveRecord::Migration
  def up
    change_column :payables, :payable_type, :string, :null => true, :limit => 50
    change_column :payables, :source_type, :string, :null => true, :limit => 50
    change_column :payables, :source_id, :integer, :null => true
  end

  def down
    change_column :payables, :source_type, :string, :null => false
    change_column :payables, :source_id, :integer, :null => false
  end
end
