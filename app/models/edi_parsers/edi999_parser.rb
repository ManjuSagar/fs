class EdiParsers::Edi999Parser
  include EDIToXML
  include NokogiriParseHelper
  attr_accessor :edi_file

  STATUS = {'A' => 'accepted', "R" => 'rejected', "E" => 'accepted_with_errors'}

  def initialize(edi_file)
    @edi_file = edi_file
  end

  def xml_parsing
    xml = edi_2_xml(File.read edi_file)

    @nokogiri_doc = get_nokogiri_document(xml)
    File.open("response_999.xml", "w") {|f| f.puts @nokogiri_doc }
    ak9_seg = segment(@nokogiri_doc, "AK9")
    ak2_seg = segment(@nokogiri_doc, "AK2")
    ak9_claim_status = element_value(ak9_seg, "AK901")
    result = []
    result = if ak9_claim_status == 'A'
      [STATUS[ak9_claim_status]]
    elsif ak9_claim_status == 'R' or ak9_claim_status == 'E'
      ik3_seg = segment(@nokogiri_doc, "IK3")
      if ik3_seg.present?
        errors = []
        ik3_seg.each{|ik3|
          h = {}
          if element_exists?(ik3.next_element, 'CTX01')
            ctx = ik3.next_element
            ik4 = ctx.next_element
          else
            ik4 = ik3.next_element
          end
          invoice_number = element_value(ctx, 'CTX01').split('-').last if ctx.present?
          # ik4 = ik4.next_element unless element_exists?(ik4, 'IK401')
          line_number = ['ISA', 'ST', 'GS'].include?(element_value(ik3, "IK301")) ? element_value(ik3, "IK302").to_i :  (element_value(ik3, "IK302").to_i + 2)
          h = {invoice_number: invoice_number, segment_id_code: element_value(ik3, "IK301"), line_number: line_number,
                loop_identifier: element_value(ik3, "IK303"), syntax_error_code: syntax_error_codes[element_value(ik3, "IK304")].to_s,
                position_in_segment: element_value(ik4, 'IK401'), data_element_syntax_error_code: element_value(ik4, 'IK403'),
                error_data_element: element_value(ik4, 'IK404')
          }
          ik5_status = element_value(ik4.next_element, 'IK501')
          if ik5_status.present?
            h.merge!({status: ik5_status })

          end
          errors << h
        }
        [STATUS[ak9_claim_status], errors]
      end

      # return 'Rejected'
    end
    result
  end

  def data_element_syntax_error_codes
    {"1" => "Required Data Element Missing", "2" => "Conditional Required Data Element Missing", "3" => "Too Many Data Elements",
     "4" => "Data Element Too Short", '5' => "Data Element Too Long", "6" => "Invalid Character In Data Element", "7" => "Invalid Code Value",
     "8" => "Invalid Date", "9" => "Invalid Time", "10" => "Exclusion Condition Violated", "12" => "Too Many Repetitions", "13" => "Too Many Components",
     "I10" => "Implementation 'Not Used' Data Element Present", "I11" => "Implementation Too Few Repetitions", "I12" => "Implementation Pattern Match Failure",
     "I13" => "Implementation Dependent 'Not Used' Data Element Present", "I6" => "Code Value Not Used in Implementation",
     "I9" => "Implementation Dependent Data Element Missing"}
  end

  def syntax_error_codes
    {"1" => "Unrecognized segment ID",
     "2" => "Unexpected segment",
     "3" => "Required Segment Missing",
     "4" => "Loop Occurs Over Maximum Times",
     "5" => "Segment Exceeds Maximum Use",
     "6" => "Segment Not in Defined Transaction Set",
     "7" => "Segment Not in Proper Sequence",
     "8" => "Segment Has Data Element Errors",
     "I4" => "Implementation 'Not Used' Segment Present",
     "I6" => "Implementation Dependent Segment Missing",
     "I7" => "Implementation Loop Occurs Under Minimum Times",
     "I8" => "Implementation Segment Below Minimum Use",
     "I9" => "Implementation Dependent 'Not Used' Segment Present"
    }
  end
end