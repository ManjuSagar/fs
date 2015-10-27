User.current = User.find_by_email("fnpublic+committed@gmail.com")

['75', '79', '78'].each{|mr_number|
  patient = PatientDetail.where(patient_reference: "#{mr_number}", org_id: Org.current.id).first.patient
  treatment = patient.treatments.first
  document = treatment.documents.where(document_type: 'OasisEvaluation').first
  document.fs_sign_required = true
  document.field_signature_not_required = false
  document.save
}


