module ClaimReportRelatedMethods

  GENDER = {1 => "M", 2 => "F"}
  ICD9_FIELDS_FOR_CLAIMS = ["m1020_primary_diag_icd", "m1022_oth_diag1_icd", "m1022_oth_diag2_icd", "m1022_oth_diag3_icd",
    "m1022_oth_diag4_icd", "m1022_oth_diag5_icd", "m1012_inp_prcdr1_icd", "m1012_inp_prcdr2_icd",
    "m1012_inp_prcdr3_icd", "m1012_inp_prcdr4_icd"]

  ICD9_FIEDS_FOR_CLAIMS = ["m1020_primary_diag_icd", "m1022_oth_diag1_icd", "m1022_oth_diag2_icd", "m1022_oth_diag3_icd",
                           "m1022_oth_diag4_icd", "m1022_oth_diag5_icd", "m1012_inp_prcdr1_icd", "m1012_inp_prcdr2_icd",
                           "m1012_inp_prcdr3_icd", "m1012_inp_prcdr4_icd"]

  ICD10_FIEDS_FOR_CLAIMS = ["m1021_primary_diag_icd", "m1023_oth_diag1_icd",  "m1023_oth_diag2_icd", "m1023_oth_diag3_icd",
                            "m1023_oth_diag4_icd", "m1023_oth_diag5_icd"]

  ICD9_FIELDS_FOR_CLAIMS_POC = ["principal_icd1", "principal_icd2", "principal_icd3", "principal_icd4", "principal_icd5", "principal_icd6",
                                "pertinent_icd1", "pertinent_icd2", "pertinent_icd3", "pertinent_icd4", "pertinent_icd5", "pertinent_icd6"]

  ICD10_FIELDS_FOR_CLAIMS_POC = ["principal_icd10_1", "principal_icd10_2", "principal_icd10_3", "principal_icd10_4", "principal_icd10_5", "principal_icd10_6",
                                "pertinent_icd10_1", "pertinent_icd10_2", "pertinent_icd10_3", "pertinent_icd10_4", "pertinent_icd10_5", "pertinent_icd10_6"]

  def agency_name
    org.to_s if org
  end

  def agency_suite_number_street_address
    street = []
    street << agency_street_address unless agency_street_address.blank?
    street << agency_suite_number unless agency_suite_number.blank?
    street.join(",")
  end

  def agency_street_address
    org.street_address
  end

  def agency_suite_number
    org.suite_number
  end

  def agency_city_state_zip
    "#{org.city}, #{org.state} #{org.zip_code}"
  end

  def payer_full_name
    payer.company_name if payer.present?
  end

  def payer_address1
    if payer.claim_suite_number.present?
      "Suite " + payer.claim_suite_number
    else
      payer.claim_street_address unless payer.claim_street_address.blank?
    end
  end

  def payer_address2
    if payer.claim_suite_number.blank?
      nil
    else
      payer.claim_street_address unless payer.claim_street_address.blank?
    end
  end

  def payer_city_details
    payer_location = []
    payer_location << payer.claim_city unless payer.claim_city.blank?
    payer_location << ["#{payer.claim_state} #{payer.claim_zip_code}"].reject{|x| x.blank?}
    payer_location.join(", ")
  end

  def medicare_number
    treatment.treatment_request.patient_insurance_companies.patient_insurance_number
  end

  def poc_document
    treatment_episode.plan_of_care_document
  end

  def icd_9
    doc = treatment_episode.get_oasis_document
    icd_codes = []
    if doc
      date = doc.m0090_info_completed_dt.gsub('/','')
      info_date = Date.parse(date[4..7]+date[0..1]+date[2..3])
      through_date = get_through_date
      icd_codes = if self.is_a? PrivateInsuranceInvoice
                    get_icd_codes_for_private(doc)
                  else
                    get_icd_codes_for_medicare(through_date, doc)
                  end  
    elsif poc_document
      poc_date = Date.strptime(poc_document.poc_date, '%m/%d/%Y')
      icd_codes = if (poc_date >= Date.parse('01-10-2015'))
                    get_poc_icd_codes(ICD10_FIELDS_FOR_CLAIMS_POC)
                  else
                    get_poc_icd_codes(ICD9_FIELDS_FOR_CLAIMS_POC)
                  end
    end
    icd_codes
  end

  def get_icd_codes_for_medicare(through_date, doc)
    if (through_date and through_date >= Date.parse('01-10-2015') and  (self.final_claim? or self.lupa?))
      get_icd_codes(ICD10_FIEDS_FOR_CLAIMS, doc)
    elsif  (through_date and through_date < Date.parse('01-10-2015') and  (self.final_claim? or self.lupa?))
      get_icd_codes(ICD9_FIEDS_FOR_CLAIMS, doc)
    elsif ((treatment_episode.start_date < Date.parse('01-10-2015'))and self.rap?)
      get_icd_codes(ICD9_FIEDS_FOR_CLAIMS, doc)
    elsif ((treatment_episode.start_date >= Date.parse('01-10-2015'))and (self.rap?))
      get_icd_codes(ICD10_FIEDS_FOR_CLAIMS, doc)
    else
      get_icd_codes(ICD9_FIEDS_FOR_CLAIMS, doc)
    end  
  end  

  def get_icd_codes_for_private(doc)
    if Date.strptime(doc.m0090_info_completed_dt, '%m/%d/%Y') >= Date.parse('20151001')
      get_icd_codes(ICD10_FIEDS_FOR_CLAIMS, doc)
    else
      get_icd_codes(ICD9_FIEDS_FOR_CLAIMS, doc)
    end   
  end

  def get_poc_icd_codes(icd_codes)
    doc = treatment_episode.plan_of_care_document
    poc = []
    if doc
      icd_codes.each do |icd_code|
		poc << doc.send(icd_code).gsub(".","") if doc.send(icd_code).present?
      end
    end
    poc
  end

  def get_icd_codes(fields, doc)
    icd = []
    fields.each{|icd_code|
      icd << doc.send(icd_code).gsub(".","") if doc.send(icd_code)
    }
    icd
  end

  def icd_9_1
    icd_9[0]
  end

  def icd_9_2
    icd_9[1]
  end

  def icd_9_3
    icd_9[2]
  end

  def icd_9_4
    icd_9[3]
  end

  def icd_9_5
    icd_9[4]
  end

  def icd_9_6
    icd_9[5]
  end

  def icd_9_7
    icd_9[6]
  end


  def icd_9_8
    icd_9[7]
  end

  def icd_9_9
    icd_9[8]
  end

  def icd_9_10
    icd_9[9]
  end

  def icd_9_11
    icd_9[10]
  end

  def icd_9_12
    icd_9[11]
  end

  def total_charge
    amount, cents = receivables.map(&:receivable_amount).compact.sum.to_s.split('.')
    cents = (cents || '00').ljust(2, '0')
    [amount, cents]
  end

  def agency_npi
    org.health_agency_detail.npi_number
  end

  def patient_hi_claim_number
    treatment.treatment_request.patient_insurance_companies.patient_insurance_number
  end

  def agency_phone_number
    "Phone: #{org.phone_number}" if org.phone_number.present?
  end

  def agency_fax_number
    "Fax #{org.fax_number}" if org.fax_number.present?
  end

  def fed_tax_number
    org.fed_tax_number.insert(2, '-')
  end

  def src
    treatment.src
  end

  def statement_covers_period_from
    treatment_episode.start_date.strftime("%m%d%y") if treatment_episode
  end

  def statement_covers_period_through
    date = get_through_date
    date.strftime("%m%d%y") if date
  end

  def payer_name
    (payer.is_a? User) ? payer.full_name : payer.company_name if payer.present?
  end

  def payer_street_address
    payer_street = []
    payer_street << payer.claim_street_address unless payer.claim_street_address.blank?
    payer_street << "Suite " + payer.claim_suite_number unless payer.claim_suite_number.blank?
    payer_street.join(", ")
  end

  def payer_address
    payer_street_address + " " + payer_city_details
  end

  def payer_contact
    ("Claim Inquiry " + payer.claim_phone_number) if payer.claim_phone_number
  end

  def patient
    treatment.patient
  end

  def patient_name
    if oasis_doc
      "#{oasis_doc.m0040_pat_lname.capitalize},  #{oasis_doc.m0040_pat_fname.capitalize}"
    else
      "#{patient.last_name.capitalize}, #{patient.first_name.capitalize}"
    end
  end

  def formatted_patient_name
    if oasis_doc
      "#{oasis_doc.m0040_pat_lname.upcase} #{oasis_doc.m0040_pat_fname.upcase}"
    else
      "#{patient.last_name.upcase}, #{patient.first_name.upcase}"
    end
  end

  def patient_full_name_with_mr_number
    "#{patient.last_name.capitalize}, #{patient.first_name.capitalize} (#{patient.patient_reference})"
  end

  def patient_address
    patient.address_line_1 if patient.present?
  end

  def patient_city
    patient.city if patient.present?
  end

  def patient_state
    if oasis_doc.present?
      oasis_doc.m0050_pat_st
    else
      patient.state
    end
  end

  def patient_zip_code
    if oasis_doc
      oasis_doc.m0060_pat_zip
    else
      patient.zip_code
    end
  end

  def patient_dob
    if oasis_doc.present?
      Date.strptime(oasis_doc.m0066_pat_birth_dt, "%m/%d/%Y").strftime("%m%d%Y")
    else
      patient.dob.strftime("%m%d%Y")
    end
  end

  def patient_gender
    if oasis_doc.present?
      GENDER[oasis_doc.m0069_pat_gender]
    else
      patient.gender
    end
  end

  def soc_date
    treatment.treatment_start_date.strftime("%m%d%y") if treatment.present?
  end

  def soc_date_formatted
    treatment.treatment_start_date.strftime("%m/%d/%Y") if treatment.present?
  end

  def patient_reference
    patient.patient_reference
  end

  def patient_control_number
    "#{patient_reference} - #{self.invoice_number}" if patient
  end

  def medical_record_number
    "#{patient_reference} - #{patient.treatments.size}" if patient
  end

  def diagnosis_and_procedure_qualifier
    oasis_doc = treatment_episode.get_oasis_document
    if oasis_doc
      check_diagnosis_code(oasis_doc, "m1020_primary_diag_icd") ? "9" : "0"
    elsif poc_document
      check_diagnosis_code(poc_document, "principal_icd1") ? "9" : "0"
    end
  end

  def check_diagnosis_code(doc, code)
    icd_9_1 == doc.send(code).gsub(".", "") unless doc.send(code).nil?
  end

  def payer_details
    "#{payer_name} #{payer_address}   #{payer_contact}"
  end

  def total_service_units
    receivables.map(&:service_units).compact.sum
  end

  def total_amount
    receivables.map(&:receivable_amount).compact.sum
  end

  def calender_year
    if Invoice::INVOICE_TYPES[invoice_type] == "RAP"
      treatment_episode.start_date.year
    else
      treatment_episode.end_date.year
    end
  end

  def value_codes
    zip_code = patient_zip_code
    if zip_code
      zip_code = ZipCode.find_by_zip_code(zip_code)
      admin_name_2 = zip_code.admin_name_2
      state = zip_code.admin_name_1
      cbsa_code =  ProspectivePaymentSystem::PPSGrouper.cbsa_code(admin_name_2, state, calender_year)
      number_to_currency(cbsa_code, :format => "%n", :delimiter => "")
    end
  end

  def transfer_from_hha
    treatment.transfer_from_hha ? "47" : nil
  end

  def invoice_type_display
    (invoice_type == "R") ? "R" : ("0" + invoice_type)
  end

  def value_codes_list
    [{'61' => value_codes}, {'50' => pt_value_code_amount}, {'51' => ot_value_code_amount}, {'52' => st_value_code_amount},
     {'56' => sn_value_code_amount}, {'57' => chha_value_code_amount}].delete_if{|f| f.values.first.to_i == 0}
  end

  def get_discipline(discipline_code)
    Discipline.find_by_discipline_code(discipline_code)
  end

  def pt_value_code_amount
    visits = get_the_visits_by_discipline("PT")
    currency_format(visits.size)
  end

  def ot_value_code_amount
    visits = get_the_visits_by_discipline("OT")
    currency_format(visits.size)
  end

  def st_value_code_amount
    visits = get_the_visits_by_discipline("ST")
    currency_format(visits.size)
  end

  def sn_value_code_amount
    visits = get_the_visits_by_discipline("SN")
    get_visits_time(visits)
  end

  def chha_value_code_amount
    visits = get_the_visits_by_discipline("CHHA")
    get_visits_time(visits)
  end

  def get_the_visits_by_discipline(discipline_code)
    discipline = get_discipline(discipline_code)
    treatment_episode.completed_visits.where(discipline_id: discipline)
  end

  def get_visits_time(visits)
    time = visits.collect{|x| x.time_taken_for_visit_in_seconds}.sum/3600
    currency_format(time.round)
  end

  def currency_format(number)
    number_to_currency(number, :format => "%n", :delimiter => "")
  end

end
