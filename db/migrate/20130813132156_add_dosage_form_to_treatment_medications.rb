class AddDosageFormToTreatmentMedications < ActiveRecord::Migration
  def change
    add_column :treatment_medications, :dosage_form, :string
  end
end
