class AddCreatedUserColumnToTreatmentMedications < ActiveRecord::Migration
  def change
    add_column :treatment_medications, :created_user_id, :integer
  end
end
