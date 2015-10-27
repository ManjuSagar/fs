class AddColumnVisitsCountToVisitFrequencies < ActiveRecord::Migration
  def change
    add_column :visit_frequencies, :visits_count, :integer, :default => 00
  end
end
