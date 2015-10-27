class Processor277Ca
  include NokogiriParseHelper
  include MedicareElectronicTransmissionRelatedMethods

  def run
    return unless Rails.application.config.perform_actual_electronic_claim_delivery.present?
    ha_detail_group_by_submitter_id = HealthAgencyDetail.authorized_agencies.group_by(&:submitter_id)
    ha_detail_group_by_submitter_id.each{|submitter_id, ha_details|
      next if pending_277ca_claims.empty?
      ha_details.each{ |ha_detail|
        agency = ha_detail.health_agency
        Rails.logger.info "Checking 9 Digit zip code for Org #{agency.id}"
        next if agency.zip_code_part2.blank?
        Org.current = agency
        claims = pending_277ca_claims_for_org_specific
        next if claims.empty?
        Rails.logger.info "Processor 277CA initiated"
        file_277ca, file_name, uuid = download_response_file(agency,'277ca')
        if file_277ca.present?
          params = get_claim_status file_277ca
          make_log_entry file_277ca, file_name, claims, params, uuid
          update_status claims, params
          send_request_to_discard_services(agency, uuid)
        else
          Rails.logger.info "277CA file has not yet arrived for Agency #{agency.org_name} and Claim ##{claims.map(&:invoice_number)}"
        end
      }
    }



  end

  def pending_277ca_claims
    Invoice.where(transmission_status: 'pending_277')
  end

  def pending_277ca_claims_for_org_specific
    Invoice.org_scope.where(transmission_status: 'pending_277')
  end

  def update_status claims, params
    claims.each{|claim|
      provider_status, claim_status, ccn, claim_errors = get_claim_status_and_errors(params, claim)

      if provider_status == 'accepted'
        if claim_status == 'accepted'
          claim.update_attributes({transmission_status: "accepted", transmission_note: nil, next_check_time: Time.current + 2.hours,
                                   claim_control_number: ccn })
          claim.sent_date = Date.current
          consultantHA = ConsultingCompanyHealthAgency.where(health_agency_id: claim.org.id)
          if consultantHA.present?
            User.current = consultantHA.first.consulting_company.org_users.first.user
          else
            User.current = OrgUser.org_staffs(claim.org).first.user
          end

          claim.mark_as_esent! if claim.may_mark_as_esent?
          claim.save!
        elsif claim_status == 'rejected'

          #send email indicating to the support people to indicate errors
          send_status_about_edi_generation params.merge!({claim: claim, org: claim.org, transmission_status: "277_failure", errors: claim_errors})
          claim.update_attributes({transmission_status: "277_failure", transmission_note: claim_errors, next_check_time: Time.current + 2.hours, })
          claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
          claim.save!
        end
      elsif provider_status == 'rejected'
        send_status_about_edi_generation params.merge!({claim: claim, org: claim.org, transmission_status: "277_failure", errors: claim_errors})
        claim.update_attributes({transmission_status: "277_failure", transmission_note: claim_errors, next_check_time: Time.current + 2.hours, })
        claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
        claim.save!
      end
    }
  end

  def make_log_entry file_277ca, file_name, claims, params, uuid
    claims.each{|claim|
      provider_status, claim_status, claim_errors = get_claim_status_and_errors(params, claim)
      if provider_status == 'accepted'
        if claim_status == 'accepted' || claim_status == 'rejected'
        claim.medicare_claim_transmission_logs.create!({type_of_response: "277CA", claim_edi: File.open(file_277ca),
                                                    type_of_file: 'incoming', response_file_name: file_name,
                                                    transmission_status: claim_status, uuid: uuid})
        end
      elsif provider_status == 'rejected'
        claim.medicare_claim_transmission_logs.create!({type_of_response: "277CA", claim_edi: File.open(file_277ca),
                                                        type_of_file: 'incoming', response_file_name: file_name,
                                                        transmission_status: provider_status, uuid: uuid})
      end
    }
  end

  def get_claim_status file_277ca
    EdiParsers::Edi277Parser.new(file_277ca).xml_parsing
  end


  def get_claim_status_and_errors(params, claim)
    claim_information = []
    claim_information << {payer_info: params[:payer_information]} if params[:payer_information].present?
    provider_status = ''
    status = ''; ccn = ''; claim_status = ''
    receiver_information = params[:receiver_information]
    provider_information = params[:provider_information]
    patient_claim_information = params[:patient_claim_information]

    if receiver_information.present?
      receiver_information.each{|receiver_info|
        status = receiver_info[:status]
        claim_information << {receiver_info: receiver_info}
      }
    end

    if provider_information.present?
      provider_information.each{|provider_info|
        invoice_number = provider_info[:patient_control_number].split('-').last.strip.to_i
        if invoice_number == claim.invoice_number
          claim_information << {provider_info: provider_info}
          provider_status = provider_info[:status]
        end
      }
    end
    if  patient_claim_information.present?
      patient_claim_information.each{|pci|
        invoice_number = pci[:patient_control_number].split('-').last.strip.to_i
        if invoice_number == claim.invoice_number
          claim_information << {patient_claim_information: pci}
          claim_status = pci[:status]
          ccn = pci[:claim_control_number]
        end

      }
    end
    [provider_status, claim_status, ccn, claim_information]
  end

  def get_invoice_number(patient_control_number)
    patient_control_number.split('-').last.strip.to_i
  end

end