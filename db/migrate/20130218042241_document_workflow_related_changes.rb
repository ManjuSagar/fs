class DocumentWorkflowRelatedChanges < ActiveRecord::Migration
  def change
    add_column :field_staff_details, :review_agency_changes_flag, :boolean, :default => false
    add_column :documents, :creator_sign_required, :boolean
    add_column :documents, :supervisor_sign_required, :boolean
    add_column :documents, :os_sign_required, :boolean
  end
end
