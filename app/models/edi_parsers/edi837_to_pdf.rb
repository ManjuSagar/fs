class EdiParsers::Edi837ToPdf
  include EDIToXML
  include NokogiriParseHelper
  include JasperRails

  attr_accessor :claim_index, :claims, :mode, :edi_file

  def initialize(claims, mode, edi_file = nil)
    @claim_index = 0
    @mode = mode
    @claims = claims
    @edi_file = edi_file
    @genetate837_edi = Generate837Edi.new(claims, mode)
  end

  def convert_to_xml
    if edi_file.present?
      if edi_file.end_with?("xml")
        puts "<***** PRE-BUILT XML TEST MODE *********> Serving #{edi_file}"
        File.read edi_file
      elsif edi_file.end_with?("txt")
        puts "<***** PRE-BUILT EDI TEST MODE *********> Serving #{edi_file}"
        edi_2_xml(File.read edi_file)
      else
        edi_2_xml @genetate837_edi
      end
    end
  end

  def submitter_name
    org = claims.first.treatment.patient.org
    org.org_name
  end

  def get_xml_file_url
    xml = convert_to_xml
    ref = @genetate837_edi.get_file_name(".xml")
    file_name = "#{Rails.root}/tmp/#{ref}"
    @nokogiri_doc = get_nokogiri_document(xml)
    File.open(file_name, "w") {|f| f.puts @nokogiri_doc }
    Rails.application.routes.url_helpers.export_claims_file_path(ref)
  end

  def generate_pdf_report
    xml = convert_to_xml
    @nokogiri_doc = get_nokogiri_document(xml)
    hls = segment(@nokogiri_doc, "HL")
    pdfs = []
    (1..hls.size).step(2).each do |index|
      @claim_index = index
      pdfs << generate_pdf_claim
    end
    pdfs
    combined_pdf_files(pdfs)
  end

  def generate_pdf_claim
    file_content = Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/invoice/invoice.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def to_xml(options = {})
    list = {}
    methods = ReportDataSource::MedicareClaim::REPORT_METHODS
    methods.each do |method|
      list.merge!({ method => send(method) }) if respond_to? method
    end
    list.to_xml(:root => :invoice)
  end

  def current_claim_hl1_parent
    hls = segment(@nokogiri_doc, "HL")
    hls.detect{|hl| element_exists?(hl, "HL01", claim_index) }.parent
  end

  def current_claim_hl2_parent
    hls = segment(@nokogiri_doc, "HL")
    hls.detect{|hl| element_exists?(hl, "HL02", claim_index) }.parent
  end

  def agency_details_segment
    loop = loop(current_claim_hl1_parent, "2010")
    segments = segment(loop, "NM1")
    segments.detect{|segment| element_exists?(segment, "NM101", "85") }
  end

  def agency_name
    element_value(agency_details_segment, "NM103")
  end

  def agency_npi
    element_value(agency_details_segment, "NM109")
  end

  def agency_suite_number_street_address
    element_value(agency_details_segment.next_element, "N301")
  end

  def agency_city_state_zip
    n3 = agency_details_segment.next_element
    n4 = n3.next_element
    "#{element_value(n4, "N401")}, #{element_value(n4, "N402")} #{element_value(n4, "N403")}"
  end

  def agency_phone_number
    loop = loop(@nokogiri_doc, "1000")
    per = segment(loop, "PER")
    phone_num = contact_number(per, "TE")
    "Phone: #{phone_num}" if phone_num
  end

  def contact_number(segment, qualifier)
    if element_exists?(segment, "PER03", qualifier)
      element_value(segment, "PER04")
    elsif element_exists?(segment, "PER05", qualifier)
      element_value(segment, "PER06")
    elsif element_exists?(segment, "PER07", qualifier)
      element_value(segment, "PER08")
    end
  end

  def agency_fax_number
    loop = loop(@nokogiri_doc, "1000")
    per = segment(loop, "PER")
    fax = contact_number(per, "FX")
    "Fax #{fax}" if fax.present?
  end

  def payer_name
    loop = loop(@nokogiri_doc, "1000")
    nm1s = segment(loop, "NM1")
    nm1 = nm1s.detect{|nm1| element_exists?(nm1, "NM101", "40") }
    element_value(nm1, "NM103")
  end

  def payer_address
  end

  def payer_contact
  end

  def total_amount
    element_value(current_clm, "CLM02")
  end

  #Need to take from Invoice
  def invoice_date_display

  end

  def patient_details_segment
    loop = loop(current_claim_hl2_parent, "2010")
    segments = segment(loop, "NM1")
    segments.detect{|segment| element_exists?(segment, "NM101", "IL") }
  end

  def patient_name
    patient = patient_details_segment
    element_value(patient, "NM103") + ', ' + element_value(patient, "NM104")
  end

  def hi(qualifier)
    hi_segments.detect{|hi|
      hi01_element = element(hi, 'HI01')
      sub_element_exists?(hi01_element, 1, qualifier)
    }
  end

  def transfer_from_hha
    hi = hi("BG")
    if hi
      hi01_element = element(hi, 'HI01')
      sub_element_value(hi01_element, 2)
    end
  end

  def invoice_type_display
      clm05_element = element(current_clm, 'CLM05')
      type_of_bill = []
      if clm05_element.present?
        type_of_bill << sub_element_value(clm05_element, 1)
        type_of_bill << sub_element_value(clm05_element, 2)
        type_of_bill << sub_element_value(clm05_element, 3)
      end
      bill_type = type_of_bill.join("")
      bill_type.gsub("A", "2")
  end

  def treatment_authorization_codes
    loop = loop(current_claim_hl2_parent, "2300")
    segments = segment(loop, "REF")
    ref_segment = segments.detect{|segment| (element_exists?(segment, "REF01", "G1") or  element_exists?(segment, "REF01", "9F"))}
    element_value(ref_segment, "REF02")

  end

  def patient_relationship
    sbr = segment(current_claim_hl2_parent, "SBR")
    element_value(sbr, "SBR02")
  end

  def medicare_number
    loop = loop(current_claim_hl2_parent, "2010")
    nm1s = segment(loop, "NM1")
    nm1 = nm1s.detect{|nm1| element_exists?(nm1, "NM101", "IL") }
    element_value(nm1, "NM109")
  end

  def patient_identifier
    medicare_number
  end

  def prior_payment
    "0.00"
  end

  def patient_relation_to_insured
    ""
  end

  def medical_record_number
    loop = loop(current_claim_hl2_parent, "2300")
    segments = segment(loop, "REF")
    ref_segment = segments.detect{|segment| element_exists?(segment, "REF01", "EA") }
    element_value(ref_segment, "REF02")
  end

  def patient_control_number
    element_value(current_clm, "CLM01")
  end

  def provider_number
	loop = loop(@nokogiri_doc, "2010")
    segments = segment(loop, "NM1")
    nm_segment = segments.detect{|segment| element_exists?(segment, "NM101", "PR") }
    element_value(nm_segment, 'NM109')
  end

  def patient_address
    patient = patient_details_segment
    n3 = patient.next_element
    "#{element_value(n3, 'N301')}, #{element_value(n3, 'N302')}"
  end

  def patient_city
    patient = patient_details_segment
    n3 = patient.next_element
    n4 = n3.next_element
    element_value(n4, "N401")
  end

  def patient_state
    patient = patient_details_segment
    n3 = patient.next_element
    n4 = n3.next_element
    element_value(n4, "N402")
  end

  def patient_zip_code
    patient = patient_details_segment
    n3 = patient.next_element
    n4 = n3.next_element
    element_value(n4, "N403")
  end

  def patient_dob
    loop = loop(current_claim_hl2_parent, "2010")
    dmg = segment(loop, "DMG")
    date = element_value(dmg, "DMG02")
    date[4..5] + date[6..7] + date[0..3]
  end

  def patient_gender
    loop = loop(current_claim_hl2_parent, "2010")
    dmg = segment(loop, "DMG")
    element_value(dmg, "DMG03")
  end

  def soc_date
    loop = loop(current_claim_hl2_parent, "2300")
    dtps = segment(loop, "DTP")
    dtp = dtps.detect{|dtp| element_exists?(dtp, "DTP01", "435") }
    date = element_value(dtp, "DTP03")
    date[4..5] + date[6..7] + date[2..3]
  end

  def patient_reference
    patient = patient_details_segment
    element_value(patient, "NM109")
  end

  def receivables
    loop = loop(current_claim_hl2_parent, "2300")
    lx_segments = segment(loop, "LX")
    list = []
    lx_segments.each do |lx|
      item = {}
      sv2 = lx.next_element
      dtp = sv2.next_element
      date = element_value(dtp, "DTP03")

      item[:revenue_code] = element_value(sv2, "SV201")
      item[:hcpcs_code] = sub_element_value(element(sv2, "SV202"), "2")
      item[:receivable_amount] = element_value(sv2, "SV203")
      item[:service_units] = element_value(sv2, "SV205")
      item[:service_date_format] = date[4..5] + date[6..7] + date[2..3]

      list << item
    end
    number_of_receivables = list.size
    blank_receivables = (number_of_receivables % 21)
    (21 - blank_receivables).times{|i| list << Receivable.new(:receivable_date => "") }
    list
  end

  def diagnosis_and_procedure_qualifier
    hi("BF").present? ? '9' : '0'
  end

  def hi_segments
    segment(current_claim_hl2_parent, 'HI')
  end

  def icds
    value_code = []
    value_code_amounts = []
    primary_diagnosis = []
    other_diagnosis = []
    hi_segments.each do |icd|
      hi01_element = element(icd, 'HI01')
      if sub_element_exists?(hi01_element, '1', 'BE')
        ('01'..'06').each {|i|
          ele = "HI#{i}"
          value_code << sub_element_value(element(icd, ele), '2')
        value_code_amounts << sub_element_value(element(icd, ele), '5') + ".00"}
      elsif sub_element_exists?(hi01_element, '1', 'BK')
        primary_diagnosis << sub_element_value(hi01_element, '2')
      elsif sub_element_exists?(hi01_element, '1', 'BF')
        ('01'..'11').each {|i|
          ele = "HI#{i}"
          other_diagnosis << sub_element_value(element(icd, ele), '2')}
      end
    end
    {value_codes: value_code, value_code_amounts: value_code_amounts, primary_diagnosis: primary_diagnosis, other_diagnosis: other_diagnosis}
  end

  def icd_9_1
    icds[:primary_diagnosis][0]
  end

  def other_diagnosis
    icds[:other_diagnosis]
  end

  def icd_9_2
    other_diagnosis[0]
  end

  def icd_9_3
    other_diagnosis[1]
  end

  def icd_9_4
    other_diagnosis[2]
  end

  def icd_9_5
    other_diagnosis[3]
  end

  def icd_9_6
    other_diagnosis[4]
  end

  def icd_9_7
    other_diagnosis[5]
  end

  def icd_9_8
    other_diagnosis[6]
  end

  def icd_9_9
    other_diagnosis[7]
  end

  def icd_9_10
    other_diagnosis[8]
  end

  def icd_9_11
    other_diagnosis[9]
  end

  def icd_9_12
    other_diagnosis[10]
  end

  def value_codes
   icds[:value_code_amounts][0]
  end

  def physician_information_segment
    loop = loop(current_claim_hl2_parent, "2310")
    segments = segment(loop, "NM1")
    segments.detect{|segment| element_exists?(segment, "NM101", "71") }
  end

  def primary_physician_first_name
    element_value(physician_information_segment, "NM104")
  end

  def primary_physician_last_name
    element_value(physician_information_segment, "NM103")
  end

  def primary_physician_middle_initials
    element_value(physician_information_segment, "NM105")
  end

  def primary_physician_npi
    element_value(physician_information_segment, "NM109")
  end

  def fed_tax_number
    loop = loop(current_claim_hl1_parent, "2010")
    segments = segment(loop, "REF")
    ref_segment = segments.detect{|segment| element_exists?(segment, "REF01", "EI") }
    element_value(ref_segment, "REF02").insert(2, '-')
  end

  def cl1_segment
    loop = loop(current_claim_hl2_parent, "2300")
    segment(loop, "CL1")
  end

  def src
    element_value(cl1_segment, 'CL102')
  end

  def status_of_discharge
    element_value(cl1_segment, 'CL103')
  end

  def priority_of_visit
    element_value(cl1_segment, 'CL101')
  end

  def statement_covers_period
    loop = loop(@nokogiri_doc, "2300")
    segments = segment(loop, "DTP")
    ref_segment = segments.detect{|segment| element_exists?(segment, "DTP01", "434") }
    element_value(ref_segment, "DTP03").split('-')
  end

  def statement_covers_period_from
    date = statement_covers_period[0]
    date[4..5] + date[6..7] + date[2..3]
  end

  def statement_covers_period_through
    date = statement_covers_period[1]
    date[4..5] + date[6..7] + date[2..3]
  end

  def release_of_info
    element_value(current_clm, "CLM09")
  end

  def assignment_benefit_cert
    element_value(current_clm, "CLM08")
  end

  def current_clm
    loop = loop(current_claim_hl2_parent, "2300")
    clm = segment(loop, "CLM")
  end

  def code_code_field
    "B3"
  end

  def provider_taxonomy_code
    loop = loop(@nokogiri_doc, "2000")
    prv = segment(loop, "PRV")
    debug_log prv
    element_value(prv, "PRV03") if (element_exists?(prv, "PRV01", "BI") and element_exists?(prv, "PRV02", "PXC"))
  end

  def pt_value_code
    icds[:value_codes][1]
    end

  def ot_value_code
    icds[:value_codes][2]
  end

  def st_value_code
    icds[:value_codes][3]
  end

  def sn_value_code
    icds[:value_codes][4]
  end

  def chha_value_code
    icds[:value_codes][5]
  end

  def pt_value_code_amount
    icds[:value_code_amounts][1]
  end

  def ot_value_code_amount
    icds[:value_code_amounts][2]
  end

  def st_value_code_amount
    icds[:value_code_amounts][3]
  end

  def sn_value_code_amount
    icds[:value_code_amounts][4]
  end

  def chha_value_code_amount
    icds[:value_code_amounts][5]
  end

end