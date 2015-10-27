require 'csv'
icd10_diagnostic_codes=  CSV.readlines("#{Rails::root}/icd_files/icd10_pcs.csv", :headers=>true, skip_blanks: true)
icd10_diagnostic_codes.each do |row|
  icd_code = row[0].gsub(/'/, "").strip

  ProspectivePaymentSystem::Icd10ProcedureCode.create!(icd_code: icd_code, short_description: row[3], long_description: row[2])
  puts "icd_code #{icd_code} created"
end

