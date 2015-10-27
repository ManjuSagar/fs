User.current = User.find_by_email "fnpublic+nohohc@gmail.com"

patients = Patient.org_scope
problem_patients = []
patients.each do |patient|
  if (patient.phone_number and (patient.phone_number.size > 0) and /\(\d{3}\)\s\d{3}-\d{4}/.match(patient.phone_number).nil?)
    problem_patients << {"patient" => patient, "name" => patient.full_name, "field" => "phone_number", "value" => patient.phone_number}
  end
  if (patient.phone_number_2 and (patient.phone_number_2.size > 0) and /\(\d{3}\)\s\d{3}-\d{4}/.match(patient.phone_number_2).nil?)
    problem_patients << {"patient" => patient, "name" => patient.full_name, "field" => "phone_number_2", "value" => patient.phone_number_2}
  end
end
puts problem_patients

problem_patients.each do |p|
  number = p["value"]
  patient = p["patient"]
  new_number = (patient.id == 3846)? "(#{number[0..2]}) #{number[4..6]}-#{number[8..11]}" : "(#{number[0..2]}) #{number[3..5]}-#{number[6..9]}"
  patient.update_column(p["field"], new_number)
end

