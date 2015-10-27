class AddTreatmentVisitIdToMedicalOrder < ActiveRecord::Migration
  def change
    add_column :medical_orders, :treatment_visit_id, :integer
  end
end
