class EdiParsers::TrnParser
  include NokogiriParseHelper
  attr_accessor :edi_file


  def initialize(edi_file)
    @edi_file = edi_file
  end

  def xml_parsing
    text = File.readlines edi_file
    text = text.map {|x| x.chomp }
    status = ""
    transaction_ack = {}
    if text.detect{|x| x.include?("No input validation problems")}
      status = 'accepted'
    else
      status = 'rejected'
      text.each do |line|
        next if line.blank?
        if line.include? 'File Name'
          file_name = line.split('=').last.strip
          transaction_ack.merge!({file_name: file_name})
        elsif line.include? 'Error number'
          line_index = text.index(line)
          error_code = line.split(' ')[3].strip
          transaction_ack.merge!({error_code: error_code, error_description: text[line_index+1]})
        end

      end
    end
    [status, transaction_ack]
  end
end