class ChangeFrequencyStringLimitInTreatmentVisit < ActiveRecord::Migration
  def change
    change_column :treatment_visits, :frequency_string, :string, :limit => 100
  end
end
