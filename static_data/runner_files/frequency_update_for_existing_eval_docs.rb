eval_docs = ["MSWEvaluation", "OTEvaluation", "PTEvaluation", "SNEvaluation","STEvaluation"]

treatment_visits = TreatmentVisit.where(["frequency_string is not null"])
treatment_visits.each{|visit|
    visit_docs = visit.documents
    visit_docs.each {|doc|
      if eval_docs.include? (doc.document_type)
        doc.frequency = visit.frequency_string
        doc.save(:validate => false)
      end
    }
}