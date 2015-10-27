Payable.all.each do |p|
  p.update_attributes(unit: 'V', rate: p.payable_amount, no_of_units: 1) if p.unit.blank?
end