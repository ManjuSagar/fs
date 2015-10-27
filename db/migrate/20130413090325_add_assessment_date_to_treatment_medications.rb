class AddAssessmentDateToTreatmentMedications < ActiveRecord::Migration
  def change
    add_column :treatment_medications, :assessment_date, :date
    TreatmentMedication.update_all(:assessment_date => Date.current)
    change_column :treatment_medications, :assessment_date, :date, :null => false
  end
end
