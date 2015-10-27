class AddOrgIdToFormLibrary < ActiveRecord::Migration
  def change
    add_column :form_library, :org_id, :integer
    DownloadableForm.update_all(:org_id => 633)
    change_column :form_library, :org_id, :integer, null: false
  end
end
