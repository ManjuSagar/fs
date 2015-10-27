class ProspectivePaymentSystem::LupaBillAmount
  include ProspectivePaymentSystem::BillingRelatedMethods
  attr_reader :discipline_codes, :county_name, :state, :add_on_required, :episode_sequence_num

  def initialize(discipline_codes, county_name, state, episode_sequence_num)
    @discipline_codes = discipline_codes
    @county_name = county_name
    @state = state
    @episode_sequence_num = episode_sequence_num
  end

  def discipline_bill_amount(year, discipline_code)
    base_rate = lupa_discipline_rates(year).find_by_discipline_code(discipline_code).base_amt
    base_rate = base_rate + (base_rate * rural_percentage(year)) if core_state_area(year).rural_area?    #Rural codes: cbsa code start with 99
    wage_index_adjusted_amount({year: year, amount: base_rate})
  end

  def add_on_amount(year, lupa_add_on_amount)
    lupa_add_on_amount += lupa_add_on_amount * rural_percentage(year) if core_state_area(year).rural_area?    #Rural codes: cbsa code start with 99
    wage_index_adjusted_amount({year: year, amount: lupa_add_on_amount})
  end

end
