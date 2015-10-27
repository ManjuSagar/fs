class VisitCountForFrequency < ActiveRecord::Migration
  def up
    add_column :treatment_visits, :count_for_frequency_flag, :boolean, :default => true
  end

  def down
  end
end
