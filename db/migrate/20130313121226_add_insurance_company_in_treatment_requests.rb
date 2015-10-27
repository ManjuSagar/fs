class AddInsuranceCompanyInTreatmentRequests < ActiveRecord::Migration
  def up    
    add_column :treatment_requests, :insurance_company_id, :integer
    add_column :treatment_requests, :certification_period, :integer
  end

  def down
  end
end
