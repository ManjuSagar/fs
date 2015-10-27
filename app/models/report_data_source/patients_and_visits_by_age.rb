module ReportDataSource
  class PatientsAndVisitsByAge
    attr_accessor :year
    def initialize(date, excess_visits)
      @year = date.year
      @date = date
      @excess_visits = excess_visits
    end

    def patients_and_visits_by_age
      age_ranges = ["0 - 10 Years", "11 - 20 Years", "21 - 30 Years", "31 - 40 Years", "41 - 50 Years", "51 - 60 Years", "61-70 Years",
                    "71 - 80 Years", "81 - 90 Years", "91 Years and Older"]
      patients_list = []
      line_numbers = [1,2,3,4,5,6,7,8,9,10]
      patient_count = [count_0_10=[], count_11_20 = [], count_21_30 =[], count_31_40=[], count_41_50=[], count_51_60=[],
                       count_61_70=[], count_71_80=[],count_81_90 = [], count_91 = []]
      visit_count = [visits_0_10=[], visits_11_20 = [], visits_21_30 =[], visits_31_40=[], visits_41_50=[], visits_51_60=[],
                     visits_61_70=[], visits_71_80=[],visits_81_90 = [], visits_91 = []]
      # non_covered_visits =
      poc_present = false
      patient_treatments = PatientTreatment.org_scope.where("EXTRACT(YEAR FROM patient_treatments.treatment_start_date)='#{@year}' and patient_treatments.id in
       (select treatment_id from documents where document_type = 'PlanOfCare')")
      patient_treatments.each do |treatment|
        next unless treatment.patient.dob
        age = ((@date.end_of_year - treatment.patient.dob)/365.0).to_i
        case age
          when 0..10
            count_0_10 << treatment.patient
            visits_0_10 << get_treatment_visits_count(treatment)
          when 11..20
            count_11_20 << treatment.patient
            visits_11_20 << get_treatment_visits_count(treatment)
          when 21..30
            count_21_30 << treatment.patient
            visits_21_30 << get_treatment_visits_count(treatment)
          when 31..40
            count_31_40 << treatment.patient
            visits_31_40 << get_treatment_visits_count(treatment)
          when 41..50
            count_41_50 << treatment.patient
            visits_41_50 << get_treatment_visits_count(treatment)
          when 51..60
            count_51_60 << treatment.patient
              visits_51_60 << get_treatment_visits_count(treatment)
          when 61..70
            count_61_70 << treatment.patient
            visits_61_70 << get_treatment_visits_count(treatment)
          when 71..80
            count_71_80 << treatment.patient
            visits_71_80 << get_treatment_visits_count(treatment)
          when 81..90
            count_81_90 << treatment.patient
            visits_81_90 << get_treatment_visits_count(treatment)
          when 91..200
            count_91 << treatment.patient
            visits_91 << get_treatment_visits_count(treatment)
        end
      end

      age_ranges.each_with_index do |age, index|
        count = visit_count[index].compact.inject{|sum,x| sum + x }
        count = count.nil? ? 0 : count

        patients_list << {line_number: line_numbers[index],age: age, patients_count: patient_count[index].count, visits_count: count}
      end
      excess_visits = @excess_visits.last

      patients_list << {line_number: '**',age: "Non covered visits", patients_count: excess_visits[:non_covered_patients_count].to_i,
                        visits_count: excess_visits[:non_covered_visits_count]}
      total_patients_visits_count = patients_list.map { |h| h.values_at(:patients_count, :visits_count) }.transpose.map { |v| v.inject(:+) }
      patients_list << {line_number: 15, age: "<b>TOTAL</b>", patients_count: total_patients_visits_count.first, visits_count: total_patients_visits_count.last.to_i}
      patients_list

    end

    def get_treatment_visits_count(tr)
      tr.treatment_visits.select{|v| v.visit_date.year == year}.count if tr.treatment_visits.present?
    end
  end
end

