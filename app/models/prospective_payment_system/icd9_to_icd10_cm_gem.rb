class ProspectivePaymentSystem::Icd9ToIcd10CmGem < ActiveRecord::Base

  def get_icd10_codes(icd9)
    result = []
    stage1_icd10_codes = stage1 icd9
    stage2_icd9_codes = stage2(stage1_icd10_codes, icd9)
    final_icds = stage3(stage2_icd9_codes, stage1_icd10_codes)
    return result if final_icds.count == 0

      if final_icds.count == 1 and final_icds.first.no_map == '1'
        return  result << {icdcode: final_icds.first.icd10_code}
      end

    final_icds.each_with_index do |icds, i|
      icds = icds.group_by{|x| x.scenario}
      list = icds.sort_by{|x, v| x}
      list.each_with_index do |x, index|
        icd_based_on_choice_list = []
        choice_list = x.last.group_by{|x| x.choice_list}
        records_based_on_choice_list = []
        choice_list.each{|k, v|
          if k >= '2'
            records_based_on_choice_list << {w: v.map{|x| [x.icd9_code, x.icd10_code]}}
          elsif k == '1'
            records_based_on_choice_list << {r: v.map{|x| [x.icd9_code, x.icd10_code]}}
          elsif k == '0'
            records_based_on_choice_list << {r: v.map{|x| [x.icd9_code, x.icd10_code]}}
          end
        }

        records_based_on_choice_list.each{|d| icd_based_on_choice_list << d[:r]}
        records_based_on_choice_list.each{|d| icd_based_on_choice_list << d[:w]}

        uniq_icd_based_on_choice_list = []
        icd_based_on_choice_list.each do |res|
          uniq_icd_based_on_choice_list << res.uniq if res
         end

        map = (i == 0)? array_permutations(uniq_icd_based_on_choice_list.compact, 'forward') :
                        array_permutations(uniq_icd_based_on_choice_list.compact, 'backward')

        map.flatten.each{|icd|
          next unless icd[:sourcecode].include?(icd9)
          result << icd
        }
      end
    end
    (result.empty?) ? {sourcecode: icd9, targetcode: "No Matching Found." } : result.uniq
  end

  def array_permutations(array, flag)
    result = []
    choice_list1 = array[0]
    choice_list2 = array[1]
    if choice_list2.present?
      choice_list1.each do |ch1|
      icd9_code = ch1[0]
      icd10_code = ch1[1]
        choice_list2.each do |ch2|
          icd9_code_ch2 = ch2[0]
          icd10_code_ch2 = ch2[1]
          result << icd_codes_with_description(icd9_code, icd9_code_ch2, icd10_code, icd10_code_ch2, flag)
        end
      end
    else
      choice_list1.each do |ch1|
        icd9_code = ch1[0]
        icd10_code = ch1[1]
        next if (icd10_code=='NoD.x')
        result << icd_code_with_description_without_cluster(icd9_code, icd10_code, flag)
     end
    end
     return result
  end

  def icd_codes_with_description(icd9_code, icd9_code_ch2, icd10_code, icd10_code_ch2, flag)
    result = []
    if flag == 'forward'
      if(icd9_code == icd9_code_ch2)
        cluster1 = ProspectivePaymentSystem::Icd10DiagnosticCode.where(icd_code: icd10_code).first.icd_code_with_description
        cluster2 = ProspectivePaymentSystem::Icd10DiagnosticCode.where(icd_code: icd10_code_ch2).first.icd_code_with_description
        result << {sourcecode: icd9_code, targetcode: "<b>Cluster</b><br/>#{cluster1}<br> with </br> #{cluster2} </br></br>"}
      end
    else
        if(icd10_code == icd10_code_ch2)
        targetcode = ProspectivePaymentSystem::Icd10DiagnosticCode.where(icd_code: icd10_code).first.icd_code_with_description
        result << {sourcecode: "<b>Cluster</b><br/>#{icd9_code} <br> with </br> #{icd9_code_ch2}</br></br>", targetcode: targetcode}
      end
    end
    result
  end

  def icd_code_with_description_without_cluster(icd9_code, icd10_code, flag)
    target = ProspectivePaymentSystem::Icd10DiagnosticCode.where(icd_code: icd10_code).first.icd_code_with_description
    {sourcecode: icd9_code, targetcode: target}
  end


  def stage1 icd9
    icd10_codes = []
    icd10_codes += ProspectivePaymentSystem::Icd9ToIcd10CmGem.where(icd9_code: icd9).collect{|x| x.icd10_code}          #forward mapping
    icd10_codes += ProspectivePaymentSystem::Icd10cmToIcd9Gem.where(icd9_code: icd9).collect{|x| x.icd10_code}    #backward mapping
    icd10_codes.uniq
  end

  def stage2(icd10, icd9)
    stage_2_icd9_codes = []
    stage_2_icd9_codes += ProspectivePaymentSystem::Icd10cmToIcd9Gem.where("icd10_code in (?)", icd10).collect{|x| x.icd9_code } #backward mapping
    stage_2_icd9_codes += ProspectivePaymentSystem::Icd9ToIcd10CmGem.where("icd10_code in (?)", icd10).collect{|x| x.icd9_code} #forward mapping
    stage_2_icd9_codes.uniq
  end

  def stage3(icd9, stage1_icd)
    icds9 = ProspectivePaymentSystem::Icd9ToIcd10CmGem.where("icd9_code in (?)", icd9)
    icds10 = ProspectivePaymentSystem::Icd10cmToIcd9Gem.where("icd9_code in (?) and icd10_code in (?)", icd9, stage1_icd)
    [icds9, icds10]
  end

end