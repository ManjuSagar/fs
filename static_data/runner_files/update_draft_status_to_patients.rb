patients = Patient.where("draft_status = true")
patients.each{|patient|
  is_real_patient = Audit.where(auditable_id: patient.id, auditable_type: 'User').size > 1
  patient.update_attribute(:draft_status, false) if is_real_patient
}
