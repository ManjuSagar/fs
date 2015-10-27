class RemoveKnownAllergiesFromTreatmentRequest < ActiveRecord::Migration
  def change
    remove_column :treatment_requests, :known_allergies
  end
end
