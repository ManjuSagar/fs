# Date:26/11/2014 .This should be used only one time.
# Billed claims report doesn't yet work for existing records because there is no sent date stamping till now.
# Updating sent date with invoice date, second time you run may override the sent date.
class UpdateInvoiceSentDateWithInvoiceDate
  Invoice.all.each do |invoice|
    invoice.update_column(:sent_date, invoice.invoice_date) if invoice.sent_date.nil?
  end
end