class VisitWorkflowRelatedChanges < ActiveRecord::Migration
  def change
    add_column :treatment_visits, :fs_sign_required, :boolean
    add_column :treatment_visits, :supervisor_sign_required, :boolean
    add_column :treatment_visits, :os_sign_required, :boolean
  end
  
end
