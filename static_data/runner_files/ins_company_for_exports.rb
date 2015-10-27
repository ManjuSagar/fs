OasisExport.all.each do |x|
  doc = x.oasis_document
  next if doc.blank?
  treatment =  doc.treatment
  next if treatment.blank?
  ins = treatment.insurance_company
  ins_id = ins.present? ? ins.id : nil
  x.update_column(:insurance_company_id, ins_id)

end