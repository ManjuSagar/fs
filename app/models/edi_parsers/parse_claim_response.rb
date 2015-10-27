class  EdiParsers::ParseClaimResponse
  include EDIToXML
  include NokogiriParseHelper

  def convert_to_xml(edi_file)
    response = if edi_file.present?

               end
    response
  end

  ERROR_CODES = {"001" => "The Interchange Control Numbers in the header ISA 13 and trailer IEA02 do not match",
                 "002" => "Standard in ISA11 (Control Standards) is not supported",
                 "003" => "Version of the controls is not supported",
                 "004" => "Segment Terminator is Invalid",
                 "005" => "Invalid Interchange ID Qualifier for Sender",
                 "006" => "Invalid Interchange Sender ID",
                 "007" => "Invalid Interchange ID Qualifier for Receiver",
                 "008" => "Invalid Interchange Receiver ID",
                 "009" => "Unknown Interchange Receiver ID",
                 "010" => "Invalid Authorization Information Qualifier value",
                 "011" => "Invalid Authorization Information value",
                 "012" => "Invalid Security Information Qualifier value",
                 "013" => "Invalid Security Information value",
                 "014" => "Invalid Interchange Date value",
                 "015" => "Invalid Interchange Time value",
                 "016" => "Invalid Interchange Standards Identifier value",
                 "017" => "Invalid Interchange Version ID value",
                 "018" => "Invalid Interchange Control Number value",
                 "019" => "Invalid Acknowledgment Requested value",
                 "020" => "Invalid Test Indicator value",
                 "021" => "Invalid Number of Included Groups value",
                 "022" => "Invalid Control Structure",
                 "023" => "Improper (Premature) End-of-File (Transmission)",
                 "024" => "Invalid Interchange Content (e.g., Invalid GS segment)",
                 "025" => "Duplicate Interchange Control Number",
                 "026" => "Invalid Data Element Separator",
                 "027" => "Invalid Component Element Separator"
  }

  TA1CODES = {A: ["000"], E: ["001", "002", "003", "006", "008", "009", "019", "020",  "021"],
              R: ["004", "005", "007","010", "011", "012", "013", "014", "015", "016", "017", "018", "022", "023", "024",
                  "025", "026", "027"]}

  def ta1_acknowledgment_parse
    edi_file = "#{Rails.root}/static_data/TA1.edi"
    debug_log File.read(edi_file)
    xml_content = edi_2_xml File.read(edi_file)
    debug_log xml_content
    @nokogiri_doc = get_nokogiri_document( xml_content )
    #s = @nokogiri_doc.css("acknowledgement")
    #debug_log "segment ......#{s.attribute('AcknowledgementCode')}"
  end

  def get_uuid(xml)
    debug_log "xml................#{xml}"
    @nokogiri_doc = get_nokogiri_document(xml)
    debug_log "document...........#{@nokogiri_doc}"
    uniq_id = @nokogiri_doc.css("uuid").text
  end

  def ta1_status
    s = @nokogiri_doc.css("acknowledgement")
    ack_code = s.attribute('AcknowledgementCode')
    note_code = s.attribute("NoteCode")
    message = ERROR_CODES[note_code]
  end

  def acknowledgement_999_parse
    edi_file = "#{Rails.root}/static_data/999_Acceptance.edi"
    debug_log File.read(edi_file)
    xml_content = edi_2_xml File.read(edi_file)
    debug_log xml_content
    @nokogiri_doc = get_nokogiri_document(xml_content)
    debug_log "MMMMMMMMMMMMMMMMMMMMMMMMMM"
    debug_log "#{@nokogiri_doc}"

  end

end