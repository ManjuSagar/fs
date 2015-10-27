OrgPhysician.all.each do |org_phy|
  phy = Physician.where(npi_number: org_phy.physician.npi_number).first
  attributes = phy.attributes
  org_phy.suffix = attributes["suffix"]
  org_phy.suite_number =  attributes["suite_number"]
  org_phy.street_address = attributes["street_address"]
  org_phy.city = attributes["city"]
  org_phy.state = attributes["state"]
  org_phy.zip_code = attributes["zip_code"]
  org_phy.phone_number = attributes["phone_number"]
  org_phy.save!(validate: false)
end