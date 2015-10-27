receivables = PrivateReceivable.where("payer_id in (select id from insurance_companies where company_code <> 'MEDICARE')")
receivables.each{ |rec|
  if rec.unit == 'V'
    rate = rec.receivable_amount
  elsif rec.unit == 'H'
    hrs = rec.source.time_taken_for_visit_in_hours
    rate = rec.receivable_amount/hrs
  end
  rec.update_attributes!({visit_type_rate: rate})
}