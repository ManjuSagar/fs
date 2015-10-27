class AddActiveDirectoriesToPatientDetail < ActiveRecord::Migration
  def change
    add_column :patient_details, :advanced_directive, :string, :limit => 1, default: '3', null: false
  end
end
