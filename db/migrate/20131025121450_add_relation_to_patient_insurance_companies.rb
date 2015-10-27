class AddRelationToPatientInsuranceCompanies < ActiveRecord::Migration
  def change
    add_column :patient_insurance_companies, :relation_to_insured, :string
  end
end
