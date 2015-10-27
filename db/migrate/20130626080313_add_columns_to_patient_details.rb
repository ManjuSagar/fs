class AddColumnsToPatientDetails < ActiveRecord::Migration
  def change
    add_column :patient_details, :dnr, :string, :limit => 1, default: '3', null: false
    add_column :patient_details, :dni, :string, :limit => 1, default: '3', null: false
    add_column :patient_details, :acuity_level, :string, :limit => 1, default: '4', null: false
  end
end
