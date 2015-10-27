class EdiParsers::Edi277Parser
  include EDIToXML
  include NokogiriParseHelper
  include EDICodes
  attr_accessor :edi_file

  ENTITY_QUALIFIER = {"1" => "Person", "2" => "Non-Person Entity"}
  ACTION_CODES = {"WQ" => "accepted",  "U" => "rejected"}

  def initialize(edi_file)
    @edi_file = edi_file
  end

  def xml_parsing
    xml = edi_2_xml(File.read edi_file)

    @nokogiri_doc = get_nokogiri_document(xml)
    File.open("response_277.txt", "w") {|f| f.puts @nokogiri_doc }
    hls = segment(@nokogiri_doc, "HL")
    ack_information = []
    claim_information = []
    loop = loop(@nokogiri_doc, "2000")
    payer_information = []
    receiver_information = []
    provider_information = []
    result = []

    loop.each{|l|
      loop_2100 =  loop(l, '2100')
      loop_2200 =  loop(l, '2200')
      nm1_segment = segment(loop_2100, "NM1")
      trn_segment = segment(loop_2200, "TRN")
      stc_segments = segment(loop_2200, "STC")
      qtys = segment(loop_2200, "QTY")
      amts = segment(loop_2200, "AMT")
      refs = segment(loop_2200, "REF")
      svcs = segment(loop_2200, "SVC")
      dtp = segment(loop_2200, "DTP") if element_exists?(segment(loop_2200, "DTP"), "DTP01", "472")
      nm101_value = element_value(nm1_segment, "NM101")


      result = if nm101_value == "PR"
                  identifier_code = element_value(nm1_segment, "NM101")
                  entity_type_qualifier = element_value(nm1_segment, "NM102")
                  payer_name = element_value(nm1_segment, "NM103")
                  payer_information << {entity_type_qualifier: ENTITY_QUALIFIER[entity_type_qualifier], payer_name: payer_name}

                elsif nm101_value  == '41'
                  receiver_name = element_value(nm1_segment, "NM103")
                  receiver_id = element_value(nm1_segment, "NM109")
                  receiver_trace = element_value(trn_segment, "TRN02")
                  accepted_qty_segment = qtys.detect{|qty| element_exists?(qty, "QTY01", "90") }
                  rejected_qty_segment = qtys.detect{|qty| element_exists?(qty, "QTY01", "AA") }
                  total_accepted_quantity = element_value(accepted_qty_segment, "QTY02") if accepted_qty_segment
                  total_rejected_quantity = element_value(rejected_qty_segment, "QTY02") if rejected_qty_segment
                  accepted_amt_segment = amts.detect{|amt| element_exists?(amt, "AMT01", "YU") }
                  rejected_amt_segment = amts.detect{|amt| element_exists?(amt, "AMT01", "YY") }
                  total_accepted_amount = element_value(accepted_amt_segment, "AMT02") if accepted_amt_segment
                  total_rejected_amount = element_value(rejected_amt_segment, "AMT02") if rejected_amt_segment
                  reasons = get_error_codes(stc_segments)
                  status_date = element_value(stc_segments.first, 'STC02')
                  response_status = element_value(stc_segments.first, 'STC03')
                  total_submitted_charges = element_value(stc_segments.first, 'STC04')
                  receiver_information << {receiver_name: receiver_name, receiver_id: receiver_id, receiver_trace: receiver_trace,
                                              total_accepted_quantity: total_accepted_quantity, total_rejected_quantity: total_rejected_quantity,
                                              total_accepted_amount: total_accepted_amount, total_rejected_amount: total_rejected_amount,
                                              status_date: status_date, total_submitted_charges: total_submitted_charges, status: ACTION_CODES[response_status],
                                              reject_or_accepted_reasons: reasons}



                elsif nm101_value  == '85'
                  provider_name = element_value(nm1_segment, "NM103")
                  identifier = element_value(nm1_segment, "NM108")
                  provider_npi = element_value(nm1_segment, "NM109") if identifier == 'XX'
                  patient_control_number = element_value(trn_segment, "TRN02")
                  accepted_qty_segment = qtys.detect{|qty| element_exists?(qty, "QTY01", "QA") }
                  rejected_qty_segment = qtys.detect{|qty| element_exists?(qty, "QTY01", "QC") }
                  accepted_amt_segment = amts.detect{|amt| element_exists?(amt, "AMT01", "YU") }
                  rejected_amt_segment = amts.detect{|amt| element_exists?(amt, "AMT01", "YY") }
                  total_accepted_quantity = element_value(accepted_qty_segment, "QTY02") if accepted_qty_segment
                  total_rejected_quantity = element_value(rejected_qty_segment, "QTY02") if rejected_qty_segment
                  total_accepted_amount = element_value(accepted_amt_segment, "AMT02") if accepted_amt_segment
                  total_rejected_amount = element_value(rejected_amt_segment, "AMT02") if rejected_amt_segment
                  reasons = get_error_codes(stc_segments)
                  total_submitted_charges = element_value(stc_segments.first, 'STC04')
                  response_status = element_value(stc_segments.first, 'STC03')
                  provider_information << {provider_name: provider_name, provider_npi: provider_npi, patient_control_number: patient_control_number,
                                              total_accepted_quantity: total_accepted_quantity, total_rejected_quantity: total_rejected_quantity,
                                              total_accepted_amount: total_accepted_amount, total_rejected_amount: total_rejected_amount,
                                              total_submitted_charges: total_submitted_charges, status: ACTION_CODES[response_status], reject_or_accepted_reasons: reasons
                                             }


                elsif nm101_value  == 'QC'
                  last_name = element_value(nm1_segment, "NM103")
                  first_name = element_value(nm1_segment, "NM104")
                  middile_name = element_value(nm1_segment, "NM105")
                  suffix_name = element_value(nm1_segment, "NM107")
                  identifier = element_value(nm1_segment, "NM108")
                  subscriber_number = element_value(nm1_segment, "NM109") if identifier == 'MI'
                  patient_control_number = element_value(trn_segment, "TRN02")
                  ref_1k_segment = refs.detect{|ref| element_exists?(ref, "REF01", "1K")}
                  claim_control_number = element_value(ref_1k_segment, 'REF02') if ref_1k_segment
                  ref_blt_segment = refs.detect{|ref| element_exists?(ref, "REF01", "BLT")}
                  billing_type = element_value(ref_blt_segment, 'REF02')
                  service_date = element_value(dtp, 'DTP03')
                  reasons = get_error_codes(stc_segments)
                  status_date = element_value(stc_segments.first, 'STC02')
                  response_status = element_value(stc_segments.first, 'STC03')
                  claim_information << {last_name: last_name, first_name: first_name, middile_name: middile_name,
                                               suffix_name: suffix_name, subscriber_number: subscriber_number,
                                               patient_control_number: patient_control_number, claim_control_number: claim_control_number,
                                               billing_type: billing_type, service_date: service_date, status_date: status_date,
                                               status: ACTION_CODES[response_status], reject_or_accepted_reasons: reasons
                                              }

                end
    }
    result = {payer_information: payer_information, receiver_information: receiver_information, provider_information: provider_information,
             patient_claim_information: claim_information}
   result
  end


  def get_error_codes(stc_segments)
    stc_information = []
    service_line_errors = []
    stc_segments.each_with_index{|stc, index|
      stc_information << stc_details(stc)
    }
    stc_information.flatten!
  end

  def stc_service_line_information(svcs)
    stc_service_line_information = []
    svcs.each{|svc|
      qualifier = sub_element_value(element(svc, "SVC01"), "1")
      hcpcs_code = sub_element_value(element(svc, "SVC01"), "2")
      revenue_code = element_value(svc, "SVC04")
      service_units = element_value(svc, "SVC07")
      stcs = segment(svc.parent, "STC")
      stcs.each{|stc|
        stc_service_line_information << stc_details(stc)
      }
    }
    stc_service_line_information
  end

  def stc_details(stc)
    claim_status_category_code_01 = sub_element_value(element(stc, "STC01"), "1")
    claim_status_code_01 = sub_element_value(element(stc, "STC01"), "2")
    entity_identifier_code_01 = sub_element_value(element(stc, "STC01"), "3")
    res = if element_exists?(stc, "STC10")
            claim_status_category_code_10 = sub_element_value(element(stc, "STC10"), "1")
            claim_status_code_10 = sub_element_value(element(stc, "STC10"), "2")
            entity_identifier_code_10 = sub_element_value(element(stc, "STC10"), "3")
            if entity_identifier_code_01.present?
              ["#{claim_status_category_code_01} : #{claim_status_code_01} : #{entity_identifier_code_01}",
               "#{claim_status_category_code_10} : #{claim_status_code_10} : #{entity_identifier_code_10}"]
            else
              ["#{claim_status_category_code_01} : #{claim_status_code_01}",
               "#{claim_status_category_code_10} : #{claim_status_code_10}"]
            end
          else
            entity_identifier_code_01.present? ? ["#{claim_status_category_code_01} : #{claim_status_code_01} : #{entity_identifier_code_01}"] :
                ["#{claim_status_category_code_01} : #{claim_status_code_01}"]
          end
    res

  end


end