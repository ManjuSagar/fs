class LicenseTypeIdRemoveInVisitType < ActiveRecord::Migration
  def up
    remove_column :visit_types, :license_type_id
  end

  def down
  end
end
