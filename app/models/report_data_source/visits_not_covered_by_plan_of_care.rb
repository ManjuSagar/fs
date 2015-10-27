module ReportDataSource
  class VisitsNotCoveredByPlanOfCare
    def initialize(params)
      @year = params[:year]
    end

    def visits_not_covered_by_plan_of_care
      treatment_visits = []
      visits_patients = []
      patient_treatments = PatientTreatment.org_scope.where("EXTRACT(YEAR FROM patient_treatments.treatment_start_date)='#{@year}' and patient_treatments.id not in
       (select treatment_id from documents where document_type = 'PlanOfCare')")
      patient_treatments.each {|treatment|
        episode_visits = treatment.treatment_visits.select{|v| v.visit_date.year == @year}
        next if episode_visits.count == 0
        first_visit = episode_visits.first.visit_start_time.strftime("%m/%d/%Y") if episode_visits.present?
        last_visit = episode_visits.last.visit_start_time.strftime("%m/%d/%Y") if episode_visits.present?
        visits_range = "#{first_visit} - #{last_visit}"
        visits_range = episode_visits.present? ? visits_range : ""
        visits_patients << treatment.patient
        visits_count  = episode_visits.count || 0
        treatment_visits << {:visits => visits_count, :soc => "", :period => visits_range,:patient_mr_num=> treatment.patient.patient_reference,
                             :patient_name => treatment.patient.full_name_with_out_mr_number, :dob => treatment.patient.dob.strftime("%m/%d/%Y"), :status=> "",:icd_9=> "", :insurance_carrier=> "" }
      }
      non_covered_visits_count = treatment_visits.map { |h| h.values_at(:visits) }.transpose.map { |v| v.inject(:+) }
      non_covered_visits_count = non_covered_visits_count.empty? ? 0 : non_covered_visits_count
      total_visits_count = {non_covered_patients_count: visits_patients.uniq.count, non_covered_visits_count: non_covered_visits_count[0]}
      [treatment_visits, total_visits_count]
    end
  end
end