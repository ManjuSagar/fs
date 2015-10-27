class ProspectivePaymentSystem::MedicareBillCalculator
  include ProspectivePaymentSystem::BillingRelatedMethods
  attr_reader :hipps_code, :rfa_year, :county_name, :disciplines_codes, :episode_sequence_num, :state

  def initialize(params)
    @rfa_year = params[:rfa_year]
    @county_name = params[:county_name]
    @state = params[:state]
    @hipps_code = params[:hipps_code]
    @disciplines_codes = params[:disciplines_codes]
    @episode_sequence_num = params[:episode_sequence_num]
  end

  def self.hhcmg_software_path(dest_file_path)
    files = Dir.glob("#{master_base_path}/home_health_case_mix_grouper/*")
    unless files.include? ("#{master_base_path}/home_health_case_mix_grouper/Grouper_v3414_1.tables")
      File.delete(dest_file_path) if File.exist?(dest_file_path)
      raise "2014 Release Home Health Case Mix Grouper Software is not updated."
    end
    master_base_path

  end

  def self.master_base_path
    if File.exists? File.join( ENV['HOME'], 'workspace', 'home_health_case_mix_grouper')
      File.join(ENV['HOME'], 'workspace')
    elsif File.exists? File.join( '/', 'workspace', 'home_health_case_mix_grouper')
      File.join('/', 'workspace')
    else
      raise "Sorry. Critical dependent libraries like edi reader not found in environment."
    end
  end

  def rap_and_final_claim_bill_amount
    hipps_code = ProspectivePaymentSystem::HippsCode.find_by_code(hipps_code, rfa_year)
    rural_adjusted__base_amount, supply_add_on_amount =  base_rate_and_supply_add_on_amount
    labor_part, non_labor_part = hhrg_weighted_labor_part_and_non_labor_part(rural_adjusted__base_amount)
    (geo_weight_adjustment_for_labor({labor_part: labor_part, year: rfa_year}) + non_labor_part + supply_add_on_amount.round(2)).round(2)
  end

  def labor_percent
    labor_percentage(rfa_year)
  end

  def base_rate
    standard_rate(rfa_year).base_amt
  end

  def base_rate_and_supply_add_on_amount
    nrs_amount = if rfa_year == 2015
                   ProspectivePaymentSystem::NrsConversionFactor2015.nrs_amount(hipps_code.last, 'urban')
                 else
                   nrs_amt(rfa_year, hipps_code)
                 end
    base_amount = base_rate
    cbsa = core_state_area(rfa_year)
    if cbsa.cbsa_code.starts_with?("99")  or cbsa.rural_area?   #99 = Rural codes
      if rfa_year == 2015
        nrs_amount = ProspectivePaymentSystem::NrsConversionFactor2015.nrs_amount(hipps_code.last, 'rural')
      else
        nrs_amount += (nrs_amount * rural_percentage(rfa_year))
      end
      rural_base_amount = base_amount + (base_amount * rural_percentage(rfa_year))
      [rural_base_amount, nrs_amount]
    else
      [base_amount, nrs_amount]
    end
  end

  def hhrg_weighted_labor_part_and_non_labor_part(base_amount)
    non_labor_percent = 1 - labor_percent
    hhrg_weighted = (base_amount * hhrg_weight(hipps_code))
    labor_part = (hhrg_weighted * labor_percent)
    non_labor_part =  (hhrg_weighted * non_labor_percent)
    [labor_part, non_labor_part]
  end

  def hhrg_weight(hipps_code)
    hipps =  ProspectivePaymentSystem::HippsCode.find_by_code(hipps_code)
    hipps.hhrg_weights.find_by_calender_year(rfa_year).weight
  end

  def medicare_bill_amount(final_claim_flag)
    if final_claim_flag == true
      is_lupa_bill? ? "ProspectivePaymentSystem::LupaBillAmount#{rfa_year}".constantize.new(disciplines_codes, county_name, state, episode_sequence_num).lupa_amount  : rap_and_final_claim_bill_amount
    else
      rap_and_final_claim_bill_amount
    end
  end

  def is_lupa_bill?
    return false unless disciplines_codes
    disciplines_codes.size <= 4
  end
end
