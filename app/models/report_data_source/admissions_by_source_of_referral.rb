module ReportDataSource
  class AdmissionsBySourceOfReferral
    attr_accessor :year
    def initialize(year)
      @year = year
    end

    def admission_by_source_of_referral
      line_number = [21,22,23,24,25,26,27,28,29,30,31,32,34]
      source_of_referral = ["Another Home Health Agency","Clinic","Family/Friend","Hospice","Hospital (Discharge Planner, etc)","Local Health Department",
                            "Long Term Care Facility (SN/IC)","MSSP","Payor (Insurer, HMO, etc)","Physician","Self","Social Service Agency","Other, Specify:"]
      source_of_referral_count = []
      point_of_origin = []
      point_of_origin_count = []
      remaining_count = []
      treatments = PatientTreatment.org_scope.includes(:treatment_request).where("EXTRACT(YEAR FROM treatment_start_date)= '#{@year}'")
      treatments.each do |treatment|
        next if treatment.treatment_visits.size == 0
        point_of_origin << treatment.treatment_request.point_of_origin
      end
      point_of_origin = point_of_origin.flatten
      point_of_origin_count<< point_of_origin.count("6")
      point_of_origin_count<< point_of_origin.count("2")
      point_of_origin_count<< point_of_origin.count("13")
      point_of_origin_count<< point_of_origin.count("F")
      point_of_origin_count<< point_of_origin.count("4")
      point_of_origin_count<< point_of_origin.count("A")
      point_of_origin_count<< point_of_origin.count("5")
      point_of_origin_count<< point_of_origin.count("10")
      point_of_origin_count<< point_of_origin.count("3")
      point_of_origin_count<< point_of_origin.count("1")
      point_of_origin_count<< point_of_origin.count("11")
      point_of_origin_count<< point_of_origin.count("12")
      remaining_codes = ['E', '8', '9', 'D']
      point_of_origin.each{|i| remaining_count << i if remaining_codes.include?(i)}
      point_of_origin_count << remaining_count.count
      source_of_referral.each_with_index do |v, index|
        source_of_referral_count << {:line_number => line_number[index], :source_of_referral => v, :admissions => point_of_origin_count[index] }
      end
      source_of_referral_count << {:line_number => 35, :source_of_referral => '<b>TOTAL</b>', :admissions => point_of_origin.count }
     end
  end
end
