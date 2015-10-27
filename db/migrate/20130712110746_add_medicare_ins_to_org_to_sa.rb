class AddMedicareInsToOrgToSa < ActiveRecord::Migration
  def change
    facility_owner = FacilityOwner.first
    if facility_owner.present?
      InsuranceCompany.create(company_name: "Medicare Health Insurance", company_code: "MEDICARE",
       certification_period: 60, co_pay_applicable: false, org_id: facility_owner.id)  unless facility_owner.insurance_companies
    end
  end
end
