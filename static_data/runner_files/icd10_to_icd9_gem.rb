require 'csv'
ProspectivePaymentSystem::Icd10cmToIcd9Gem.delete_all
icd10_diagnostic_codes=  CSV.readlines("#{Rails::root}/icd_files/2015_10cmtoicd9.txt", :headers=>false, skip_blanks: true, :col_sep => " ")
icd10_diagnostic_codes.each do |row|
  icd_code = row[0].gsub(/'/, "")
  icd_code = icd_code.strip

  icd10 = if icd_code.length > 3
           "#{icd_code[0..2]}.#{icd_code[3..6]}"
         else
           icd_code
         end

  icd_9 = row[1].gsub(/'/, "")
  icd_9 = icd_9.strip

  icd9 = if icd_9.length > 3
           if icd_9[0] == 'E'
             if icd_9.length > 4
               "#{icd_9[0..3]}.#{icd_9[4..6]}"
             else
               icd_9
             end
           else
             "#{icd_9[0..2]}.#{icd_9[3..6]}"
           end
         else
           icd_9
         end

  flags = row[2].split('')
  approximation =  flags[0]
  no_map = flags[1]
  combination = flags[2]
  scenario = flags[3]
  choice_list = flags[4]

  ProspectivePaymentSystem::Icd10cmToIcd9Gem.create!(icd10_code: icd10, icd9_code: icd9, approximation: approximation,
                                                     no_map: no_map.strip, combination: combination, scenario: scenario,
                                                     choice_list: choice_list)

  puts "icd_code #{icd10} created"
end

