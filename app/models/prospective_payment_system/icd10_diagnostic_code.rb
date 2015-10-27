class ProspectivePaymentSystem::Icd10DiagnosticCode < ActiveRecord::Base
  self.table_name = 'icd_10_diagnostic_codes'

  def to_s
    "(#{icd_code}) #{long_description}"
  end

  def formatted_icd_code
    if icd_code[0] == "E"
      formatted_code = (icd_code.include?(".")) ? "#{icd_code[0..2]}#{icd_code[3..7]}" : "#{icd_code[0..3]}.#{icd_code[4..7]}"
    else
      formatted_code = (icd_code.include?(".")) ? "#{icd_code[0..2]}#{icd_code[3..7]}" : "#{icd_code[0..2]}.#{icd_code[3..7]}"
      formatted_code = " #{formatted_code}" if icd_code[0] != 'E' #add a space in the beginning
    end
    formatted_code.ljust(7)
  end

  def formatted_icd_code_for_xml
    if icd_code[0] == "E"
      formatted_code = (icd_code.include?(".")) ? "#{icd_code[0..2]}#{icd_code[3..7]}" : "#{icd_code[0..3]}.#{icd_code[4..7]}"
    else
      formatted_code = (icd_code.include?(".")) ? "#{icd_code[0..2]}#{icd_code[3..7]}" : "#{icd_code[0..2]}.#{icd_code[3..7]}"
      formatted_code = "^#{formatted_code}" #add a space in the beginning
    end
    formatted_code.ljust(7, '^')
  end

  def icd_code_with_description
    "<b>#{icd_code}</b> - #{long_description}"
  end

end
