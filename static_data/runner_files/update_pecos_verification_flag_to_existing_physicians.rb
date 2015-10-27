Physician.all.each do |phy|
  params = {npi_number: phy.npi_number}
  res = NpiRegistryPhysician.where(npi_number: params[:npi_number]).first
  phy.update_column(:pecos_verification, res["pecos_verification"]) if res
end