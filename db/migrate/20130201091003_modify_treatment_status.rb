class ModifyTreatmentStatus < ActiveRecord::Migration
  def change
    change_column :patient_treatments, :treatment_status, :string, :limit => 1, :null => false
    change_column :treatment_disciplines, :treatment_status, :string, :limit => 1, :null => false

    drop_table :activity_types
    change_column :treatment_activities, :activity_type, :string, :limit => 1, :null => false
  end
end
