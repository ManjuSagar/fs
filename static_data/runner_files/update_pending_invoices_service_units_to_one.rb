Invoice.where(invoice_status: ['D', 'A', 'S', 'P', 'R', 'I', 'N']).each do |inv|
  receivable = inv.receivables.where(purpose: 'Home Health Services', service_units: 0, revenue_code: '023').first
  receivable.update_attributes(service_units: 1, revenue_code: '0023')
end

User.current = User.find_by_email("fnpublic+noyan@gmail.com")
i = Invoice.org_scope.where(invoice_number: 1138).update_all(invoice_status: 'N', transmission_status: nil)