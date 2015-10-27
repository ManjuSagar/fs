Invoice.where("invoice_status ='S' and sent_date is not null").each do |inv|
 invoice_sent_date = inv.sent_date.strftime("%m/%d/%Y")
 inv.update_attributes({:invoice_sent_date => invoice_sent_date, :status_date => inv.sent_date})
end


