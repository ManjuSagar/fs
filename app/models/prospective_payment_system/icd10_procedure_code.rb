class ProspectivePaymentSystem::Icd10ProcedureCode < ActiveRecord::Base
  set_table_name :icd_10_procedure_codes

  def to_s
    "(#{icd_code}) #{long_description}"
  end

  def formatted_icd_code
    "  #{icd_code[0..1]}#{icd_code[2..7]}".ljust(7)
  end

  def formatted_icd_code_for_xml
    "^^#{icd_code[0..1]}#{icd_code[2..7]}".ljust(7, '^')
  end

end