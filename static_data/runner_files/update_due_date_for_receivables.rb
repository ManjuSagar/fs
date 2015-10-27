
receivables = Receivable.where("purpose <> 'Home Health Services' and
                               payer_id in (select id from insurance_companies where company_code <> 'MEDICARE')")
receivables.each { |r|
  receivable_date = r.receivable_date
  due_days = r.payer.claim_submission_due_days
  due_date = due_days.present? ? receivable_date + due_days : receivable_date
  r.update_column(:due_date, due_date)
}