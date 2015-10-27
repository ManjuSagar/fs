module MedicareElectronicTransmissionRelatedMethods

  def download_response_file agency, resposne_type
    claim_submission = ClaimsSubmission.new(agency, ' ', mode = 'P')
    response = claim_submission.send_get_request
    File.open('all_available_files.xml', 'w'){|f| f.puts(response)}
    parse_xml(response)
    type = get_resposne_type resposne_type
    response_uri, file_name, uuid = get_response_uri_and_file_name type
    if response_uri.present?
      response = claim_submission.send_get_request_for_edi(response_uri)
      format = "#{Time.now.to_f}-#{rand(1000000)}".gsub('.', '-')
      submitter_name = agency.to_s[0..2]
      response_filename = "#{Rails::root}/tmp/#{submitter_name}_#{resposne_type}_response_#{format}.txt"
      File.open(response_filename, "w") {|f| f.puts(response)}
      [response_filename, file_name, uuid]
    end
  end

  def get_resposne_type response
    if response == 'trn'
      'UNKNOWN'
    elsif response == 'ta1'
      'X12_TA1'
    elsif response == '999'
      'X12_999'
    elsif response == '277ca'
      'X12_277CA'
    end
  end

  def parse_xml(xml_content)
    @nokogiri_doc = get_nokogiri_document(xml_content)
  end


  def get_response_uri_and_file_name type
    uri = ''
    file_name = ''
    uuid = ''
    @nokogiri_doc.css("file").each {|n|
      if n.css('state').map(&:text)[0] == 'current' and n.css('type').map(&:text)[0] == type
        file_name = n.css('name').map(&:text)[0]
        uuid = n.css('uuid').map(&:text)[0]
        # file_exists = MedicareClaimTransmissionLog.where(response_file_name: file_name).size > 0
        uri  = n.css('uri').map(&:text)[0]
      end
    }
    [uri, file_name, uuid]

  end

  def send_request_to_discard_services(agency, uuid)
    claim_submission = ClaimsSubmission.new(agency, '', 'P', uuid)
    claim_submission.send_post_request
  end

  def pending_trn_claims_for_org_specific
	  Invoice.org_scope.where(transmission_status: 'pending_trn')
  end

  def send_status_about_edi_generation(params)
    FasternotesMailer.send_electronic_claim_transmission_status(params).deliver
  end

end