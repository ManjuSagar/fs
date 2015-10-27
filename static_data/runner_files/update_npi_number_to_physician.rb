PhysicianDetail.all.each do |phy|
  physician = Physician.find_by_id(phy.physician_id)
  physician.update_column(:npi_number, phy.npi_number) if physician
end