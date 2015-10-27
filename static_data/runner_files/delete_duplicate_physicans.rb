physician = User.group(:npi_number).having('COUNT("npi_number") > 1').count(:npi_number)
orgs = []
physician.each do |k,v|
  next if v == 1
  physician_npi = User.where(npi_number: k).reverse
  len = physician_npi.length
  physician_npi.each do |p|
    phy_id = p.id
    treatment_req = TreatmentRequest.where("referred_physician_id =?", phy_id)
     if treatment_req.empty?
       duplicated_phy = Physician.find_by_id(phy_id) if len >= 2
       orgs << {npi_number: duplicated_phy.npi_number, orgs: duplicated_phy.orgs.collect{|x| x.id}} if duplicated_phy.present?
       duplicated_phy.destroy if duplicated_phy.present?
       len -= 1
     end
  end
end

orgs = orgs.uniq
orgs.each do |record|
  user = User.where(npi_number: record[:npi_number]).first
  actual_agencies = record[:orgs].reject{|x| x == 23}
  actual_agencies.uniq.each do |org|
    org_record = OrgPhysician.where(physician_id: user.id, org_id: org).first
    next if org_record.present?
    org_phy = OrgPhysician.new
    org_phy.skip_callbacks = true
    org_phy.org_id = org
    org_phy.physician = user
    org_phy.save!(validate: false)
  end
end
