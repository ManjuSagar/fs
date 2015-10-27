require 'csv'
icd10_diagnostic_codes=  CSV.readlines("#{Rails::root}/icd_files/icd10_cm.csv", :headers=>true, skip_blanks: true)
icd10_diagnostic_codes.each do |row|
  icd_code = row[0].gsub(/'/, "")
  icd_code = icd_code.strip

  formatted_icd_code = if icd_code.length > 3
                         "#{icd_code[0..2]}.#{icd_code[3..6]}"
                       else
                         icd_code
                       end

  ProspectivePaymentSystem::Icd10DiagnosticCode.create!(icd_code: formatted_icd_code, short_description: row[3], long_description: row[2])
  puts "icd_code #{formatted_icd_code} created"
end

