class EraDownloader
include NokogiriParseHelper

  def downloader(response, agency)
    success_file_names = []
    failure_file_names = []
    error_messages = []
    nokogiri_doc = get_nokogiri_document(response)
    if nokogiri_doc.css("file").count > 0
      nokogiri_doc.css("file").each do |n|
        if n.css('state').map(&:text)[0] == 'current' and n.css('type').map(&:text)[0] == 'X12_835'
          uuid = n.css('uuid').map(&:text)[0]
          uri  = n.css('uri').map(&:text)[0]
          file_name = n.css('name').map(&:text)[0]
          c = ClaimsSubmission.new(agency, '', 'P')
          response = c.send_get_request_for_edi(uri)
          file = "#{Rails.root}/tmp/#{file_name}"
          File.open(file, 'w'){|f| f.puts(response)}
          res = MedicareRemittance.create(medicare_remittance: File.open(file))
          if res.errors.messages.present?
            failure_file_names << [file_name, uuid]
            error_messages = res.errors.messages
            next
          else
            success_file_names << [file_name, uuid]
            send_request_to_discard_services(agency, uuid)
          end
        end
      end
    end
    [success_file_names, failure_file_names, error_messages]
  end

  def self.send_era_file_status(params)
    FasternotesMailer.send_era_file_download_status(params).deliver
  end

  def send_request_to_discard_services(agency, uuid)
    claim_submission = ClaimsSubmission.new(agency, '', 'P', uuid)
    claim_submission.send_post_request
  end
end