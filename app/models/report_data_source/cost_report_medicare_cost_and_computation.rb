module ReportDataSource
  class CostReportMedicareCostAndComputation
    include CostReportRelatedMethods
    attr_accessor :year
    def initialize(year, msa_codes)
      @year = year
      @msa_codes = msa_codes
    end

    def treatment_visits_count
      visits_count = []

      treatment_group_by_zipcode = PatientTreatment.org_scope.where("EXTRACT(year from treatment_start_date)=#{year}").group_by(&:zip_code)
      cbsa_codes = @msa_codes.collect{|x| x.cbsa_code}
      cbsa_codes_and_treatments = []
      treatment_group_by_zipcode.each do |zip_code, treatments|
        @treatments = treatments.map(&:id)
        cbsa_code = get_msa_codes(zip_code).cbsa_code
        visits = TreatmentVisit.org_scope.includes(:treatment).where(["treatment_id in (?) and EXTRACT(year from treatment_visits.visit_start_time) = #{year}
                                                              and treatment_visits.visit_status = 'C'",  @treatments]).collect{|x| x.discipline_code}
        cbsa_codes_and_treatments << {cbsa_code: cbsa_code, treatments:
            visits} if cbsa_codes.include? cbsa_code
      end

      visits_group_by_discipline_count = []
      cbsa_codes_and_treatments.each do |x|
        res = x[:treatments].flatten
        visits_group_by_discipline_count << {cbsa_code: x[:cbsa_code], sn_count: res.count("SN"), pt_count: res.count("PT"),
                                               ot_count: res.count("OT"), st_count: res.count("ST"), msw_count: res.count("MSW"),
                                               hha_count: res.count("CHHA")}
      end

      res = visits_group_by_discipline_count.group_by{|x| x[:cbsa_code]}

      final_visit_count = []
      res.each do |r|
        final_visit_count << {"msa_code" => r.first.to_i, "Skilled Nursing" => get_visit_count(r, "sn_count"),
                              "Physical Therapy" => get_visit_count(r, "pt_count"), "Occupational Therapy" => get_visit_count(r, "ot_count"),
                              "Speech Therapy" => get_visit_count(r, "st_count"), "Social Worker" => get_visit_count(r, "msw_count"),
                              "Home Health Aide" => get_visit_count(r, "hha_count")}
      end
      line_numbers = [1,2,3,4,5,6]
      disciplines = disciplines_for_cost_report.collect{ |x| x.discipline_description}
      final_visit_count.each do |visit|
        total_count = visit["Physical Therapy"] + visit["Occupational Therapy"] + visit["Speech Therapy"]+ visit["Social Worker"] +
            visit["Home Health Aide"] + visit["Skilled Nursing"]
          disciplines.each_with_index do |disp, index|
            visits_count << {line_num: line_numbers[index], msa_code: visit["msa_code"], discipline: disp, medicare_program_visit_part_a: visit[disp]}
          end
        visits_count << {line_num: 7, msa_code: visit["msa_code"], discipline: "Total (Sum of lines 1-6)", medicare_program_visit_part_a: total_count}
      end
      visits_count
    end

    def get_visit_count(list, disp)
      disp = disp.to_sym
      res = list.second.collect{|x| x[disp]}.sum
    end


  end
end
