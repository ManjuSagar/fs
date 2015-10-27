Document.all.each do |document|
  treatment = document.treatment
  if treatment
    patient = treatment.patient
    if patient
      patient_name = patient.full_name
      mr = patient.patient_reference
      next if document.patient_name
      document.patient_name = patient_name
      document.mr = mr
      document.save(:validate => false)
    end
  end
end