class RenameActivityTypeToTreatmentActivity < ActiveRecord::Migration
  def change
    remove_column :treatment_activities, :activity_type_id
    add_column :treatment_activities, :activity_type, :string, :null => false
    rename_column :treatment_activities, :activity_remarks, :activity_details
  end

end
