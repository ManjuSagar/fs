module ProspectivePaymentSystem::BillingRelatedMethods

  def add_on_amount_required?
    return true unless episode_sequence_num
    episode_sequence_num == 1
  end

  def lupa_discipline_rates(year)
    ProspectivePaymentSystem::MedicareLupaRate.where(:calender_year => year)
  end

  def core_state_area(year)
  	ProspectivePaymentSystem::MedicareCoreStatArea.where({state_name: state, county_name: county_name, calender_year: year}).first
  end

  def standard_rate(year)
    ProspectivePaymentSystem::MedicareStandardRate.find_by_calender_year(year)
  end

  def labor_percentage(year)
    ProspectivePaymentSystem::MedicareLaborPercentage.find_by_calender_year(year).labor_percentage
  end

  def wage_index(year)    
    core_state_area(year).wage_indices.find_by_calender_year(year).wage_index
  end

  def rural_percentage(year)
    standard_rate(year).rural_percentage.to_f/100.00
  end

  def nrs_amt(year, hipps_code)
    nrs = ProspectivePaymentSystem::MedicareNrsRate.find_by_calender_year_and_nrs_score(year, hipps_code.last)
    nrs ? nrs.nrs_amt : 0
  end

  def wage_index_adjusted_amount(params)
    labor_percent = labor_percentage(params[:year])
    non_labor_percent = 1 - labor_percent

    labor_part = (params[:amount] * labor_percent)
    non_labor_part =  (params[:amount] * non_labor_percent)

    (geo_weight_adjustment_for_labor({labor_part: labor_part, year: params[:year]}) + non_labor_part)
  end

  def geo_weight_adjustment_for_labor(params)
    (params[:labor_part] * wage_index(params[:year]))
  end

end
