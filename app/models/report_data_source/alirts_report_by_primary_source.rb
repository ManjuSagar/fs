module ReportDataSource
  class AlirtsReportByPrimarySource
# Initialize the year at the time of creating the object
    def initialize(year, excess_visits)
      @year = year
      @excess_visits = excess_visits
    end
    # this method is used to get the visits of each primary diagnosis and generate the hash as output
    def get_visits_by_primary_source
      medicare_treatments = get_treatments_by_insurance("MEDICARE")
      tricare_treatments = get_treatments_by_insurance("TRICARE")
      medical_treatments = get_treatments_by_insurance("MEDICAL")
      third_party_treatments = get_treatments_by_insurance(0)
      private_treatments = get_treatments_by_insurance("private")
      hmo_ppo_treatments = get_treatments_by_insurance("HMO")
      no_reimbur_treatments = get_treatments_by_insurance(0)
      other_treatments = get_treatments_by_insurance(0)
      excess_visits = @excess_visits.last
      primary_source_of_payments = []
      primary_source_of_payments <<  {line_number: 91, reimbursement_source: "Medicare", payment_visits_count: get_visits_by_source(medicare_treatments)}
      primary_source_of_payments <<  {line_number: 92, reimbursement_source: "Medi-Cal", payment_visits_count: get_visits_by_source(medical_treatments)}
      primary_source_of_payments <<  {line_number: 93, reimbursement_source: "TRICARE (CHAMPUS)", payment_visits_count: get_visits_by_source(tricare_treatments)}
      primary_source_of_payments <<  {line_number: 94, reimbursement_source: "Other Third Party (Insurance., etc)", payment_visits_count: get_visits_by_source(third_party_treatments)}
      primary_source_of_payments <<  {line_number: 95, reimbursement_source: "Private (Self Pay)", payment_visits_count: get_visits_by_source(private_treatments)}
      primary_source_of_payments <<  {line_number: 96, reimbursement_source: "HMO/PPO (Includes Medicare and Medi-Cal HMOs)", payment_visits_count: get_visits_by_source(hmo_ppo_treatments)}
      primary_source_of_payments <<  {line_number: 97, reimbursement_source: "No Reimbursement", payment_visits_count: get_visits_by_source(no_reimbur_treatments)}
      primary_source_of_payments <<  {line_number: 99, reimbursement_source: "Other (Incl., MSSP)", payment_visits_count: get_visits_by_source(other_treatments)}
      primary_source_of_payments << {line_number: '**',reimbursement_source: "Non covered visits",payment_visits_count: excess_visits[:non_covered_visits_count]}
      total_treatment_visits = 0
      total_treatment_visits = total_treatment_visits + get_visits_by_source(medicare_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(tricare_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(medical_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(third_party_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(private_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(hmo_ppo_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(no_reimbur_treatments)
      total_treatment_visits = total_treatment_visits + get_visits_by_source(other_treatments)
      total_treatment_visits += primary_source_of_payments.last[:payment_visits_count]
      primary_source_of_payments <<  {line_number: 100, reimbursement_source: "TOTAL", payment_visits_count: total_treatment_visits.to_i}
    end
    # get the patient treatments by supplying primary_source of payment as input parameter
    # output is the patient treatments
    def get_treatments_by_insurance(company_code)
      lists_of_patients = PatientTreatment.org_scope.where("EXTRACT(YEAR FROM treatment_start_date)='#{@year}'")
      join1 = lists_of_patients.joins("INNER JOIN treatment_episodes ON patient_treatments.id = treatment_episodes.treatment_id")
      join2 = join1.joins("INNER JOIN documents ON treatment_episodes.id = documents.treatment_episode_id")
      join3 = join2.joins("INNER JOIN treatment_requests ON patient_treatments.treatment_request_id = treatment_requests.id")
      join4 = join3.joins("INNER JOIN insurance_companies ON treatment_requests.insurance_company_id = insurance_companies.id")

      patient_treatments = if company_code == "private"
                             join4.where("insurance_companies.company_code NOT IN('MEDICARE','MEDICAL','TRICARE','HMO')
                             and documents.document_type='PlanOfCare'")
                           else
                             join4.where("insurance_companies.company_code='#{company_code}' and documents.document_type='PlanOfCare'")
                           end
      patient_treatments
    end
    # get the total visits of each primary source of payment by taking patient treatments as parameter
    def get_visits_by_source(patient_treatments)
      return 0 if patient_treatments.empty?
      treatment_visits = 0
      patient_treatments.each do |treatment|
        treatment_visits += treatment.treatment_visits.select{|v| v.visit_date.year == @year}.count if treatment.treatment_visits.present?
      end
      treatment_visits
    end
  end
end