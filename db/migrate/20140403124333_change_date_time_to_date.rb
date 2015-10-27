class ChangeDateTimeToDate < ActiveRecord::Migration
  def change
    change_column :treatment_activities, :activity_date, :date
  end
end
