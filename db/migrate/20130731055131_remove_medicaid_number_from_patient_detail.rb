class RemoveMedicaidNumberFromPatientDetail < ActiveRecord::Migration
  def up
    remove_column :patient_details, :medicaid_number
      end

  def down
    add_column :patient_details, :medicaid_number, :string
  end
end
