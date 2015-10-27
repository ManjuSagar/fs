class AddVisitTypeToVisit < ActiveRecord::Migration

  def change
    add_column :treatment_visits, :visit_type_id, :integer
  end

end
