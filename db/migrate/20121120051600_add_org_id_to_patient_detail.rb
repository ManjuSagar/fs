class AddOrgIdToPatientDetail < ActiveRecord::Migration
  def change
    add_column :patient_details, :org_id, :integer
  end
end
