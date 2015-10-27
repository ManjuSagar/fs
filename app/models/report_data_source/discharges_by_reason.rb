module ReportDataSource
  class DischargesByReason

    def initialize(year)
      @year = year
    end


    def dischanges_by_reason
      discharge_reasons = ["Admitted to Hospital", "Admitted to SN/IC Facility", "Death", "Family/Friends Assummed Responsibility",
                           "Lack of Funds", "Lack of Progress", "No Further Home Health Care Needed",
                           "Patient Moved out of Area", "Patient Refused Service", "Physician Request",
                           "Transferred to Another HHA","Transferred to Home Care (Personal Care)", "Transferred to Hospice", "Transferred to Outpatient Rehabilitation", "Other, Specify:"]
      discharge_count = [reason_09 = [], reason_03_04 = [], reason_20_40_41_42 = [],reason_C = [],reason_A = [],  reason_B = [], reason_01 = [],
                         reason_D = [], reason_E = [], reason_F = [], reason_05 = [],reason_63 = [], reason_50 = [],
                         reason_G = [],other = []]
      line_numbers = [41,42,43,44,45,46,47,48,49,50,51,52,53,54,59]
      discharges_by_reasons = []
      codes = []
      treatment_activities = TreatmentActivity.org_scope.includes(:treatment).where("patient_treatments.treatment_status = 'D'
                          and activity_type='D' and EXTRACT(year from activity_date)='#{@year}'").uniq_by(&:treatment_id)
      # return if treatment_activities.empty?
      treatment_activities = treatment_activities.collect { |ta| ta.activity_reason_code }

      treatment_activities.each do |code|
        if ['03','04'].include?code
          reason_03_04 << code
        elsif code == '09'
          reason_09 << code
        elsif ['20','40','41','42'].include?code
          reason_20_40_41_42 << code
        elsif code == '01'
          reason_01 << code
        elsif code == '05'
          reason_05 << code
        elsif code == '63'
          reason_63 << code
        elsif code == '50'
          reason_50 << code
        elsif code == 'A'
          reason_A << code
        elsif code == 'B'
          reason_B << code
        elsif code == 'C'
          reason_C << code
        elsif code == 'D'
          reason_B << code
        elsif code == 'E'
          reason_A << code
        elsif code == 'F'
          reason_B << code
        elsif code == 'G'
          reason_A << code
        else
          other << code
        end
      end
      discharge_reasons.each_with_index do |d, index|       
        discharges_by_reasons << {line_number: line_numbers[index],reason: d, discharges_count: discharge_count[index].count }
      end
      total  = discharges_by_reasons.map { |h| h.values_at(:discharges_count) }.transpose.map { |v| v.inject(:+) }
      discharges_by_reasons << {line_number: 60,reason: "<b>TOTAL</b>", discharges_count: total.first }
      discharges_by_reasons
    end

  end
end