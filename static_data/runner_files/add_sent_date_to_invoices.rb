invoices = Invoice.where(["invoice_type='322' and invoice_status in (?) and sent_date IS NULL", ['S','P','R','D']])
  invoices.each do |invoice|
    episode = invoice.treatment_episode
    next if episode.blank?
    sent_date = episode.start_date
    invoice.update_column(:sent_date, sent_date)
  end