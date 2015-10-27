class TrnProcessor
  include NokogiriParseHelper
  include MedicareElectronicTransmissionRelatedMethods

  def run
    return unless Rails.application.config.perform_actual_electronic_claim_delivery.present?
    ha_detail_group_by_submitter_id = HealthAgencyDetail.authorized_agencies.group_by(&:submitter_id)
    ha_detail_group_by_submitter_id.each{|submitter_id, ha_details|
      next if pending_trn_claims.empty?
      ha_details.each{ |ha_detail|
        agency = ha_detail.health_agency
        Rails.logger.info "Checking 9 Digit zip code for Org #{agency.id}"
        next if agency.zip_code_part2.blank?
        Org.current = agency
        next if pending_trn_claims_for_org_specific.empty?
        Rails.logger.info "TRN Processor initiated"
        if MedicareAdministrativeContractor::PALMETTO_AGENCY_STATE_CODES.include? agency.state
          PalmettoTrnProcessor.new.run(agency)
        else
          NgsTrnProcessor.new.run(agency)
        end
      }
    }
  end

  def pending_trn_claims
    Invoice.where(transmission_status: 'pending_trn')
  end

  def pending_trn_claims_for_org_specific
    Invoice.org_scope.where(transmission_status: 'pending_trn')
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
    if status == 'accepted'
      claims = params[:claims]
      claims.each do |claim|
        claim.update_attributes({transmission_status: "pending_999", transmission_note: nil})
      end
    elsif status == 'rejected'
      #TODO :send email indicating to the support people to indicate errors
      claims.each do |claim|
        claim.update_attributes({transmission_status: "trn_failure", transmission_note: params[:errors]})
        claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
        claim.save!
      end
    end
  end

end