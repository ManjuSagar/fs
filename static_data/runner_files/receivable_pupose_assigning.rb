receivables = Receivable.where(["purpose is null and source_type = 'TreatmentVisit'"])
receivables.each do|receivable|
  if receivable.source.is_a? TreatmentVisit
    receivable.update_column(:purpose, "#{receivable.source}")
  end
end