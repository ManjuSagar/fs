# == Schema Information
#
# Table name: icd_9_procedure_codes
#
#  icd_code          :string(7)        not null, primary key
#  short_description :string(100)
#  long_description  :string(255)
#

class ProspectivePaymentSystem::Icd9ProcedureCode < ActiveRecord::Base
  set_table_name :icd_9_procedure_codes

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
