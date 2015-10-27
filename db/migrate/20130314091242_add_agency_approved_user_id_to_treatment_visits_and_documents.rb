class AddAgencyApprovedUserIdToTreatmentVisitsAndDocuments < ActiveRecord::Migration
  def change
    add_column :treatment_visits, :agency_approved_user_id, :integer
    add_column :documents, :agency_approved_user_id, :integer
  end
end
