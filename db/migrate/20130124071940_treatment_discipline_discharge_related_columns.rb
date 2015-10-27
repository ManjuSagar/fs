class TreatmentDisciplineDischargeRelatedColumns < ActiveRecord::Migration
  def change
    change_table :patient_treatments do |t|
      t.timestamp :discharge_date
      t.string :discharge_reason, :limit => 3
      t.text :discharge_remarks
      end

    change_table :treatment_disciplines do |t|
      t.timestamp :discharge_date
      t.string :discharge_reason, :limit => 3
      t.text :discharge_remarks
    end
  end
end
