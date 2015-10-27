class IncreasePatientReferenceLimit < ActiveRecord::Migration
  def up
    change_column :patient_details, :patient_reference, :string, :limit => 255
  end

  def down
  end
end
