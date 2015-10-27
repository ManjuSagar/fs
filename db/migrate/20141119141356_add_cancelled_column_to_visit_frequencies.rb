class AddCancelledColumnToVisitFrequencies < ActiveRecord::Migration
  def change
    add_column :visit_frequencies, :cancelled, :boolean, :default => false
    VisitFrequency.update_all({:cancelled => true})
  end
end
