class ProspectivePaymentSystem::Icd9ToIcd10PcsGem < ActiveRecord::Base

  def get_icd10_codes(icd9)
    result = []
    icds = Icd9ToIcd10PcsGem.where(icd9_code: icd9)
    return result if icds.count == 0
    if icds.count == 1 and icds.first.no_map == '1'
      result << {icdcode: icds.first.icd10_code}
    end
    final_map = []
    icds = icds.group_by{|x| x.scenario}
    list = icds.sort_by{|x, v| x}
    list.each_with_index do |x, index|
      res = []
      choice_list = x.last.group_by{|x| x.choice_list}
      s = []
      choice_list.each{|k, v|
        if k >= '2'
          s << {w: v.map(&:icd10_code)}
        elsif k == '1'
          s << {r: v.map(&:icd10_code)}
        elsif k == '0'
          s << {r: v.map(&:icd10_code)}
        end
      }
      s.each{|d| res << d[:r]}
      s.each{|d| res << d[:w]}
      map = array_permutations res.compact

      map.flatten.each{|icd|
        result << {icdcode: icd}
      }
    end
    result
  end

  def array_permutations index = 0, array
    result = []
    if index == array.size
      result << ""
      return result
    end
    array[index].each do |element|
      icd_code = ProspectivePaymentSystem::Icd10ProcedureCode.where(icd_code: element.strip).first.icd_code_with_description
      array_permutations(index + 1, array).each do |x|
        result << (index + 1 == array.size ? "#{icd_code}" : "<b>Cluster</b><br/>#{icd_code}<br> with </br> #{x} </br></br>".strip)
      end
    end
    return result
  end

end