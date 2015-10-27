require 'csv'
ProspectivePaymentSystem::Icd9ToIcd10CmGem.delete_all
icd10_diagnostic_codes=  CSV.readlines("#{Rails::root}/icd_files/2015_9cmto10.txt", :headers=>false, skip_blanks: true, :col_sep => " ")
icd10_diagnostic_codes.each do |row|
  icd_code = row[0].gsub(/'/, "")
  icd_code = icd_code.strip

  icd9 = if icd_code.length > 3
           if icd_code[0] == 'E'
             if icd_code.length > 4
               "#{icd_code[0..3]}.#{icd_code[4..6]}"
             else
               icd_code
             end
           else
             "#{icd_code[0..2]}.#{icd_code[3..6]}"
           end
         else
           icd_code
         end

  icd_10 = row[1].gsub(/'/, "")
  icd_10 = icd_10.strip

  icd10 = if icd_10.length > 3
            "#{icd_10[0..2]}.#{icd_10[3..6]}"
          else
            icd_10
          end

  flags = row[2].split('')
  approximation =  flags[0]
  no_map = flags[1]
  combination = flags[2]
  scenario = flags[3]
  choice_list = flags[4]

  ProspectivePaymentSystem::Icd9ToIcd10CmGem.create!(icd9_code: icd9, icd10_code: icd10, approximation: approximation,
                                                        no_map: no_map, combination: combination, scenario: scenario,
                                                        choice_list: choice_list)

end

