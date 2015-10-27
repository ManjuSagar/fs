class ChangeLimitRelationshipToPatient < ActiveRecord::Migration
  def up
    change_column :patient_caregivers, :relation_to_patient, :string, :limit => 50, null: false
  end

  def down
  end
end
