class AddInsuranceCompaniesFromReferralToPatient < ActiveRecord::Migration
  def change
    TreatmentRequest.all.each{|request|
      patient = request.patient
      company = request.insurance_company
      next unless company
      if patient.insurance_companies.empty?
        ins = patient.patient_insurance_companies.new(insurance_company: company)
        ins.save(:validate => false)
      elsif patient.insurance_companies(true).find_by_id(company.id).nil?
        ins = patient.patient_insurance_companies.new(insurance_company: company)
        ins.save(:validate => false)
      end
    }
  end
end
