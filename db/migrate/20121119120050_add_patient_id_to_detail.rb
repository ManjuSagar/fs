class AddPatientIdToDetail < ActiveRecord::Migration
  def change
    add_column :patient_details, :patient_id, :integer, :null => false
  end
end
