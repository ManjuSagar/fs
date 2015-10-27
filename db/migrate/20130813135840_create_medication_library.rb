class CreateMedicationLibrary < ActiveRecord::Migration
  def up
    create_table :medication_libraries do |t|
      t.string :drug_name
      t.string :dosage
      t.string :dosage_form
    end

    MedicationLibrary.destroy_all
    MedicationLibrary.create!(:drug_name => "Actos", :dosage => "EQ 15MG BASE", :dosage_form => "TABLET; ORAL")
    MedicationLibrary.create!(:drug_name => "Actos", :dosage => "EQ 30MG BASE", :dosage_form => "TABLET; ORAL")
    MedicationLibrary.create!(:drug_name => "Actos", :dosage => "EQ 45MG BASE", :dosage_form => "TABLET; ORAL")
    MedicationLibrary.create!(:drug_name => "Noroxin", :dosage => "400MG", :dosage_form => "TABLET; ORAL")

  end

  def down
    drop_table :medication_libraries
  end
end
