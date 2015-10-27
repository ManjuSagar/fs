class AddCertificationCoPayToInsuranceCompanies < ActiveRecord::Migration
  def change
    add_column :insurance_companies, :certification_period, :integer

    add_column :insurance_companies, :co_pay_applicable, :boolean
    
  end
end
