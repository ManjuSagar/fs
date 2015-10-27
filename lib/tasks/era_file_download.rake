desc "ERA files downloading, EX: rake era_file_download"

task :era_file_download => [:environment] do
  HealthAgencyDetail.authorized_agencies.each do |ha_detail|
    begin
      agency = ha_detail.health_agency
      Org.current = agency
      claim_submission = ClaimsSubmission.new(agency, ' ', mode = 'P')
      response = claim_submission.send_get_request
      if(response)
        success_file_names, failure_file_names, error_messages = EraDownloader.new.downloader(response, agency)
        if success_file_names.present?
          EraDownloader.send_era_file_status({org: agency.to_s, file_names: success_file_names, file_status: "Sucessfully Uploaded"})
        end
        if failure_file_names.present?
          EraDownloader.send_era_file_status({org: agency.to_s, file_status: "Upload Failure", file_names: failure_file_names,
                                              errors: error_messages})
        end
      end
    rescue Exception => e
      exception = e.message
      EraDownloader.send_era_file_status({org: agency.to_s, file_status: "Download Failure", errors: exception})
      next
    end

  end
end