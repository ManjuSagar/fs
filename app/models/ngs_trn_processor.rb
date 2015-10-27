class NgsTrnProcessor
  include NokogiriParseHelper
  include MedicareElectronicTransmissionRelatedMethods

  def run agency
    trn_file, file_name, uuid = download_response_file(agency,'trn')
    if trn_file.present?
      status, errors = get_claim_trn_status trn_file
      params = {trn_file: trn_file, file_name: file_name, claims: pending_trn_claims_for_org_specific, status: status, errors: errors, uuid: uuid}
      make_log_entry params
      update_status params
      send_request_to_discard_services(agency, uuid)
    else
      Rails.logger.info "TRN file has not yet arrived for Agency #{agency.org_name} and Claim ##{pending_trn_claims_for_org_specific.map(&:invoice_number)}"
    end
  end

  def get_claim_trn_status trn_file
    EdiParsers::TrnParser.new(trn_file).xml_parsing
  end

  def make_log_entry params
    transmission_status = params[:status] == 'accepted' ? 'pending_999' : 'trn_failure'
    claims = params[:claims]
    claims.each do |claim|
      claim.medicare_claim_transmission_logs.create!({type_of_response: "TRN", claim_edi: File.open(params[:trn_file]),
                                                      type_of_file: 'incoming', response_file_name: params[:file_name],
                                                      transmission_status: transmission_status, uuid: params[:uuid]})

    end
  end

  def update_status params
    status = params[:status]
    claims = params[:claims]
    if status == 'accepted'
      claims.each do |claim|
        claim.update_attributes({transmission_status: "pending_999", transmission_note: nil})
      end
    elsif status == 'rejected'
      #send email indicating to the support people to indicate errors
      claims.each do |claim|
        send_status_about_edi_generation params.merge!({claim: claim, transmission_status: "trn_failure"})
        claim.update_attributes({transmission_status: "trn_failure", transmission_note: params[:errors]})
        claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
        claim.save!
      end
    end
  end

end