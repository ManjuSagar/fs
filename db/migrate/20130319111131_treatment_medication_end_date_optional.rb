class TreatmentMedicationEndDateOptional < ActiveRecord::Migration
  def change
    change_column :treatment_medications, :end_date, :date, :null => true
  end
end
