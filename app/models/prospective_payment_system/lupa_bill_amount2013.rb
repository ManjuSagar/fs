class ProspectivePaymentSystem::LupaBillAmount2013 < ProspectivePaymentSystem::LupaBillAmount
  ADD_ON_AMOUNT = 95.85

  def lupa_amount
    rfa_year = 2013

    total_amount = 0.0
    discipline_codes.each {|discipline_code|
      total_amount += discipline_bill_amount(rfa_year, discipline_code)
    }
    total_amount += add_on_amount(rfa_year, ADD_ON_AMOUNT) if add_on_amount_required?
    total_amount.round(2)
  end

end