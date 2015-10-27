module ReportDataSource
  class CostReportReimbursementSettlement
    attr_accessor :year
    def initialize(year)
      @year = year
    end

    def reimbursement_settlement
      pps_array = ["Total reasonable cost (See instructions)","Total PPS Reimbursement - Full Episodes without Outliers",
                   "Total PPS Reimbursement - Full Episodes with Outliers", "Total PPS Reimbursement - LUPA Episodes",
                   "Total PPS Reimbursement - PEP Episodes","Total PPS Reimbursement - SCIC Episodes"]
      computation_of_reimbursement_settlement = []
      line_number = [12,12.01,12.02,12.03,12.04,12.05,12.06]
      pps_array.each_with_index do |p,index|
        computation_of_reimbursement_settlement <<{row_number: line_number[index], total_pps_reimbursement: pps_array[index],
                                                   part_a_services: 0, part_b_services: 0, total: line_number[index]}
      end
      computation_of_reimbursement_settlement
    end
  end
end