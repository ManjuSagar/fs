class ServiceUnitChangeForExistingReceivables < ActiveRecord::Migration
  def change
    Receivable.all.each{|receivable|
      if receivable.purpose == "Home Health Services"
        receivable.update_column(:service_units, 0)
        next
      end
      if receivable.source.is_a? TreatmentVisit
        visit = receivable.source
        res = ((visit.visit_end_time - visit.visit_start_time)/60)/15
        service_units = (res == 0)? 1 : res
        receivable.update_column(:service_units, service_units)
      end
    }
  end
end
