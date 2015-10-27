class TreatmentToVisit < ActiveRecord::Migration
  def up
    add_column :treatment_visits, :treatment_id, :integer, :null => false
    change_column :treatment_visits, :treatment_discipline_id, :integer, :null => true
  end

  def down
  end
end
