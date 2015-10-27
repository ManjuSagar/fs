dest_file_path = "#{Rails.root}/config/HomeHealthGrouper2015.properties"
master_base_path = ProspectivePaymentSystem::MedicareBillCalculator.hhcmg_software_path(dest_file_path)
unless File.exist?(dest_file_path)
  sample_file_path = "#{Rails.root}/config/HomeHealthGrouperExample.properties"
  lines = File.readlines(sample_file_path)
  lines.each_with_index do |line, index|
    lines[index].gsub! "${master.base.path}", "#{master_base_path}/home_health_case_mix_grouper" if line.include?("${master.base.path}")
  end
  File.open(dest_file_path, 'w'){|f| f.puts lines.join }

  #File name Changes
  folder_path = "#{master_base_path}/home_health_case_mix_grouper/Grouper_v2308_2.tables"
  old_file_names = ["diagnosiscodes.txt", "diagnosisetiologypairs.txt", "nrsdiagnosiscodes.txt"]
  new_file_names = ["DiagnosisCodes.txt", "DiagnosisEtiologyPairs.txt", "NRSDiagnosisCodes.txt"]
  old_file_names.each_with_index do |old_file_name, index|
    File.rename("#{folder_path}/#{old_file_name}", "#{folder_path}/#{new_file_names[index]}") if File.exist?("#{folder_path}/#{old_file_name}")
  end
end
