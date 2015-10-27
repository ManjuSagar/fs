class AddRemarksToTreatmentVitals < ActiveRecord::Migration
  def change
     add_column :treatment_vitals, :remarks, :text
  end
end
