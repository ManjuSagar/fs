require 'csv'
icd10_diagnostic_codes=  CSV.readlines("#{Rails::root}/icd_files/icd9toicd10pcsgem.csv", :headers=>true, skip_blanks: true)
icd10_diagnostic_codes.each do |row|
  icd_code = row[0].gsub(/'/, "")
  icd_code = icd_code.strip

icd9 = if icd_code.length > 2
         "#{icd_code[0..1]}.#{icd_code[2..6]}"
       else
         icd_code
       end

  icd_10 = row[1].gsub(/'/, "")
  icd_10 = icd_10.strip

  ProspectivePaymentSystem::Icd9ToIcd10PcsGem.create!(icd9_code: icd9, icd10_code: icd_10, approximation: row[3].strip,
                                                     no_map: row[4].strip, combination: row[5].strip, scenario: row[6],
                                                     choice_list: row[7])

  puts "icd_code #{icd9} created"
end

