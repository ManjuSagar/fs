principal_icd_codes = ["principal_icd1", "principal_icd2", "principal_icd3", "principal_icd4", "principal_icd5", "principal_icd6"]
pertinent_icd_codes = ["pertinent_icd1", "pertinent_icd2", "pertinent_icd3", "pertinent_icd4", "pertinent_icd5", "pertinent_icd6"]

PlanOfCare.all.each do |p|
  principal_diag_codes_list = []
  pertinent_diag_codes_list = []

  principal_icd_codes.each_with_index do |icd, index|
    icd_code = p.send(icd)
    icd_oe = p.send(icd.split("_").first + "_oe#{index+1}")
    icd_date = p.send(icd.split("_").first + "_date#{index+1}")
    name = icd.split("_").first
    principal_diag_codes_list << {name: name, icd_code: icd_code, oe: icd_oe, icd_date:icd_date} unless [icd_code, icd_oe, icd_date].all?{|x| x.blank?}
  end

  pertinent_icd_codes.each_with_index do |icd, index|
    icd_code = p.send(icd)
    icd_oe = p.send(icd.split("_").first + "_oe#{index+1}")
    icd_date = p.send(icd.split("_").first + "_date#{index+1}")
    if principal_diag_codes_list.size < 6
      principal_diag_codes_list  << {name: "principal", icd_code: icd_code, oe: icd_oe, icd_date:icd_date} unless [icd_code, icd_oe, icd_date].all?{|x| x.blank?}
    else
      pertinent_diag_codes_list << {name: "pertinent", icd_code: icd_code, oe: icd_oe, icd_date:icd_date} unless [icd_code, icd_oe, icd_date].all?{|x| x.blank?}
    end
  end

  arr = principal_diag_codes_list + pertinent_diag_codes_list
  arr += (12 - arr.size).times.to_a
  arr.each_with_index do |rec, i|
    r = i % 6
    if(rec.is_a? Hash)
      icd_code = rec[:icd_code]
      icd_date = rec[:icd_date]
      icd_oe = rec[:oe]
      name = rec[:name]
      hsh = {:"#{name}_icd#{r+1}" => icd_code, :"#{name}_date#{r+1}" => icd_date, :"#{name}_oe#{r+1}" => icd_oe}
      p.update_attributes(hsh)
    else
      name = (i > 5)? "pertinent" : "principal"
      hsh = {:"#{name}_icd#{r+1}" => nil, :"#{name}_date#{r+1}" => nil, :"#{name}_oe#{r+1}" => nil}
      p.update_attributes(hsh)
    end
  end
end


