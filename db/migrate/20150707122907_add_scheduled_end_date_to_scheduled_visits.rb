class AddScheduledEndDateToScheduledVisits < ActiveRecord::Migration
  def change
    add_column :scheduled_visits, :scheduled_end_date, :date
  end
end
