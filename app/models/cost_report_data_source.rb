class CostReportDataSource
  include CostReportRelatedMethods
  attr_accessor :year, :date, :medicare_service_covered_areas

  def initialize(params)
    @year = params[:date].year if params[:date]
    @date = params[:date]
  end

  def cost_visits
    statistical_data = ReportDataSource::CostReportStasticalData.new(year)
    statistical_data.cost_visits
  end

  def msa_codes_list
    msa_codes = ReportDataSource::MsaCodesList.new(year)
    @medicare_service_covered_areas = msa_codes.medicare_service_covered_areas
    msa_codes.msa_codes_list
  end

  def medicare_services_area_count
    msa_codes = ReportDataSource::MsaCodesList.new(year)
    msa_codes.medicare_services_area_count
  end

  def pps_visits
    pps_data = ReportDataSource::CostReportPpsActivityData.new(year)
    pps_data.pps_visits
  end

  def treatment_visits_count
    cost_and_computation = ReportDataSource::CostReportMedicareCostAndComputation.new(year, medicare_service_covered_areas)
    cost_and_computation.treatment_visits_count
  end

  def reimbursement_settlement
    reimbursement_settlement = ReportDataSource::CostReportReimbursementSettlement.new(year)
    reimbursement_settlement.reimbursement_settlement
  end


  def medicare_visits(dis)
    TreatmentVisit.where("treatment_visits.id in (SELECT tv.id FROM treatment_visits tv WHERE
    tv.visit_status = 'C' AND EXTRACT(YEAR FROM tv.visit_start_time) = #{year} AND tv.discipline_id = #{dis} AND tv.treatment_id
    IN (SELECT pt.id FROM patient_treatments pt INNER JOIN patient_details pd ON pt.patient_id = pd.patient_id AND pd.org_id = #{org.id}
    INNER JOIN treatment_requests tr ON pt.treatment_request_id = tr.id WHERE tr.insurance_company_id IN
      (SELECT id FROM insurance_companies WHERE company_code = 'MEDICARE')))")
  end

  def charges_for_medicare_visits(dis)
    treatment_visits = medicare_visits(dis)
    cost = treatment_visits.collect{|v| v.payable_rate}.sum.to_i if treatment_visits
  end

  def total_visits(dis)
    (medicare_visits_count(dis).to_i + non_medicare_visits_count(dis).to_i)
  end

  def total_charges_of_medicare_visits
    visit_charges = 0
    Discipline.all.each{|dis| visit_charges += charges_for_medicare_visits(dis.id)}
    visit_charges
  end

  def total_medicare_episodes
    visits = Discipline.all.collect { |dis| medicare_visits(dis.id)}
    episodes = visits.flatten.collect{|v| v.treatment_episode}.size
  end

end