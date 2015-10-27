class RenamePhysicianPersonalContacts < ActiveRecord::Migration
  def change
    rename_column :org_physicians, :contact_1, :personal_phone_number_1
    rename_column :org_physicians, :contact_2, :personal_phone_number_2
  end
end
