User.current = User.find_by_email "info@mymetrohc.com"
episodes = TreatmentEpisode.org_scope

episodes.each{|episode|
  hipps_code, bill_amount = episode.score_hipps_code_and_bill_amount(true)
  episode.invoices.where({invoice_type: '329'}).each{|i|
    receivable = i.receivables.where("purpose = 'Home Health Services'").first
    if receivable and receivable.hcpcs_code != hipps_code
      receivable.update_attribute(:hcpcs_code, hipps_code)
      episode.update_attribute(:final_hipps_code, hipps_code)
    end
  }
}