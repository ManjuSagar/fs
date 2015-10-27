class AddPurposeToPayables < ActiveRecord::Migration
  def self.up
    add_column :payables, :purpose, :string, :limit => 100
  end
  def self.down
    remove_column :payables, :purpose
  end
end
