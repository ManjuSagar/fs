mr_map = {"1" => "355", "2" => "356", "3" => "354", "4" => "357", "5" => "358", "6" => "362", "7" => "360",
          "8" => "361", "9" => "359"}

agency = HealthAgency.find(493)
patient_details = agency.patient_details
patient_details.each do |patient_detail|
  mr = patient_detail.patient_reference
  new_number = mr_map[mr]
  if new_number.present?
    patient_detail.patient_reference = new_number
    patient_detail.save!
    patient = patient_detail.patient
    patient.treatments.each do |treatment|
      treatment.documents.each do |doc|
        doc.mr = new_number if doc.respond_to?("mr")
        doc.m0020_pat_id = new_number if doc.respond_to?("m0020_pat_id")
        doc.save(:validation => false)
      end
    end
  end
end