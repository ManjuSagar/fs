module ReportDataSource
  class MsaCodesList
    include CostReportRelatedMethods
    attr_accessor :year

    def initialize(year)
      @year = year
    end

    def msa_codes_list
      msa_codes = []
      medicare_service_covered_areas.each_with_index do |cbsa, i|
        record_number = (i<= 9) ? 29 + ("0.0#{i}").to_f : 29 + ("0.#{i}").to_f
        msa_codes << {:msa_code => cbsa.cbsa_code, :repeating_county =>  ((i==0) ? "F" : "T"),
                      :msa_record_number => ((i==0) ? 29 : record_number)}
      end
      msa_codes
    end

    def msa_medicare_patients
      patients = Patient.where("id in(SELECT DISTINCT tr.patient_id FROM treatment_requests tr WHERE tr.insurance_company_id IN
    (SELECT id FROM insurance_companies where company_code = 'MEDICARE') AND tr.id IN
    (SELECT pt.treatment_request_id FROM patient_treatments pt INNER JOIN patient_details pd ON pt.patient_id = pd.patient_id
    AND pd.org_id = '#{org.id}' WHERE EXTRACT(YEAR FROM pt.treatment_start_date) = '#{year}'))").pluck(:zip_code)
    end


    def medicare_service_covered_areas
      zip_codes = msa_medicare_patients.uniq
      counties = ZipCode.where(["zip_code in (?)", zip_codes]).collect{|x| [x.admin_name_1, x.admin_name_2]}.uniq
      msa_codes = []
      counties.each do |x|
        msa_codes << ProspectivePaymentSystem::MedicareCoreStatArea.where({state_name: x.first, county_name: x.last, calender_year: year}).first
      end
     msa_codes
    end

    def medicare_services_area_count
      medicare_service_covered_areas.size
    end

    def county_code(county_name, state)
      county_name(county_name, state).county_code
    end

  end
end