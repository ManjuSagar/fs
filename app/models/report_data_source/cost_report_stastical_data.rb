module ReportDataSource
  class CostReportStasticalData
    include CostReportRelatedMethods
    attr_accessor :year

    def initialize(year)
      @year = year
    end

    def cost_visits
      count = [1,2,3,4,5,6,7,8,9,10]
      visits = get_the_cost_visits_list_by_discipline
      totals = get_totals_of_cost_visits(visits)
      visits = (visits + totals)
      visits.each_with_index do |v,i|
        v[:report_count] = count[i]
      end
      visits
    end

    def get_the_cost_visits_list_by_discipline
      visits = []
      disciplines_for_cost_report.each do |dis|
        medicare_visits_count = medicare_visits_count(dis.id)
        non_medicare_visits_count = non_medicare_visits_count(dis.id)
        total_visits = medicare_visits_count.to_i + non_medicare_visits_count.to_i
        medicare_patient_count = medicare_patients_count(dis.id)
        non_medicare_patients_count = non_medicare_patients_count(dis.id)
        total_patients = medicare_patient_count.to_i + non_medicare_patients_count.to_i
        discipline_description = case dis.discipline_description
                                   when "Speech Therapy" then "Speech Pathology"
                                   when "Social Worker"  then "Medical Social Services"
                                   else
                                     dis.discipline_description
                                 end
        visits << {:description => discipline_description, :medicare_visits => medicare_visits_count, :other_visits => non_medicare_visits_count,
                   :total_visits => total_visits, :medicare_patients => medicare_patient_count,
                   :other_patients => non_medicare_patients_count, :total_patients => total_patients
        }
      end
      visits
    end

    def non_medicare_visits_count(disc)
      visits = count_non_medicare_visits_group_by_discipline.to_hash.detect{|x| x["discipline_id"] == disc.to_s}
      visits.present? ? visits["count"] : 0
    end


    def count_medicare_visits_group_by_discipline
      visits = ActiveRecord::Base.connection.exec_query("SELECT tv.discipline_id, COUNT(*) FROM treatment_visits tv
    WHERE tv.visit_status = 'C' AND EXTRACT(YEAR FROM tv.visit_start_time) = #{year} AND tv.treatment_id IN
    (SELECT pt.id FROM patient_treatments pt INNER JOIN patient_details pd ON pt.patient_id = pd.patient_id AND pd.org_id = #{org.id}
    AND EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}' INNER JOIN treatment_requests tr ON pt.treatment_request_id = tr.id WHERE tr.insurance_company_id IN
      (SELECT id FROM insurance_companies WHERE company_code = 'MEDICARE')) GROUP BY tv.discipline_id")
    end

    def count_non_medicare_visits_group_by_discipline
      visits = ActiveRecord::Base.connection.exec_query("SELECT tv.discipline_id, COUNT(*) FROM treatment_visits tv WHERE tv.visit_status = 'C'
    AND EXTRACT(YEAR FROM tv.visit_start_time) = #{year} AND tv.treatment_id IN
      (SELECT pt.id FROM patient_treatments pt INNER JOIN patient_details pd ON pt.patient_id = pd.patient_id AND pd.org_id = #{org.id}
     AND EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}' INNER JOIN treatment_requests tr ON pt.treatment_request_id = tr.id WHERE tr.insurance_company_id IN
      (SELECT id FROM insurance_companies WHERE company_code <> 'MEDICARE')) GROUP BY tv.discipline_id")
    end

    def medicare_visits_count(disc)
      visits = count_medicare_visits_group_by_discipline.to_hash.detect{|x| x["discipline_id"] == disc.to_s}
      res = visits.present? ? visits["count"] : 0
      res
    end

    def medicare_patients_count(disc)
      patients = medicare_patients.to_hash.detect{|x| x["discipline_id"] == disc.to_s}
      patients.present? ? patients["count"] : 0
    end

    def medicare_patients
      patients = ActiveRecord::Base.connection.exec_query("SELECT trd.discipline_id, COUNT(DISTINCT tr.patient_id)
      FROM treatment_requests tr INNER JOIN treat_req_disciplines trd ON tr.id = trd.request_id
      WHERE tr.insurance_company_id IN (SELECT id FROM insurance_companies where company_code = 'MEDICARE') AND tr.id IN
      (SELECT pt.treatment_request_id FROM patient_treatments pt INNER JOIN patient_details pd
      ON pt.patient_id = pd.patient_id AND pd.org_id = '#{org.id}' WHERE EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}')
      GROUP BY trd.discipline_id")
    end

    def non_medicare_patients_count(disc)
      patients = non_medicare_patients.to_hash.detect{|x| x["discipline_id"] == disc.to_s}
      patients.present? ? patients["count"] : 0
    end

    def non_medicare_patients
      patients = ActiveRecord::Base.connection.exec_query("SELECT trd.discipline_id, COUNT(DISTINCT tr.patient_id)
    FROM treatment_requests tr INNER JOIN treat_req_disciplines trd ON tr.id = trd.request_id WHERE tr.insurance_company_id
    IN (SELECT id FROM insurance_companies where company_code <> 'MEDICARE') AND tr.id IN
    (SELECT pt.treatment_request_id FROM patient_treatments pt INNER JOIN patient_details pd ON pt.patient_id = pd.patient_id
    AND pd.org_id = '#{org.id}' WHERE EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}') GROUP BY trd.discipline_id")
    end

    def get_totals_of_cost_visits(visits)
      totals = []
      patients = {medicare_patients: medicare_patient_count, other_patients: non_medicare_patient_count}
      total_patient_count = {medicare_patients: visits.collect{|x| x[:medicare_patients].to_i}.sum ,other_patients: visits.collect{|x| x[:other_patients].to_i}.sum  ,total_patients: visits.collect{|x| x[:total_patients]}.sum}
      total_patients = {total_patients: patients.values.sum}.merge(total_patient_count)
      total_patient = {total_patients: patients.values.sum}
      totals << get_totals_hash(visits, "All Other Services").merge(total_patients)
      totals << get_totals_hash(visits, "Total Visits [Sum of Lines 1-7]")
      totals << get_totals_hash("Home Health Aide Hours")
      patients_hash = {:description =>"Unduplicated Census Count - Full Cost Reporting Period",:medicare_visits => "",
                       :other_visits => "", :total_visits => ""}.merge(patients).merge(total_patient)
      totals << patients_hash
      totals
    end

    def get_totals_hash(visits = nil, msg)
      medicare_visits = visits.present? ? visits.sum{|x| x[:medicare_visits].to_i} : ""
      other_visits = visits.present? ? visits.sum{|x| x[:other_visits].to_i} : ""
      total_visits =  visits.present? ? visits.sum{|x| x[:total_visits].to_i} : ""
      medicare_visits_count = (msg =="All Other Services") ? "" : medicare_visits
      other_visits_count = (msg =="All Other Services") ? "" : other_visits
      total_visits_count = (msg =="All Other Services") ? "" : total_visits
      {:description => msg, :medicare_visits => medicare_visits_count,
       :other_visits => other_visits_count, :total_visits => total_visits_count,
       :medicare_patients => "", :other_patients => "", :total_patients => ""}
    end

    def medicare_patient_count
      patient_count = ActiveRecord::Base.connection.exec_query("SELECT COUNT(DISTINCT tr.patient_id) FROM treatment_requests tr
      INNER JOIN treat_req_disciplines trd ON tr.id = trd.request_id WHERE tr.insurance_company_id IN (SELECT id FROM insurance_companies
      where company_code = 'MEDICARE') AND tr.id IN (SELECT pt.treatment_request_id FROM patient_treatments pt INNER JOIN
      patient_details pd ON pt.patient_id = pd.patient_id AND pd.org_id = #{org.id} WHERE EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}')")
      count = patient_count.to_hash
      count.present? ? count[0]["count"].to_i : 0
    end

    def non_medicare_patient_count
      count = ActiveRecord::Base.connection.exec_query("SELECT COUNT(DISTINCT tr.patient_id) FROM treatment_requests tr
      INNER JOIN treat_req_disciplines trd ON tr.id = trd.request_id WHERE tr.insurance_company_id IN
      (SELECT id FROM insurance_companies where company_code <> 'MEDICARE') AND tr.id IN (SELECT pt.treatment_request_id FROM
      patient_treatments pt INNER JOIN patient_details pd ON pt.patient_id = pd.patient_id AND pd.org_id = #{org.id}
      WHERE EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}')")
      count = count.to_hash
      count.present? ? count[0]["count"].to_i : 0
    end


  end
end