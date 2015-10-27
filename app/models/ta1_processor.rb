class Ta1Processor
  include NokogiriParseHelper
  include MedicareElectronicTransmissionRelatedMethods
  def run
    Rails.logger.info "TA1"
    return unless Rails.application.config.perform_actual_electronic_claim_delivery.present?

    ha_detail_group_by_submitter_id = HealthAgencyDetail.authorized_agencies.group_by(&:submitter_id)
    ha_detail_group_by_submitter_id.each{|submitter_id, ha_details|
      next if pending_ta1_claims.empty?
      ha_details.each{ |ha_detail|
        agency = ha_detail.health_agency
        Rails.logger.info "Checking 9 Digit zip code for Org #{agency.id}"
        next if agency.zip_code_part2.blank?
        Org.current = agency
        next if pending_trn_claims_for_org_specific.empty?
        ta1_file, file_name, uuid = download_response_file(agency,'ta1')
        Rails.logger.info "TA1 Processor initiated"
        if ta1_file.present?
          ta1_errors = get_claim_status ta1_file
          params = {ta1_file: ta1_file, file_name: file_name, claims: pending_trn_claims_for_org_specific, errors: ta1_errors, uuid: uuid}
          make_log_entry params
          update_status params
          send_request_to_discard_services(agency, uuid)
        else
          Rails.logger.info "TA1 file has not yet arrived for Agency #{agency.org_name} and Claim ##{pending_trn_claims_for_org_specific.map(&:invoice_number)}"
        end
      }
    }
  end


  def pending_ta1_claims
    Invoice.where(transmission_status: 'trn_failure')
  end

  def pending_trn_claims_for_org_specific
    Invoice.org_scope.where(transmission_status: 'trn_failure')
  end

  def update_status params
      # send_email
      claims = params[:claims]
      claims.each{|claim|
        claim.update_attributes({transmission_status: "ta1_failure", transmission_note: params[:errors]})
        claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
        claim.save!
      }
  end

  def make_log_entry params
    claims = params[:claims]
    claims.each{|claim|
      send_status_about_edi_generation params.merge!({claim: claim, transmission_status: 'ta1_failure'})
      claim.medicare_claim_transmission_logs.create!({type_of_response: "TA1", claim_edi: File.open(params[:ta1_file]),
                                                      type_of_file: 'incoming', response_file_name: params[:file_name],
                                                      transmission_status: 'ta1_failure', uuid: params[:uuid]})
    }

  end

  def get_claim_status ta1_file
    EdiParsers::EdiTa1Parser.new(ta1_file).xml_parsing if ta1_file.present?
  end

end