class EdiParsers::EdiTa1Parser
  include EDIToXML
  include NokogiriParseHelper
  include EDICodes
  attr_accessor :edi_file

  def initialize(edi_file)
    @edi_file = edi_file
  end

  def xml_parsing
    xml = edi_2_xml(File.read edi_file)
    result = ''
    @nokogiri_doc = get_nokogiri_document(xml)
    @nokogiri_doc.css("acknowledgement").each do |response_node|
      interchange_control_number = response_node["Control"]
      status =  response_node["AcknowledgementCode"]
      error_code =  response_node["NoteCode"]
      result = (status == "A" ? "accepted" : {error_code: error_code})
    end
    result
  end

end