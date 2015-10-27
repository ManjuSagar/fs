class ChangeMrNumberLength < ActiveRecord::Migration
  def up
    change_column :patient_treatments, :treatment_reference, :string, :limit => 255
  end

  def down
  end
end
