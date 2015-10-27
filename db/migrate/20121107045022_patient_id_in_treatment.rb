class PatientIdInTreatment < ActiveRecord::Migration
  def up
    add_column :patient_treatments, :patient_id, :integer, :null => false
    change_column :patient_treatments, :treatment_request_id, :integer, :null => true
  end

  def down
  end
end
