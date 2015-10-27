class LicenseNumberInFs < ActiveRecord::Migration
  def up
    add_column :field_staff_details, :license_number, :string, :limit => 10
  end

  def down
  end
end
