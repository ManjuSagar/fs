require 'nokogiri'
class MedicareRemittanceParser
  include EDIToXML
  include NokogiriParseHelper
  CLAIM_STATUS_CODE_MAP = {'1' => "Processed as Primary", '2' => "Processed as Secondary", '3' => "Processed as Tertiary", '4' =>  "Denied",
     "19" => "Processed as Primary, Forwarded to Additional Payer(s)", "20" => "Processed as Secondary, Forwarded to Additional Payer(s)",
     "21" => "Processed as Tertiary, Forwarded to Additional Payer(s)", "22" => "Reversal of Previous Payment",
     "23" => "Not Our Claim, Forwarded to Additional Payer(s)", "25" => "Predetermination Pricing Only - No Payment"
    }

  ADJUSTMENT_REASON_CODES = {"50" => "Late Charge", "51" =>  "Interest Penalty Charge", "72" =>  "Authorized Return", "90" => "Early Payment Allowance",
                             "AH" => "Origination Fee", "AM" => "Applied to Borrower's Account", "AP" => "Acceleration of Benefits", "B2" => "Rebate",
                             "B3" => "Recovery Allowance", "BD" => "Bad Debt Adjustment", "BN" => "Bonus", "C5" => "Temporary Allowance", "CR" => "Capitation Interest",
                             "CS" => "Adjustment", "CT" => "Capitation Payment", "CV" => "Capital Passthru", "CW" => "Certified Registered Nurse Anesthetist Passthru",
                             "DM" => "Direct Medical Education Passthru", "E3" => "Withholding", "FB" =>  "Forwarding Balance", "FC" => "Fund Allocation",
                             "GO" => "Graduate Medical Education Passthru", "HM" => "Hemophilia Clotting Factor Supplement", "IP" => "Incentive Premium Payment",
                             "IR" => "Internal Revenue Service Withholding", "IS" => "Interim Settlement", "J1" => "Nonreimbursable", "L3" => "Penalty", "L6" => "Interest Owed",
                             "LE" => "Levy", "LS" => "Lump Sum", "OA" => "Organ Acquisition Passthru", "OB" => "Offset for Affiliated Providers", "PI" => "Periodic Interim Payment",
                             "PL" => "Payment Final", "RA" => "Retro-activity Adjustment", "RE" => "Return on Equity", "SL" => "Student Loan Repayment", "TL" => "Third Party Liability",
                             "WO" => "Overpayment Recovery", "WU" => "Unspecified Recovery" }

  RENDERING_PROVIDER_INFO = {"0B" => "State License Number", "1A" => "Blue Cross Provider Number", "1B" => "Blue Shield Provider Number",
    "1C" => "Medicare Provider Number", "1D" => "Medicaid Provider Number", "1G" => "Provider UPIN Number", "1H" => "CHAMPUS Identification Number",
    "1J" => "Facility ID Number", "D3" => "National Council for Prescription Drug Programs Pharmacy Number", "G2" => "Provider Commercial Number",
    "HPI" => "Centers for Medicare and Medicaid Services National Provider Identifier", "SY" => "Social Security Number",
    "TJ" => "Federal Taxpayer's Identification Number" }

  QUANTITY_QUALIFIER = {"CA" => "Covered - Actual Days covered on this service", "CD" => "Co-insured - Actual",
    "LA" => "Life-time Reserve - Actual", "LE" => "Life-time Reserve - Estimated", "NE" => "Non-Covered - Estimated",
    "NR" => "Not Replaced Blood Units", "OU" => "Outlier Days", "PS" => "Prescription", "VS" => "Visits",
    "ZK" => "Federal Medicare or Medicaid Payment Mandate - Category 1",
    "ZL" => "Federal Medicare or Medicaid Payment Mandate - Category 2",
    "ZM" => "Federal Medicare or Medicaid Payment Mandate - Category 3",
    "ZN" => "Federal Medicare or Medicaid Payment Mandate - Category 4",
    "ZO" => "Federal Medicare or Medicaid Payment Mandate - Category 5"
  }

  COMM_NUM_QUALIFIER = {"EM" => "Electronic Mail", "FX" => "Facsimile", "TE" => "Telephone", "EX" => "Telephone Extension"
  }

  AMOUNT_QUALIFIER = {"AU" => "Coverage Amount", "D8" => "Discount Amount", "DY" => "Per Day Limit", "F5" => "Patient Amount Paid",
                      'I' => "Interest", "NL" => "Negative Ledger Balance", 'T' => "Tax", "T2" => "Total Claim Before Taxes",
                      "ZK" => "Federal Medicare or Medicaid Payment Mandate - Category 1",
                      "ZL" => "Federal Medicare or Medicaid Payment Mandate - Category 2",
                      "ZM" => "Federal Medicare or Medicaid Payment Mandate - Category 3",
                      "ZN" => "Federal Medicare or Medicaid Payment Mandate - Category 4",
                      "ZO" => "Federal Medicare or Medicaid Payment Mandate - Category 5"

  }

  def initialize(remittance)
    @remittance = remittance
    @xml_content = nil
    @nokogiri_doc = nil
    create_nokogiri_doc
  end

  def fetch_835_and_convert_to_xml
    remittance_edi = File.read(@remittance.medicare_remittance.queued_for_write[:original].path)
    #remittance_edi = File.read(File.join(ENV['HOME'], '835.edi'))
    @xml_content = if remittance_edi
                     edi_2_xml remittance_edi
                   end
  end

  def create_nokogiri_doc
    fetch_835_and_convert_to_xml
    @nokogiri_doc = get_nokogiri_document(@xml_content)
  end

  def remit_transaction_type
    seg = segment(@nokogiri_doc, "BPR")
    element_value(seg, "BPR04")
  end

  def total_number_of_claims
    clps.size
  end

  def remit_billed_amount
    clps.collect{|clp| claim_billed_amount(clp).to_f }.compact.inject(:+)
  end

  def remit_adjustment_amount
    clps.collect {|clp| adjustment_amount(clp.parent) }.compact.inject(:+)
  end

  def services(clp)
    loop_2100 = clp.parent
    loops_2110 = loop(loop_2100, "2110")
    loops_2110.collect {|l| segment(l, "SVC") }.compact.flatten
  end

  def remit_allowed_amount
    clps.collect {|clp| claim_allowed_amount(clp) }.compact.inject(:+)
  end

  def remit_co_ins_amount
    clps.collect {|clp| co_insurance_amount(clp.parent) }.compact.inject(:+)
  end

  def remit_deductible_amount
    clps.collect {|clp| deductible_amount(clp.parent) }.compact.inject(:+)
  end

  def remit_paid_amount
    clps.collect{|clp| claim_paid_amount(clp).to_f }.compact.inject(:+)
  end

  def remit_interest_amount
    clps.collect{|clp| claim_interest_amount(clp).to_f }.compact.inject(:+)
  end

  def claim_numbers
    clps.collect{|clp| patient_controller_number(clp) }
  end

  def remit_transaction_amount
    seg = segment(@nokogiri_doc, "BPR")
    formatted_amount(element_value(seg, "BPR02"))
  end

  def remit_transaction_date
    seg = segment(@nokogiri_doc, "BPR")
    formatted_date(element_value(seg, "BPR16"))
  end

  def cheque_or_eft_number
    seg = segment(@nokogiri_doc, "TRN")
    element_value(seg, 'TRN02')
  end

  def company_identifier
    seg = segment(@nokogiri_doc, "TRN")
    element_value(seg, 'TRN03')
  end

  def receiver_identification
    seg = detect_item(ref_segments, "REF01", "EV")
    element_value(seg, "REF02") if seg
  end

  def version_identification
    seg = detect_item(ref_segments, "REF01", "F2")
    element_value(seg, "REF02") if seg
  end

  def production_date
    date = detect_item(date_segment, "DTM01", "405")
    formatted_date(element_value(date, "DTM02")) if date
  end

  def clp_segments
    segment(@nokogiri_doc, "CLP")
  end

  def claim_billed_amount(clp)
    element_value(clp, "CLP03")
  end

  def claim_paid_amount(clp)
    element_value(clp, "CLP04")
  end

  def patient_responsibility_amount(clp)
    element_value(clp, "CLP05")
  end

  def internal_control_number(clp)
    element_value(clp, "CLP07")
  end

  def adjustment_code_and_amounts(loop, claim_level = false)
    adj_segments = segment(loop, "CAS")
    adj_segments = adj_segments.select{|adj| segment_exists?(adj.parent, "2100") } if claim_level
    adj_segments = [adj_segments] if adj_segments.is_a? Nokogiri::XML::Element
    list = []
    adj_segments.each do |adj_segment|
      children = adj_segment.children
      group_code = element_value(adj_segment, "CAS01")
      (2..19).step(3).each do |i|
        next unless element_exists?(adj_segment, "CAS" + "#{i}".rjust(2, '0'))
        carc_code = element_value(adj_segment, "CAS" + "#{i}".rjust(2, '0'))
        amt = element_value(adj_segment, "CAS" + "#{i+1}".rjust(2, '0'))
        quantity = element_value(adj_segment, "CAS" + "#{i+2}".rjust(2, '0'))
        list << {group_code: group_code, reason_code: carc_code, amount: amt.to_f, adjusted_quantity: quantity}
      end
    end
    list
  end

  def service_dates(loop)
    dtm_segments = date_segment(loop)
    if dtm_segments.size > 1
      from_date = formatted_date(element_value(dtm_segments[0], "DTM02"))
      to_date = formatted_date(element_value(dtm_segments[1], "DTM02"))
      {service_from_date: from_date, service_to_date: to_date}
    else
      date = formatted_date(element_value(dtm_segments, "DTM02"))
      {service_from_date: date, service_to_date: date}
    end
  end

  def patient_controller_number(clp)
    element_value(clp, "CLP01")
  end

  def claim_type(clp)
    element_value(clp, "CLP09")
  end

  def claim_status(clp)
    status_code =  element_value(clp, "CLP02")
    status = CLAIM_STATUS_CODE_MAP[status_code]
  end

  def service_billed_amount(svc)
    element_value(svc, "SVC02")
  end

  def service_paid_amount(svc)
    element_value(svc, "SVC03")
  end

  def procedure_codes(svc)
    svc01 = element(svc, "SVC01")
    res = []
    if ["HC", "N4"].include? sub_element_value(svc01, "1")
      (2..7).each do |i|
        res << sub_element_value(svc01, i.to_s) if sub_element_exists?(svc01, i.to_s)
      end
    end
    res.compact.join(", ")
  end

  def submitted_number_of_services(svc)
    element_value(svc, "SVC07")
  end

  def submitted_procedure_codes(svc)
    element = element(svc, "SVC06")
    res = []
    [2, 3, 4, 5, 6].each do |i|
      res << sub_element_value(element, i.to_s) if sub_element_exists?(element, i.to_s)
    end
    res.join(", ")
  end

  def procedure_code_modifiers(svc)
    svc01 = element(svc, "SVC01")
    res = []
    [3, 4, 5, 6].each do |i|
      res << sub_element_value(svc01, i.to_s) if sub_element_exists?(svc01, i.to_s)
    end
    res.join(", ")
  end

  def paid_number_of_services(svc)
    quantity = element_value(svc, "SVC05")
    value = quantity.present? ? quantity : 1
  end

  def get_the_service(loop)
    svc = segment(loop, "SVC")
    {line_item_billed_amount: service_billed_amount(svc), line_item_paid_amount: service_paid_amount(svc),
     line_item_allowed_amount: service_supplemental_amount(loop), paid_no_of_services: paid_number_of_services(svc),
     procedure_codes: procedure_codes(svc), submitted_procedure_codes: submitted_procedure_codes(svc),
     submitted_no_of_services: submitted_number_of_services(svc),
     procedure_code_modifiers: procedure_code_modifiers(svc), internal_control_number: line_item_control_number(loop),
     line_item_coinsurance_amount: co_insurance_amount(loop), service_revenue_code: service_revenue_code(svc),
     line_item_deductible_amount: deductible_amount(loop), line_item_adjustment_amount: adjustment_amount(loop),
     adjustments: adjustment_code_and_amounts(loop), rarcs: health_care_remark_codes(loop)
    }.merge(service_dates(loop))
  end

  def service_revenue_code(svc)
    element_value(svc, "SVC04") if element_exists?(svc, "SVC04")
  end

  def clps
    segment(@nokogiri_doc, "CLP")
  end

  def claim_list
    claims = []
    clps.each do |clp|
      svcs = []
      loop_2100 = clp.parent
      loops_2110 = loop(loop_2100, "2110")
      loops_2110.each do |l|
        svcs << get_the_service(l)
      end
      dates = statement_dates(loop_2100)
      claims << {patient_name: patient_name(clp), account_number: patient_controller_number(clp), medicare_number: medicare_number(clp),
                 claim_billed_amount: claim_billed_amount(clp), provider_paid_amount: claim_paid_amount(clp),
                 internal_control_number: internal_control_number(clp), services: svcs, adjustments: adjustment_code_and_amounts(loop_2100, true),
                 claim_co_ins_amount: co_insurance_amount(loop_2100), claim_deductible_amount: deductible_amount(loop_2100),
                 claim_allowed_amount: claim_allowed_amount(clp), claim_adjusted_amount: adjustment_amount(loop_2100),
                 claim_interest_amount: claim_interest_amount(clp), claim_assignment: claim_assignment(loop_2100),
                 late_filling_charge: claim_late_filling_charge(clp), rarcs: claim_rarcs(loop_2100),
                 service_from_date: dates[:start_date], service_to_date: dates[:end_date]
      }
    end
    claims
  end

  def claim_assignment(loop)
    lx = segment(loop.parent, "LX")
    element_value(lx, "LX01").to_i > 0 ? 'Y' : 'N'
  end

  def claim_adjusted_quantity(clp)
    adjustment = adjustment_code_and_amounts(clp.parent).detect{|a| a[:adjusted_quantity].present? and a[:group_code] == "PR" }
    adjustment[:adjusted_quantity] if adjustment
  end

  def claim_interest_amount(clp)
    interest = claim_supplemental_information(clp.parent).detect{|a| a[:reason] == "Interest" }
    interest.present? ? interest[:amt] : 0
  end

  def claim_late_filling_charge(clp)
    amount = 0.0
    services(clp).each do |service|
      amt = segment(service.parent, "AMT")
      amount += element_value(amt, "AMT02").to_f if element_exists?(amt, "AMT01", "KH")
    end
    amount
  end

  def nm1_qc_segment(clp)
    arr = segment(clp.parent, "NM1")
    arr = [arr] if arr.is_a? Nokogiri::XML::Element
    detect_item(arr, "NM101", "QC")
  end

  def patient_name(clp)
    nm1 = nm1_qc_segment(clp)
    "#{patient_first_name(nm1)} #{patient_middle_name(nm1)} #{patient_last_name(nm1)}"
  end

  def medicare_number(clp)
    nm1 = nm1_qc_segment(clp)
    nm108 = element_value(nm1, "NM108")
    element_value(nm1, "NM109") if nm108 == 'HN'
  end

  def patient_first_name(nm1)
    element_value(nm1, "NM104")
  end

  def patient_last_name(nm1)
    element_value(nm1, "NM103")
  end

  def patient_middle_name(nm1)
    element_value(nm1, "NM105")
  end

  def adjustment_amount(loop)
    list = adjustment_code_and_amounts(loop)
    list.select{|l| l[:group_code] != "PR" }.collect{|l| l[:amount].to_f }.compact.inject(:+)
  end

  def co_insurance_amount(loop)
    list = adjustment_code_and_amounts(loop)
    list.select{|l| l[:group_code] == "PR" and l[:reason_code] == '2' }.collect{|l| l[:amount].to_f }.compact.inject(:+)
  end

  def deductible_amount(loop)
    list = adjustment_code_and_amounts(loop)
    list.select{|l| l[:group_code] == "PR" and l[:reason_code] == '1' }.collect{|l| l[:amount].to_f }.compact.inject(:+)
  end

  def claim_allowed_amount(clp)
    servs = services(clp)
    servs.collect{|s| service_supplemental_amount(s.parent).to_f }.compact.inject(:+)
  end

  def service_identification(loop)
    refs = segment(loop, "REF")
    ref = detect_item(refs, "REFO1", "RB")
    element_value(ref, "REF02")
  end

  def line_item_control_number(loop)
    refs = segment(loop, "REF")
    refs = [refs] if refs.is_a? Nokogiri::XML::Element
    ref = detect_item(refs, "REF01", "6R")
    element_value(ref, "REF02") if ref
  end

  def rendering_provider_information(loop)
    refs = segment(loop, "REF")
    list = []
    refs.each do |ref|
      qualifier = RENDERING_PROVIDER_INFO[element_value(ref, "REF01")]
      next if qualifier.nil?
      list << {qualifier: qualifier, identification: element_value(ref, "REF02")}
    end
    list
  end

  def health_care_policy_identification(loop)
    refs = segment(loop, "REF")
    list = []
    refs.each do |ref|
      qualifier = element_value(ref, "REF01") == "OK"
      next if qualifier.nil?
      list << {qualifier: qualifier, identification: element_value(ref, "REF02")}
    end
    list
  end

  def service_supplemental_amount(loop)
    amt = segment(loop, "AMT")
    element_value(amt, "AMT02").to_f if element_exists?(amt, "AMT01", "B6")
  end

  def supplemental_quantity(loop)
    qtys = segment(loop, "QTY")
    list = []
    qtys.each do |qty|
      qualifier = element_exists?(qty, "QTY01") ? element_value(qty, "QTY01") : element_value(qty, "QTY03")
      quantity = element_exists?(qty, "QTY02") ? element_value(qty, "QTY02") : element_value(qty, "QTY04")
      list << {qualifier: QUANTITY_QUALIFIER[qualifier], quantity: quantity}
    end
    list
  end

  def health_care_remark_codes(loop)
    list_of_values(loop, "LQ", "LQ01", ["HE"], "LQ02")
  end

  def place_of_service(loop)
    refs = segment(loop, "REF")
    refs = [refs] if refs.is_a? Nokogiri::XML::Element
    ref = detect_item(refs, "REF01", "LU")
    element_value(ref, "REF02") if ref
  end

  def outpatient_adjudication_information(loop)
    moa = segment(loop, "MOA")
    #Currently these values are not required.
=begin
    {reimbursement_rate: element_value(moa, "MOA01"), hcpcs_payable_amount: element_value(moa, "MOA02"),
     claim_payment_remark_code1: element_value(moa, "MOA03"), claim_payment_remark_code2: element_value(moa, "MOA04"),
     claim_payment_remark_code3: element_value(moa, "MOA05"), claim_payment_remark_code4: element_value(moa, "MOA06"),
     claim_payment_remark_code5: element_value(moa, "MOA07"), esrd_payment_amount: element_value(moa, "MOA08"),
     professional_amount: element_value(moa, "MOA09")}
=end
    [element_value(moa, "MOA03"), element_value(moa, "MOA04"), element_value(moa, "MOA05"), element_value(moa, "MOA06"),
     element_value(moa, "MOA07")].compact  - [""]
  end

  def claim_rarcs(loop)
    ref = segment(loop, "MIA")
    ref.present? ? inpatient_adjudication_information(loop) : outpatient_adjudication_information(loop)
  end


  def inpatient_adjudication_information(loop)
    ref = segment(loop, "MIA")
    #Currently these values are not required.
=begin
    {covered_days: element_value(ref, "MIA01"), pps_amt: element_value(ref, "MIA02"),
         psychiatric_days: element_value(ref, "MIA03"), diagnosis_amt: element_value(ref, "MIA04"),
         claim_pymt_remark_code: element_value(ref, "MIA05"), share_amt: element_value(ref, "MIA06"),
         msp_amt: element_value(ref, "MIA07"), pps_capital_amt: element_value(ref, "MIA08"),
         pps_fed_drg_amt: element_value(ref, "MIA09"), pps_hospital_drg_amt: element_value(ref, "MIA10"),
         pps_disp_hospital_drg_amt: element_value(ref, "MIA11"), old_cap_amt: element_value(ref, "MIA12"),
         pps_indirect_edu_claim_amt: element_value(ref, "MIA013"), hospital_drg_amt: element_value(ref, "MIA014"),
         cost_report_days: element_value(ref, "MIA015"), fed_drg_amt: element_value(ref, "MIA016"),
         pps_capital_outlier_amt: element_value(ref, "MIA017"), indirect_teaching_amt: element_value(ref, "MIA018"),
         professional_billed_amt: element_value(ref, "MIA019"), claim_pymt_remark_code1: element_value(ref, "MIA020"),
         claim_pymt_remark_code2: element_value(ref, "MIA021"), claim_pymt_remark_code3: element_value(ref, "MIA022"),
         claim_pymt_remark_code4: element_value(ref, "MIA023"), capital_exception_amt: element_value(ref, "MIA024")
    }
=end
    [element_value(ref, "MIA020"), element_value(ref, "MIA021"), element_value(ref, "MIA022"), element_value(ref, "MIA023")].compact - [""]
  end

  def provider_adjustment_identifier(plb)
    element_value(plb, "PLB01")
  end

  def provider_adjustments_fiscal_period(plb)
    formatted_date(element_value(plb, "PLB02"))
  end

  def provider_adjustment_reasons(plb)
    list = []
    (3..14).step(2).each do |i|
      next unless element_exists?(plb, "PLB" + "#{i}".rjust(2, '0'))
      element = element(plb, "PLB" + "#{i}".rjust(2, '0'))
      carc_code = sub_element_value(element, "1")
      if carc_code
        carc_code = carc_code + " - " + ADJUSTMENT_REASON_CODES[carc_code]
      end
      adjustment_identifier = sub_element_value(element, "2")
      amt = element_value(plb, "PLB" + "#{i+1}".rjust(2, '0'))
      list << {reason_code: carc_code, amount: amt.to_f, financial_control_number: adjustment_identifier}
    end
    list
  end

  def provider_adjustments
    plbs = segment(@nokogiri_doc, "PLB")
    plbs = [plbs] if plbs.is_a? Nokogiri::XML::Element
    plbs_list = []
    plbs.each do |plb|
      plbs_list << {provider_adjustment_identifier: provider_adjustment_identifier(plb), date: provider_adjustments_fiscal_period(plb),
                    adjustments: provider_adjustment_reasons(plb)}
    end
    plbs_list
  end

  def other_claim_related_identification_1(loop)
    list_of_values(loop, "REF", "REF01", ["IL"], "REF02")
  end

  def other_claim_related_identification_2(loop)
    list_of_values(loop, "REF", "REF01", ["CE"], "REF02")
  end

  def other_claim_related_identification_3(loop)
    list_of_values(loop, "REF", "REF01", ["F8"], "REF02")
  end

  def rendering_provider_identification(loop)
    list_of_values(loop, "REF", "REF01", ["1A", "1B"], "REF02")
  end

  def list_of_values(scope, segment_id, condition_id, condition_values, value_id)
    condition_values = [condition_values] unless condition_values.is_a? Array
    arr = segment(scope, segment_id)
    arr = [arr] if arr.is_a? Nokogiri::XML::Element
    list = []
    arr.each do |ele|
      next unless condition_values.include?(element_value(ele, condition_id))
      list << element_value(ele, value_id)
    end
    list
  end

  def claim_contact_information(loop)
    per_segments = segment(loop, "PER")
    per_segments = [per_segments] if per_segments.is_a? Nokogiri::XML::Element
    list = []
    per_segments.each do |per|
      hsh = {}
      hsh[:contact_func_code] = element_value(per, "PER01")
      hsh[:name] = element_value(per, "PER02")
      hsh[:qualifier_1] = COMM_NUM_QUALIFIER[element_value(per, "PER03")]
      hsh[:qualifier_number_1] = element_value(per, "PER04")
      hsh[:qualifier_2] = COMM_NUM_QUALIFIER[element_value(per, "PER05")]
      hsh[:qualifier_number_2] = element_value(per, "PER06")
      hsh[:qualifier_3] = COMM_NUM_QUALIFIER[element_value(per, "PER07")]
      hsh[:qualifier_number_3] = element_value(per, "PER08")
      list << hsh
    end
  end

  def statement_dates(loop)
    dtm_segments = date_segment(loop)
    qualifier_232 = detect_item(dtm_segments, "DTM01", "232")
    qualifier_233 = detect_item(dtm_segments, "DTM01", "233")
    start_date =  formatted_date(element_value(qualifier_232, "DTM02")) if qualifier_232
    end_date = formatted_date(element_value(qualifier_233, "DTM02")) if qualifier_233
    {start_date: start_date, end_date: end_date}
  end

  def coverage_expiration_date
    ref = detect_item(date_segment, "DTM01", "036")
    expiration_date = formatted_date(element_value(ref, "DTM02")) if ref
    {coverage_expiration_date: expiration_date}
  end

  def claim_received_date
    ref = detect_item(date_segment, "DTM01", "050")
    received_date = formatted_date(element_value(ref, "DTM02")) if ref
    {claim_received_date: received_date}
  end

  def claim_supplemental_information(loop)
    amts = segment(loop, "AMT")
    amts = [amts] if amts.is_a? Nokogiri::XML::Element
    list = []
    amts.each do |amt|
      list << {reason: AMOUNT_QUALIFIER[element_value(amt, "AMT01")], amt: element_value(amt, "AMT02").to_f}
    end
    list
  end

end