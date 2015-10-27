class VisitStaffsRelated < ActiveRecord::Migration
  def up
    add_column :treatment_visits, :supervised_user_id, :integer
    add_column :treatment_visits, :visited_staff_type, :string, :limit => 100, :null => false
    add_column :treatment_visits, :visited_staff_id, :integer, :null => false
  end

  def down
  end
end
