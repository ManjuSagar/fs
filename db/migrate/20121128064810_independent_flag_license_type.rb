class IndependentFlagLicenseType < ActiveRecord::Migration
  def up
    add_column :license_types, :independent_flag, :boolean
  end

  def down
  end
end
