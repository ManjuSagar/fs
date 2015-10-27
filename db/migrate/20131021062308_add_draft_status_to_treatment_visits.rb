class AddDraftStatusToTreatmentVisits < ActiveRecord::Migration
  def change
    add_column :treatment_visits, :draft_status, :boolean, :default => false

    change_column :treatment_visits, :visited_user_id, :integer, :null => true
    change_column :treatment_visits, :visit_type_id, :integer, :null => true
    change_column :treatment_visits, :visited_staff_type, :string, :null => true
    change_column :treatment_visits, :visited_staff_id, :integer, :null => true
    change_column :treatment_visits, :created_user_id, :integer, :null => true
  end
end
