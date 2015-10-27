class UpdateInvoiceAndReceivableAmount < ActiveRecord::Migration
 def change
   episodes = TreatmentEpisode.where(["medicare_bill_status in (?)", ['R', 'F', 'L'] ])
   episodes.each do |e|
     invoice = e.invoices.where(invoice_type: "322").first
     visit = e.treatment_visits.where(:visit_status => 'C').order("visit_start_time").first if invoice
     if visit
       visit_date = visit.visit_start_date
       invoice.update_column(:invoice_date, visit_date)
       invoice.receivables.first.update_column(:receivable_date, visit_date)
     end
   end
 end
end
