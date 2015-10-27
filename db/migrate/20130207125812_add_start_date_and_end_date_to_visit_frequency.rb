class AddStartDateAndEndDateToVisitFrequency < ActiveRecord::Migration
  def change
    VisitFrequency.destroy_all
    add_column :visit_frequencies, :frequency_start_date, :date, :null => false
    add_column :visit_frequencies, :frequency_end_date, :date, :null => false
  end
end
