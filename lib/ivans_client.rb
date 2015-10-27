require 'rubygems'
require 'savon'
require 'date'

class IvansClient

  attr_accessor :agency_npi, :agency_name, :patient_id, :patient_first_name, 
          :patient_last_name, :patient_dob, :start_date, :service_type 
  
  IVANS_USER = '8FA00001'
  IVANS_PASSWORD = '8FA00001'
  IVANS_CLIEND_ID = '92ED947F-2A05-4FDC-A9F8-CF1AD507F9CF'
  IVANS_URL = "https://limeservices.ivans.com/EligibilityOne.asmx?WSDL"
  IVANS_PAYER_ID = '10000'  # 10000 = Medicare, 10018 = Alabama Medicaid, 10127 = California Medicaid 
  HOME_HEALTH_RECORDS = 42

  def initialize( agency_npi, agency_name, patient_id, patient_first_name, patient_last_name, patient_dob, start_date,
      service_type = HOME_HEALTH_RECORDS)
    @agency_npi = agency_npi
    @agency_name = agency_name
    @patient_id = patient_id
    @patient_first_name = patient_first_name
    @patient_last_name= patient_last_name
    @patient_dob = patient_dob
    @start_date = start_date
    @service_type = service_type
          
  end
  
  def call
    client = Savon.client(wsdl: IVANS_URL,
      env_namespace: :soap,
    #  pretty_print_xml: true
    )

    response = client.call(:send_commercial_eligibility_request,
      :xml => make_custom_xml, :response_parser => :nokogiri
    )
    result = response.doc.xpath('//temp:SendCommercialEligibilityRequestResult', 'temp' => "http://tempuri.org/").text
  end
  
  private
  
  def make_custom_xml
    custom_full_xml = <<-EOF
<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Header>
        <IvansWSAuthentication xmlns="http://tempuri.org/">
          <User>#{IVANS_USER}</User>
          <Password>#{IVANS_PASSWORD}</Password>
          <ClientId>#{IVANS_CLIEND_ID}</ClientId>
        </IvansWSAuthentication>
      </soap:Header>
      <soap:Body>
        <SendCommercialEligibilityRequest xmlns="http://tempuri.org/">
          <data>
            <IvansPayerID>#{IVANS_PAYER_ID}</IvansPayerID>
            <MemberID>#{patient_id}</MemberID>
            <LastName>#{patient_last_name}</LastName>
            <FirstName>#{patient_first_name}</FirstName>
            <DateOfBirth_yyyyMMdd>#{patient_dob}</DateOfBirth_yyyyMMdd>
            <ServiceType>#{service_type}</ServiceType>
            <ProviderID>#{agency_npi}</ProviderID>
            <ProviderLastName>#{agency_name}</ProviderLastName>
            <DateOfService_Start_yyyyMMdd>#{start_date.strftime('%Y%m%d')}</DateOfService_Start_yyyyMMdd>
          </data>
        </SendCommercialEligibilityRequest>
      </soap:Body>
    </soap:Envelope>
    EOF
  end

end

# Sample call

# agency_npi = '1942484381'
# agency_name = 'METROPOLITAN HEALTHCARE, INC.'
# patient_id = '096609524'  # Last Letter Missing HINT: Are you man enough to guess the last letter?
# patient_first_name = 'VERSAVIA'
# patient_last_name = 'SARYAN'
# patient_dob = '19251212'
# service_type = 42
# start_date = Date.today

# client = IvansClient.new agency_npi, agency_name, patient_id, patient_first_name, 
#  patient_last_name, patient_dob, start_date, service_type
# puts client.call