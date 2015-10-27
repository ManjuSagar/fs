class AddColumnEndDateToTreatmentMedications < ActiveRecord::Migration
  def change
    add_column :treatment_medications, :end_date, :date
    add_column :treatment_medications, :visit_id, :integer
    change_column :treatment_medications, :start_date, :date
    change_column :treatment_medications, :discontinued_date, :date
    change_column :treatment_medications, :medication_code, :string, :limit => 1, :default => nil
  end
end
