module ReportDataSource
  class VisitsByTypeOfStaff
    def initialize(year, excess_visits)
      @year = year
      @excess_visits = excess_visits
    end

    def visit_by_type_of_staff
      line_numbers = [71,72,73,74,75,76,77,78,79,84]
      type_of_staff = ["Home Health Aide","Nutritionist (Diet Counseling)","Occuptational Therapist","Physical Therapist",
                       "Physician","Skilled Nursing","Social Worker","Speech Pathologist/Audiologist","Spiritual and Pastoral Care",
                       "Other, Specify:"]
      treatment_visits = []
      patient_treatments = PatientTreatment.org_scope.where("EXTRACT(YEAR FROM patient_treatments.treatment_start_date)='#{@year}' and patient_treatments.id in
       (select treatment_id from documents where document_type = 'PlanOfCare')")
      patient_treatments.each do |treatment|
        treatment_visits += treatment.treatment_visits.select{|tv| tv.visit_start_time.year == @year}
      end
      disciplines = treatment_visits.collect {|t| [t.discipline_id,t.visit_start_time.year]}.delete_if{|a| a[0].blank?}
      excess_visits = @excess_visits.last
      discipline = []
      discipline_count = []
      visit_by_type_count = []
      disciplines.each do |d|
        discipline<< d if d[1] == @year
      end
      discipline_count << discipline.flatten.count(32)
      discipline_count << 0
      discipline_count << discipline.flatten.count(28)
      discipline_count << discipline.flatten.count(27)
      discipline_count << 0
      discipline_count << discipline.flatten.count(30)
      discipline_count << discipline.flatten.count(31)
      discipline_count << discipline.flatten.count(29)
      discipline_count << 0
      discipline_count << 0
      discipline_count << 0
      type_of_staff.each_with_index do |s,index|
        visit_by_type_count << {:line_number=> line_numbers[index],:discipline=> s,:discipline_visits_count=> discipline_count[index]}
      end
      visit_by_type_count << {line_number: '**',discipline: "Visits not covered by a plan of care", discipline_visits_count: excess_visits[:non_covered_visits_count]}
      visit_by_type_count << {:line_number=> 85,:discipline=> "TOTAL",:discipline_visits_count=> discipline.count + visit_by_type_count.last[:discipline_visits_count].to_i}
    end
  end
end