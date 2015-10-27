HealthAgency.all.each do |org|
  arr =[]
  TreatmentRequest.where("health_agency_id = (?)",org ).each {|d| arr<< d.referred_physician_id}
  arr.uniq.each do |data|
    physician = Physician.find_by_id(data)
    if physician
      res = OrgPhysician.where("org_id = (?) and physician_id = (?)",org.id,data)
      if res.empty?
        phy = OrgPhysician.new
        phy.skip_callbacks = true
        phy.org = org
        phy.physician = physician
        phy.save!(validate: false)
      end
    end
  end
end


