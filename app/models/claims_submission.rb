class ClaimsSubmission
  include AbilityServiceHelper

  attr_accessor :edi_file, :agency, :mode

  TEST_MODE = 'T'
  PRODUCTION_MODE = 'P'

  def initialize(agency, edi_file = '', mode = 'T', uuid=nil)
    ha = agency.health_agency_detail
    alias_name = ha.clm_billing_cert_alias_name
    source_password = ha.clm_billing_cert_password
    @edi_file = edi_file
    @mode = mode
    @agency = agency
    @source_password = source_password
    @alias_name = alias_name
    @uuid = uuid
  end

  def post_content
   @edi_file.present? ? File.open("#{Rails.root}/tmp/#{@edi_file}", 'r').read : ""
  end

  def url
    if mode == self.class::TEST_MODE
      "https://seapitest.visionshareinc.com/portal/seapi/services/BatchSubmit/10000/837.txt"
    else
      if @edi_file.present?
        "https://portal.visionshareinc.com/portal/seapi/services/BatchSubmit/#{get_service_id('batch_submit_service_id')}/#{@edi_file}"
      else
        "https://portal.visionshareinc.com/portal/seapi/file/#{@uuid}/state/discarded"
      end
    end
  end

  def get_url
    if mode == self.class::TEST_MODE
      "https://seapitest.visionshareinc.com/portal/seapi/services/BatchReceiveList/10001"
    else
      "https://portal.visionshareinc.com/portal/seapi/services/BatchReceiveList/#{get_service_id('batch_receive_list_service_id')}"
    end
  end

  def get_service_id(request)
    MedicareAdministrativeContractor.new(agency, mode).send(request)
  end

end