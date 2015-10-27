class Processor999
  include NokogiriParseHelper
  include MedicareElectronicTransmissionRelatedMethods

  def run
    return unless Rails.application.config.perform_actual_electronic_claim_delivery.present?

    ha_detail_group_by_submitter_id = HealthAgencyDetail.authorized_agencies.group_by(&:submitter_id)
    ha_detail_group_by_submitter_id.each{|submitter_id, ha_details|
      next if pending_999_claims.empty?
      ha_details.each{ |ha_detail|
        agency = ha_detail.health_agency
        Rails.logger.info "Checking 9 Digit zip code for Org #{agency.id}"
        next if agency.zip_code_part2.blank?
        Org.current = agency
        next if pending_999_claims_for_org_specific.empty?
        Rails.logger.info "999 Processor initiated"
        file_999, file_name, uuid = download_response_file(agency,'999')
        if file_999.present?
          status, errors = get_claim_status file_999
          params = {file_999: file_999, file_name: file_name, org: agency, claims: pending_999_claims_for_org_specific, status: status, errors: errors, uuid: uuid}
          make_log_entry params
          update_status params
          send_request_to_discard_services(agency, uuid)
        else
          Rails.logger.info "999 file has not yet arrived for Agency #{agency.org_name} and Claim ##{pending_999_claims_for_org_specific.map(&:invoice_number)}"
        end
      }
    }
  end

  def pending_999_claims
    Invoice.where(transmission_status: 'pending_999')
  end

  def pending_999_claims_for_org_specific
    Invoice.org_scope.where(transmission_status: 'pending_999')
  end

  def update_status params
    claims = params[:claims]
    status = params[:status]
    claims.each {|claim|
      if status == 'accepted'
        claim.update_attributes({transmission_status: "pending_277", transmission_note: nil})
      elsif status == 'accepted_with_errors'
        claim_errors = get_claim_error_codes(params[:errors], claim)        
        claim.update_attributes({transmission_status: "pending_277", transmission_note: claim_errors})
      elsif status == 'rejected'
        claim_errors = get_claim_error_codes(params[:errors], claim)
        #send email indicating to the support people to indicate errors
        send_status_about_edi_generation params.merge!({claim: claim, transmission_status: "999_failure"})
        claim.update_attributes({transmission_status: "999_failure", transmission_note: claim_errors})
        claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
        claim.save!
      end
    }
  end

  def make_log_entry params
    status = params[:status]
    claims = params[:claims]
    transmission_status = if status == 'accepted'
                            "pending_277"
                          elsif status == 'accepted_with_errors'
                            'pending_277'
                          elsif status == 'rejected'
                            '999_failure'
                          end
    claims.each{|claim|
      claim.medicare_claim_transmission_logs.create!({type_of_response: "999", claim_edi: File.open(params[:file_999]),
                                                      type_of_file: 'incoming', response_file_name: params[:file_name],
                                                      transmission_status: transmission_status, uuid: params[:uuid]})
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