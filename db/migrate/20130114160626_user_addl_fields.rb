class UserAddlFields < ActiveRecord::Migration
  def up
    add_column :users, :middle_initials, :string, :limit => 2
    add_column :users, :suffix, :string, :limit => 10
    add_column :users, :ethnicity, :string, :limit => 20
  end

  def down
  end
end
