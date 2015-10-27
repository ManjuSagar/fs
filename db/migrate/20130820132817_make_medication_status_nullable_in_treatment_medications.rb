class MakeMedicationStatusNullableInTreatmentMedications < ActiveRecord::Migration
  def change
    change_column :treatment_medications, :medication_status, :string, :limit => 1, :null => false
    change_column :treatment_medications, :medication_code, :string, :limit => 1, :null => true
  end
end
