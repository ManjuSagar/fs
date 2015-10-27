class ClaimTransmitter
  include NokogiriParseHelper
  include Spawn
  NGS_SUBMITTER_ID = 'CHA075161'

  def run
    claims_submit_exceptions_log = Logger.new("#{Rails.root}/log/claims_submit_exceptions.log")
    if Rails.application.config.perform_actual_electronic_claim_delivery.present?
      ha_detail_group_by_submitter_id = HealthAgencyDetail.authorized_agencies.group_by(&:submitter_id)
      ha_detail_group_by_submitter_id.each{|submitter_id, ha_details|
        ha_details.each{ |ha_detail|
          agency = ha_detail.health_agency
          Org.current = agency
          break if Invoice.pending_transmission_org_specific.size > 0
          Rails.logger.info "Checking 9 Digit zip code for Org #{agency.id}"
          next if agency.zip_code_part2.blank?
          approved_claims = Invoice.approved_claims_not_edi_generation_failure
          next if approved_claims.empty?
          Rails.logger.info "Checking for claims to be sent in Org #{agency.id}"          
          break if Invoice.pending_transmission_org_specific.size > 0
          ActiveRecord::Base.transaction do
            Rails.logger.info "Org = #{agency.org_name} Preparing #{approved_claims.count} number of claims to be sent"
            params = {sent_date: Date.current, test_mode: 'P'}
            url, errors_present = Invoice.get_edi_url_and_claims_mark_as_sent(approved_claims, params)
            if errors_present
              invoice_number = url[0].first
              failure_reasons = url[0].last
              claim = Invoice.where(invoice_number: invoice_number).first
              update_status(claim, "edi_generation_failure", failure_reasons)
              claim.mark_as_esend_failed! if claim.may_mark_as_esend_failed?
              params = {claim: claim, errors: failure_reasons, transmission_status: "edi_generation_failure", org: agency}
              send_status_about_edi_generation(params)
            else
              begin
                agency_name_and_time = "#{agency.org_name} - #{Time.now}"
                claims_submit_exceptions_log.debug(agency_name_and_time)
                file = url.split("/").last
                file_name = "#{Rails.root}/tmp/#{file}"
                claims_line_numbers = get_claim_line_numbers_from_edi(file_name)
                make_log_entry file_name, approved_claims, claims_line_numbers
                claim_submit_information = submit_edi_file agency, file
                claims_submit_exceptions_log.debug(claim_submit_information) unless claim_submit_information.nil?
              rescue Exception => e
                claims_submit_exceptions_log.debug(e)
                claims_submit_exceptions_log.debug(e.backtrace.inspect)
              end
            end
          end
        }
      }
    else
      approved_claims_group_by_agency = Invoice.approved_claims.group_by(&:org_id)
      update_claims_status_as_sent(approved_claims_group_by_agency)
    end
    nil
  end

  def update_claims_status_as_sent(approved_claims_group_by_agency)
    approved_claims_group_by_agency.each{ |org_id, claims|
      claims.update_all(invoice_status: 'S', sent_date: Date.current)
    }
  end

  def send_status_about_edi_generation(params)
      FasternotesMailer.send_electronic_claim_transmission_status(params).deliver
  end


  def make_log_entry file_name, approved_claims, cliam_line_numbers
    approved_claims.each_with_index do |claim, index|
      claims_start_line_number = cliam_line_numbers[index]
      claims_end_line_number = cliam_line_numbers[index+1] - 1
      claim.medicare_claim_transmission_logs.create!(type_of_response: '837EDI', claim_edi: File.open(file_name),
                                                     type_of_file: 'outgoing', claim_start_line_number: claims_start_line_number,
                                                     claim_end_line_number: claims_end_line_number, response_file_name: file_name,
                                                     transmission_status: 'pending_trn')
      update_status claim, "pending_trn"
    end
  end

  def submit_edi_file agency, file
    claim_submission = ClaimsSubmission.new(agency, file, mode = 'P')
    claim_submission.send_post_request
  end

  def update_status (claim, status, failure_reasons = nil)
    claim.transmission_status = status
    claim.invoice_status = :esend_in_progress if claim.may_mark_as_esend_in_progress?
    claim.next_check_time = Time.current if status == "pending_ta1"
    claim.transmission_note = failure_reasons
    claim.save!(:validate => false)
  end

  def get_claim_line_numbers_from_edi(filename)
    lines = File.open(filename, 'r').read
    claim_start_line_numbers = []
    count = 0
    lines.each_line{|line|
      count += 1
      claim_start_line_numbers << count if line.split('*').first == 'CLM' or line.split('*').first == 'SE'
    }
    claim_start_line_numbers
  end

end