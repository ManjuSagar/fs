class AddInsuranseRelatedAttrsToPatientInsurances < ActiveRecord::Migration
  def change
    if PatientInsuranceCompany.columns_hash["patient_insurance_number"].nil?
		add_column :patient_insurance_companies, :patient_insurance_number, :string
		add_column :patient_insurance_companies, :effective_date, :date
		add_column :patient_insurance_companies, :termination_date, :date
		add_column :patient_insurance_companies, :coverage_details, :text
		add_column :patient_insurance_companies, :primary_insurance_flag, :boolean, :default => false
	end
  end
end
