class PalmettoTrnProcessor
  include NokogiriParseHelper
  include MedicareElectronicTransmissionRelatedMethods

  def run agency
    trn_file, file_name, uuid = download_response_file(agency,'trn')
    if trn_file.present?
      errors = get_claim_trn_status trn_file
      params = {file: trn_file, response_type: 'TRN', file_name: file_name,
                claims: pending_trn_claims_for_org_specific, org: agency, transmission_status: 'trn_failure', errors: errors, uuid: uuid}
      make_log_entry params
      update_trn_response_status params
      send_request_to_discard_services(agency, uuid)
    else
      file_999, file_name, uuid = download_response_file(agency, '999')
      if file_999.present?
        status, errors = get_claim_status file_999
        params = {file: file_999, response_type: '999', file_name: file_name,
                  claims: pending_trn_claims_for_org_specific, transmission_status: transmission_status(status),
                  status: status, errors: errors, uuid: uuid}
        make_log_entry params
        update_status params
        send_request_to_discard_services(agency, uuid)
      else
        Rails.logger.info "TRN or 999 file has not yet arrived for Agency #{agency.org_name} and Claim ##{pending_trn_claims_for_org_specific.map(&:invoice_number)}"
      end
    end
  end

  def transmission_status status
    if status == 'accepted'
      "pending_277"
    elsif status == 'accepted_with_errors'
      'pending_277'
    elsif status == 'rejected'
      '999_failure'
    end
  end

  def get_claim_trn_status edi_file
    text = File.readlines edi_file
    text = text.map {|x| x.chomp }
    text
  end

  def make_log_entry params
    transmission_status = params[:transmission_status]
    claims = params[:claims]
    claims.each do |claim|
      claim.medicare_claim_transmission_logs.create!({type_of_response: params[:response_type], claim_edi: File.open(params[:file]),
                                                      type_of_file: 'incoming', response_file_name: params[:file_name],
                                                      transmission_status: transmission_status, uuid: params[:uuid]})

    end
  end

  def update_trn_response_status params    
    claims = params[:claims]
    claims.each do |claim|
	  #send email indicating to the support people to indicate errors	
      send_status_about_edi_generation params.merge!(claim: claim)
      claim.update_attributes({transmission_status: "trn_failure", transmission_note: params[:errors]})
      claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
      claim.save!
    end
  end

  def update_status params
    claims = params[:claims]
    status = params[:status]
    claims.each {|claim|
      if status == 'accepted'
        claim.update_attributes({transmission_status: params[:transmission_status], transmission_note: nil})
      elsif status == 'accepted_with_errors'
        claim_errors = get_claim_error_codes(params[:errors], claim)
        #send mail indicating to the support people to indecate errors
        send_status_about_edi_generation params.merge!(claim: claim)
        claim.update_attributes({transmission_status: params[:transmission_status], transmission_note: claim_errors})
      elsif status == 'rejected'
        claim_errors = get_claim_error_codes(params[:errors], claim)
        #send email indicating to the support people to indicate errors
        send_status_about_edi_generation params.merge!(claim: claim)
        claim.update_attributes({transmission_status: params[:transmission_status], transmission_note: claim_errors})
        claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
        claim.save!
      end
    }
  end


  def get_claim_status file_999
    EdiParsers::Edi999Parser.new(file_999).xml_parsing
  end

  def get_claim_error_codes(errors, claim)
    claim_errors = []
    errors.each{|error|
      if error[:invoice_number].to_i == claim.invoice_number
        claim_errors << error
      elsif error[:invoice_number].blank?
        claim_errors << errors
      end
    }
    claim_errors
  end

end