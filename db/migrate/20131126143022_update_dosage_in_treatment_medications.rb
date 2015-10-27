class UpdateDosageInTreatmentMedications < ActiveRecord::Migration
  def up
    TreatmentMedication.all.each{|tm|
      v = tm.medication_name
      tm.dosage = v.include?('(') ? v.split("(").last.split(")").first : nil
      tm.save
    }
  end

  def down
  end
end
