class AddOrgIdToInsuranceCompany < ActiveRecord::Migration
  def change
    add_column :insurance_companies, :org_id, :integer

    insu_list = InsuranceCompany.all

    health_agencies = Org.where(:org_type => "HealthAgency")

    health_agencies.each do |h|
      Org.current = h
      insu_list.each{|insur|
        new_insurance = h.insurance_companies.create!(insur.attributes.reject{|k,v| ["id", "org_id", "lock_version"].include? k.to_s})
        insur.insurance_company_visit_type_rates.each{|vt|
          new_insurance.insurance_company_visit_type_rates.create!(vt.attributes.reject{|k,v| ["id", "insurance_company_id", "lock_version"].include? k.to_s})
        }
      }
    end



  end
end
