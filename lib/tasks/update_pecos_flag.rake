desc "Update PECOS flag to existing physician, EX: rake update_pecos_flag"
task :update_pecos_flag => [:environment] do
  Physician.all.each do |phy|
    response = NpiRegistryPhysician.where({npi_number: phy.npi_number}).first
    next if response.nil?
    pecos_flag = response["pecos_verification"]
    phy.update_column(:pecos_verification, pecos_flag)
  end
end