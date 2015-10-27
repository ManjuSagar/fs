class TreatmentVisitVisitTypeChanges < ActiveRecord::Migration
  def up
    change_column :treatment_visits, :visit_type_id, :integer, :null => false
  end

  def down
  end
end
