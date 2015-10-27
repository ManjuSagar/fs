ProspectivePaymentSystem::MedicareCoreStatArea.all.each do |x|
  state_name = x.state_name.strip if x.state_name.present?
  county_name = x.county_name.strip if x.county_name.present?
  x.update_attributes({:state_name => state_name, :county_name => county_name})
end