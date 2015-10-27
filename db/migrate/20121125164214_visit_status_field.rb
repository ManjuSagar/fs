class VisitStatusField < ActiveRecord::Migration
  def up
    add_column :treatment_visits, :visit_status, :string, :limit => 1
    add_column :treatment_visits, :frequency_string, :string, :limit => 4
  end

  def down
  end
end
