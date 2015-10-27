class ConvertDatetimeToDateForTreatmentActivities < ActiveRecord::Migration
  def up
    change_column :treatment_activities, :activity_date, :date
  end

  def down
  end
end
