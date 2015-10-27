require 'extracter_of_271'
require 'jasper-rails'
require 'tempfile'
require 'npi_to_name'

class PatientMedicareEligibilityInfo
  include AbilityServiceHelper
  include EDICodes
  include EDIAndHETSMap
  include JasperRails

  attr_accessor :agency_npi, :agency, :patient_id, :patient_first_name,
                :patient_last_name, :patient_dob, :medicare_number, :agency_name

  def initialize(agency, patient_first_name, patient_last_name, patient_dob, medicare_number)
    ha = agency.health_agency_detail
    npi = ha.npi_number
    alias_name = ha.certificate_alias_name
    source_password = ha.certificate_password
    @agency_npi = npi
    @agency = agency
    @patient_first_name = patient_first_name
    @patient_last_name= patient_last_name
    @patient_dob = patient_dob
    @medicare_number = medicare_number
    @source_password = source_password
    @alias_name = alias_name
    @xml_content = nil
    @npi_list = {}
  end

  def post_content
    generate_edi_270
  end

  def url
    if @mode == self.class::TEST_MODE
      "https://seapitest.visionshareinc.com/portal/seapi/services/RealtimeMedicareEligibility/11000"
    else
      "https://portal.visionshareinc.com/portal/seapi/services/RealtimeMedicareEligibility/84"
    end
  end

  def fetch_271_and_convert_to_xml
  	@xml_content = if File.exists? File.join(ENV['HOME'], 'ability.xml')
  		puts "<***** PRE-BUILT XML TEST MODE *********> Serving ability.XML"
  		File.read File.join(ENV['HOME'], 'ability.xml')
      else
        edi_response = if File.exists? File.join(ENV['HOME'], 'ability.edi')
          puts "<***** PRE-BUILT EDI TEST MODE *********> Serving ability.EDI"
        File.read File.join(ENV['HOME'], 'ability.edi')
      else
        fetch_271
      end
      if (edi_response.include?("error") and edi_response.include?("code") and edi_response.include?("message"))
        edi_response
      else
        edi_2_xml edi_response
      end
    end
  end

  def fetch_271
    send_post_request
  end

  def generate_pdf_report
    fetch_271_and_convert_to_xml
    @nokogiri_doc = get_nokogiri_document(@xml_content)
    connection_errors = connection_error_list(@nokogiri_doc)
    str = ""
    if connection_errors.size > 0
      connection_errors.each_with_index{|msg, i| str += "#{i+1}. #{msg[:code]} - #{msg[:message]}<br/>"}
      str
    elsif error_code_display(@nokogiri_doc).size > 0
      error_code_display(@nokogiri_doc).each_with_index{|code, i| str += "#{i+1}. #{code} - #{error_code_hash[code]}<br/>"}
      str
    else
      file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/medicare_eligibility_elgh/elgh_response.jasper", self, {}, {})
      file = File.open(tempfile, "w")
      file.binmode
      file.write(file_content)
      file.close
      File.absolute_path(file)
    end
  end

  def provider_address
    address = ""
    address = agency.street_address unless agency.street_address.blank?
    address += "Suite #{agency.suite_number}" unless agency.suite_number.blank?
    address
    {provider_address_line_1: address}
  end

  def provider_city_details
    {provider_address_line_2: "#{agency.city}, #{agency.state} #{agency.zip_code}"}
  end

  def provider_contact
    contact = ""
    contact = "<b>Tel</b> #{agency.phone_number}" if agency.phone_number.present?
    contact += ", " if agency.phone_number && agency.fax_number
    contact += "<b>Fax</b> #{agency.fax_number}" if agency.fax_number.present?
    contact
    {provider_contact: contact}
  end

  def key_store_file
    file = File.join(ENV['HOME'], 'ability_keystore.jks')
    file = ((File.exists? file) ? file : "/workspace/certificates/ability_keystore.jks")
  end

  def to_xml(options = {})
    list = {sub_report_url: "#{Rails.root}/app/views/reports/medicare_eligibility_elgh/"}
    list.merge!(provider_address)
    list.merge!(provider_city_details)
    list.merge!(provider_contact)
    list.merge!({beneficiary_information: beneficiary_information_list(@nokogiri_doc, agency.org_name)})
    list.merge!({rehabilitation_sessions: rehabilations(@nokogiri_doc)})
    list.merge!({smoking_cessation: smoking_cessions(@nokogiri_doc)})
    list.merge!(preventives(@nokogiri_doc))
    list.merge!({plan_information: {hmo_plans: plan_coverage(@nokogiri_doc)}})
    list.merge!({medicare_secondary_payers: medicare_secondary_payers(@nokogiri_doc)})
    list.merge!({hospice_benefit_periods: hospice_information(@nokogiri_doc)})
    list.merge!(home_health_care(@nokogiri_doc))
    list.merge!(home_health_certifications(@nokogiri_doc))
    list.merge!(home_health_re_certifications(@nokogiri_doc))
    list.merge!({current_benefit_periods: current_benifit_periods(@nokogiri_doc)})

    res = list.to_xml(:root => :elgh_response)
    debug_log res
    res
  end

  def generate_edi_270
    input = []
    input << interchange_control_header_start
    input << functional_group_header_start
    input << transaction_set_header_start
    input << beginning_of_hierarchical_transaction
    input << information_source_level(1)
    input << information_source_name("payer")
    input << information_source_level(2)
    input << information_source_name("agency")
    input << information_source_level(3)
    input << subscriber_trace_number
    input << information_source_name("patient")
    input << subscriber_demographic_information
    input << subscriber_date
    input << subscriber_eligibility
    input << transaction_set_header_end
    input << functional_group_header_end
    input << interchange_control_header_end
    input.join
  end

  def interchange_control_header_start
    "ISA*00*          *00*          *ZZ*SUBMITTERID    *ZZ*CMS            *140516*0734*^*00501*000005014*0*P*|~"
  end

  def subscriber_date
    "DTP*291*RD8*#{requested_dates}~"
  end

  def functional_group_header_start
    "GS*HS*SUBMITTERID*CMS*20140831*073411*5014*X*005010X279A1~"
  end

  def transaction_set_header_start
    "ST*270*000000001*005010X279A1~"
  end

  def beginning_of_hierarchical_transaction
    "BHT*0022*13*TRANSA*20140831*073411~"
  end

  def subscriber_trace_number
    "TRN*1*TRACKNUM*ABCDEFGHIJ~"
  end

  def subscriber_demographic_information
    "DMG*D8*#{patient_dob.strftime('%Y%m%d')}~"
  end

  def subscriber_eligibility
    "EQ*1^2^3^4^5^6^7^8^10^12^13^14^15^18^20^23^24^25^26^27^28^30^33^35^36^37^38^39^40^41^42^45^47^48^49^50^51^52^53^54^62^65^" +
    "67^68^69^73^76^78^80^81^82^83^86^88^93^98^99^A0^A3^A4^A5^A6^A7^A8^AD^AE^AF^AG^AI^AJ^AK^AL^BF^BG^BH^BT^BU^BV^DM^MH^UC~" +
    "EQ**HC|76977~" + "EQ**HC|77057~" + "EQ**HC|77078~" + "EQ**HC|77080~" + "EQ**HC|77081~" + "EQ**HC|80061~" + "EQ**HC|82270~" +
    "EQ**HC|82465~" + "EQ**HC|82947~" + "EQ**HC|82950~" + "EQ**HC|82951~" + "EQ**HC|83718~" + "EQ**HC|84478~" + "EQ**HC|90669~" +
    "EQ**HC|90670~" + "EQ**HC|90732~" +
    "EQ**HC|G0101~" + "EQ**HC|G0102~" + "EQ**HC|G0103~" + "EQ**HC|G0104~" + "EQ**HC|G0105~" + "EQ**HC|G0106~" + "EQ**HC|G0117~" +
    "EQ**HC|G0118~" + "EQ**HC|G0120~" + "EQ**HC|G0121~" + "EQ**HC|G0123~" + "EQ**HC|G0130~" + "EQ**HC|G0143~" + "EQ**HC|G0144~" +
    "EQ**HC|G0145~" + "EQ**HC|G0147~" + "EQ**HC|G0148~" + "EQ**HC|G0202~" + "EQ**HC|G0328~" + "EQ**HC|G0389~" + "EQ**HC|G0402~" +
    "EQ**HC|G0403~" + "EQ**HC|G0404~" + "EQ**HC|G0405~" + "EQ**HC|G0438~" + "EQ**HC|G0439~" + "EQ**HC|G0444~" + "EQ**HC|G0445~" +
    "EQ**HC|G0446~" + "EQ**HC|G0447~" + "EQ**HC|P3000~" + "EQ**HC|Q0091~"
  end

  def information_source_level(level = 1)
    if level == 1
      "HL*1**20*1~"
    elsif level == 2
      "HL*2*1*21*1~"
    else
      "HL*3*2*22*0~"
    end
  end

  def information_source_name(context = "agency")
    if context == "payer"
      "NM1*PR*2*CMS*****PI*CMS~"
    elsif context == "agency"
      "NM1*1P*2*#{agency.org_name}*****XX*#{agency_npi}~"
    else
      "NM1*IL*1*#{patient_last_name}*#{patient_first_name}****MI*#{medicare_number}~"
    end
  end

  def transaction_set_header_end
    "SE*61*000000001~"
  end

  def functional_group_header_end
    "GE*1*5014~"
  end

  def interchange_control_header_end
    "IEA*1*000005014~"
  end
end