class FilterStaffBasedOnPatientPreferenceChanges < ActiveRecord::Migration
  def change
    add_column :treatment_request_staffs, :apply_patient_preference, :string, :limit => 1
    add_column :staffing_requests, :apply_patient_preference, :string, :limit => 1
  end
end
