=begin
include NokogiriParseHelper
response = File.open('all_available_files.xml', 'r')
@nokogiri_doc = get_nokogiri_document(response)
file_names = []
@nokogiri_doc.css("file").each {|n|
  file_names << n.css('name').map(&:text)[0]
}
file_names.each do |name|
  #MedicareClaimTransmissionLog.create(response_file_name: name)
  next if MedicareClaimTransmissionLog.where(response_file_name: name).size > 0
  MedicareClaimTransmissionLog.create(response_file_name: name)
end
=end


include NokogiriParseHelper
HealthAgencyDetail.authorized_agencies.each do |ha_detail|
  agency = ha_detail.health_agency
claim_submission = ClaimsSubmission.new(agency, ' ', mode = 'P')
response = claim_submission.send_get_request
@nokogiri_doc = get_nokogiri_document(response)
uuids = []
@nokogiri_doc.css("file").each {|n|
  uuid =  n.css('uuid').map(&:text)[0]
  c = ClaimsSubmission.new(agency, '', 'P', uuid)
  response = c.send_post_request
  debug_log response
}
end



