class ModifySsnColumnInPatientDetails < ActiveRecord::Migration
  def change
    change_column :patient_details, :ssn, :string, :limit => 11
  end

end
