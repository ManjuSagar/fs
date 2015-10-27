class ProspectivePaymentSystem::LupaBillAmount2014 < ProspectivePaymentSystem::LupaBillAmount
  ADD_ON_AMOUNT_PERCENT = {:SN => 84.51, :ST => 62.66, :PT => 67}

  def lupa_add_on_amount(discipline_code)
    base_rate = lupa_discipline_rates(2014).find_by_discipline_code(discipline_code).base_amt
    (ADD_ON_AMOUNT_PERCENT[discipline_code.to_sym]/100) * base_rate
  end

  def lupa_amount
    rfa_year = 2014
    total_amount = 0.0
    discipline_codes.each {|discipline_code|
      total_amount += discipline_bill_amount(rfa_year, discipline_code)
    }
    discipline_code = add_on_amount_required_discipline_code
    total_amount += add_on_amount(rfa_year, lupa_add_on_amount(discipline_code)) if (add_on_amount_required? and discipline_code)
    total_amount.round(2)
  end

  def add_on_amount_required_discipline_code
    discipline_codes.detect{|d| ["PT","ST","SN"].include? (d)}
  end
end