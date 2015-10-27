class ChangeStartDateEndDateNotnullInMedication < ActiveRecord::Migration
  def up
    TreatmentMedication.update_all(:start_date => Date.today, :end_date => Date.today)
    change_column :treatment_medications, :start_date, :date, :null => false
    change_column :treatment_medications, :end_date, :date, :null => false
  end

  def down
  end
end
