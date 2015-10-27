class AddApplyPatientPreferenceColumnToTreatmentStaffs < ActiveRecord::Migration
  def change
    add_column :treatment_staffs, :apply_patient_preference, :string, :limit => 1
  end
end
