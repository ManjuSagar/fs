class ReconvertDateToDatetimeForTreatmentActivities < ActiveRecord::Migration
  def up
    change_column :treatment_activities, :activity_date, :datetime
  end

  def down
  end
end
