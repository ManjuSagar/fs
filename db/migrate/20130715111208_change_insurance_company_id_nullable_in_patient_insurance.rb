class ChangeInsuranceCompanyIdNullableInPatientInsurance < ActiveRecord::Migration
  def up
    change_column :patient_insurance_companies, :insurance_company_id, :integer, :null => true
  end

  def down
  end
end
