class ChangeFormatOfIcdCodesInExistingOasisDocAndPlanOfCare < ActiveRecord::Migration
  def change
    oasis_docs = Document.where(:document_type => ["OasisEvaluation", "OasisRecertification", "OasisResumptionOfCare", "OasisOtherFollowup",
                                                   "OasisTransferredPatientWithDischarge", "OasisTransferredPatientWithoutDischarge", "OasisDeathAtHome", "OasisDischargeFromAgency"])
    oasis_docs.each do |oasis_doc|
      icd_codes = ["m1010_14_day_inp1_icd", "m1010_14_day_inp2_icd", "m1010_14_day_inp3_icd", "m1010_14_day_inp4_icd", "m1010_14_day_inp5_icd",
                   "m1010_14_day_inp6_icd", "m1012_inp_prcdr1_icd", "m1012_inp_prcdr2_icd", "m1012_inp_prcdr3_icd", "m1012_inp_prcdr4_icd", "m1020_primary_diag_icd",
                   "m1022_oth_diag1_icd", "m1022_oth_diag2_icd", "m1022_oth_diag3_icd", "m1022_oth_diag4_icd", "m1022_oth_diag5_icd",
                   "m1024_pmt_diag_icd_a3", "m1024_pmt_diag_icd_a4", "m1024_pmt_diag_icd_b3", "m1024_pmt_diag_icd_b4", "m1024_pmt_diag_icd_c3", "m1024_pmt_diag_icd_c4",
                   "m1024_pmt_diag_icd_d3", "m1024_pmt_diag_icd_d4", "m1024_pmt_diag_icd_e3", "m1024_pmt_diag_icd_e4", "m1024_pmt_diag_icd_f3",
                   "m1024_pmt_diag_icd_f4"]

      icd_codes.each do |icd_code|
        field_value = oasis_doc.send(icd_code)
        oasis_doc.send(icd_code+"=", (field_value ? formatted_value(field_value) : nil))
      end
      oasis_doc.skip_callbacks = true
      oasis_doc.save(:validate => false)
    end

    PlanOfCare.all.each do |poc_doc|
      poc_icd_codes = ["principal_icd1", "principal_icd2", "principal_icd3", "principal_icd4", "surgical_icd1",
                       "surgical_icd2", "surgical_icd3", "surgical_icd4", "pertinent_icd1", "pertinent_icd2",
                       "pertinent_icd3", "pertinent_icd4"]

      poc_icd_codes.each do |poc_icd_code|
        code_value = poc_doc.send(poc_icd_code)
        poc_doc.send(poc_icd_code+"=", (code_value ? formatted_value(code_value) : nil))
      end
	  poc_doc.skip_callbacks = true
      poc_doc.save(:validate => false, :skip_callbacks => true)

    end
  end


  def formatted_value(icd_code)
    formatted_value = ""
    if icd_code.length >= 5 and icd_code.start_with? 'E'
      formatted_value = icd_code.insert(4, '.')
    elsif icd_code.length >=4 and icd_code.start_with? 'V'
      formatted_value = icd_code.insert(3, '.')
    elsif icd_code.length >=4 and !(icd_code.start_with? 'E' or icd_code.starts_with? 'V')
      formatted_value = icd_code.insert(3, '.')
    else
      formatted_value = icd_code
    end
    formatted_value
  end

end
