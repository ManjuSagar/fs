class RenameTreatmentDisciplineIdInTreatmentVisit < ActiveRecord::Migration
  def change
    rename_column :treatment_visits, :treatment_discipline_id, :discipline_id
    rename_column :visit_frequencies, :treatment_discipline_id, :discipline_id
    add_column :visit_frequencies, :treatment_id, :integer
    VisitFrequency.update_all({:treatment_id => -1})
    change_column :visit_frequencies, :treatment_id, :integer, :null => false
  end
end
