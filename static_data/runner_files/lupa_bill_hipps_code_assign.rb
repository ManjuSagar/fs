invoices = Invoice.where(["invoice_type = ?", '327'])
invoices.each do |invoice|
  receivable = invoice.receivables.find_by_purpose("Home Health Services")
  next unless invoice.treatment_episode
  doc ||= invoice.treatment_episode.valid_oasis_doc
  next unless doc
  hipps_code = doc.subm_hipps_code
  receivable.update_column(:hcpcs_code, hipps_code)
  receivable.update_column(:revenue_code, '023')
end