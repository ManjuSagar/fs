Org.current = Org.find_by_org_name('Noyan Home Health Care, Inc.')
invs = Invoice.org_scope.where(["invoice_status not in (?)", ['D', "S", "A"]])
patient_reference_numbers = ['39', '26', '53', '28', '5', '47', '30']
User.current = User.find_by_email("alneb88@yahoo.com")

invs.each do |invoice|
  if (['121614', '120214','121414', '120914', '110414', "111614", "102014", "101614", "102814", "110214", "101114", "090614"].include? (invoice.statement_covers_period_through) and
      patient_reference_numbers.include?(invoice.patient_reference) and invoice.paid?)
    ActiveRecord::Base.transaction do
      invoice.system_driven_event = true
      invoice.undo! if invoice.may_undo?
      invoice.system_driven_event = false
    end
  end
end

