class ChangeTheSizeOfReferenceNumber < ActiveRecord::Migration
  change_column :patient_details, :patient_reference, :string, :limit => 20
  change_column :medical_orders, :order_reference, :string, :limit => 20
  change_column :patient_treatments, :treatment_reference, :string, :limit => 20
  change_column :patient_caregivers, :relation_to_patient, :string, :limit => 1
  rename_column :patient_caregivers, :primary_flat, :primary_flag
end
