#User.current = User.find_by_email("fnpublic+help2@gmail.com")
User.current = User.find_by_email("fnpublic+help@gmail.com")
list = []
Patient.org_scope.each do |patient|
  next unless (patient.first_name.start_with? " " or patient.first_name.end_with? " " or
      patient.first_name.start_with? " " or patient.first_name.end_with? " ")
  list << [patient.patient_reference, patient.id, patient.first_name, patient.last_name]
end

debug_log "LIST...................#{list}"
debug_log "LIST...................#{list.size}"
