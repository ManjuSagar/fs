
class HtmlViewOf271

  include ActionView::Helpers::NumberHelper
  
  attr_accessor :data_hash, :html_content
  def initialize data
    @data_hash = data
    @html_content = ""
  end
  
  def generate
  
    generate_patient_header

    html_content << "<h2>Eligibility OR Benefit Information</h2>"

    html_content << "<table class='eligibility'> <thead> <tr><th>Type</th> <th>Service</th> <th>More</th> </tr></thead><tbody>"

    row_num = 1
    data_hash.each_pair{|k,v|
#      if k.to_s.include?('eligibility_or_benefit') && v[:insurance_type_code] != 'Medicare Part A'
      if k.to_s.include?('eligibility_or_benefit') 
    
        html_content << "<tr #{(row_num % 2) == 0 ? 'class=even' : '' }>"
        row_num += 1

        html_content << "<td>#{v[:insurance_type_code].blank? ? '' : v[:insurance_type_code] + ': ' }#{v[:eb_code]}"
        html_content << "<td>#{v[:service_type_code]}"
        html_content << "<td>"
        html_content << "#{v[:time_period_qualifier]}<br>" if v[:time_period_qualifier] == 'Episode' #FIXME Episode hardcoded

        amount_applicable = true
        amount_applicable = false if v[:monetary_amount] == 0.0 
        amount_applicable = true if (v[:monetary_amount] == 0.0 && v[:quantity_qualifier].blank?)
        amount_applicable = false if v[:time_period_qualifier].blank? 
        amount_applicable = false if v[:time_period_qualifier] == 'Episode'
    
        if amount_applicable
          html_content << "Amount #{v[:time_period_qualifier]}: #{number_to_currency(v[:monetary_amount])} "  
          html_content << "Percentage: #{v[:percent_as_decimal]}" if v[:percent_as_decimal]
        end
        html_content << "<br>#{v[:quantity_qualifier]}  #{v[:time_period_qualifier]} = #{v[:quantity]}" unless v[:quantity_qualifier].blank?
        html_content << "<br>#{v[:medical_procedure_identifier]}" unless v[:medical_procedure_identifier].blank?
    
        v.each_pair{|k1,v1|
          if k1.to_s.include?('date_time_period_qualifier')
            k1 =~ /date_time_period_qualifier(.+)/
            date_value = v[:"date_time_period#{$1}"]
            tmp = date_value.split('-').collect{|d|
              d1 = Date.parse(d)
              d1.strftime('%m/%d/%Y')
            }
            html_content << "<br>#{v[k1]}: #{tmp.join('-')}"
          end
        }

        v[:related_parties].each_pair{|k1,v1|
          name =  "#{v1[:party_type]}: #{v1[:party_prefix_name]}"+
                  " #{v1[:party_first_name]}"+
                  " #{v1[:party_middle_name]}"+
                  " #{v1[:party_last_name]}"+
                  " #{v1[:party_suffix_name]}"
    
          html_content << "<br>"
          html_content << "<br>#{name}"
          html_content << "<br>#{v1[:party_id_type]}: #{v1[:party_id_value]}"
        } if v[:related_parties]


        html_content << "<br>Ref: #{v[:reference_id_qualifier]} #{v[:reference_id]} #{v[:reference_description]}" unless v[:reference_id_qualifier].blank?
        html_content << "<br>Message: #{v[:message]}" unless v[:message].blank?

        html_content << "</td>"
        html_content << "</tr>"
      end
    }

    html_content << "</tbody><table>"
    html_wrapper = "<html><head>#{css}</head><body style='font-family: Verdana'>#{html_content}</body></html>"
    
    html_wrapper
  end
  
  private
  
  def generate_patient_header
    html_content << "<h2>Patient Information</h2>"

    html_content << "<p>"+
                    "#{data_hash[:insured][:party_prefix_name]}"+
                    " #{data_hash[:insured][:party_first_name]}"+
                    " #{data_hash[:insured][:party_middle_name]}"+
                    " #{data_hash[:insured][:party_last_name]}"+
                    " #{data_hash[:insured][:party_suffix_name]}"

    html_content << "<br>"+
                    "#{data_hash[:insured][:party_address_line_1]}"+
                    " #{data_hash[:insured][:party_suite]}"
                
    html_content << "<br>"+
                    "#{data_hash[:insured][:party_city]}"+
                    ", #{data_hash[:insured][:party_state]}"+
                    " #{data_hash[:insured][:party_zip]}"+
                    "</br>"

    html_content << "<br>"+
                    "#{data_hash[:insured][:party_id_type]}"+
                    ": #{data_hash[:insured][:party_id_value]}"+
                    "</p>"  
  end
  
  def css
     s = <<-EOS
    <style>
    table.eligibility a:link {
      color: #666;
      font-weight: bold;
      text-decoration:none;
    }
    table.eligibility a:visited {
      color: #999999;
      font-weight:bold;
      text-decoration:none;
    }
    table.eligibility a:active,
    table.eligibility a:hover {
      color: #bd5a35;
      text-decoration:underline;
    }
    table.eligibility {
      font-family:Arial, Helvetica, sans-serif;
      color:#666;
      font-size:12px;
      text-shadow: 1px 1px 0px #fff;
      background:#eaebec;
      margin:20px;
      border:#ccc 1px solid;

      -moz-border-radius:3px;
      -webkit-border-radius:3px;
      border-radius:3px;

      -moz-box-shadow: 0 1px 2px #d1d1d1;
      -webkit-box-shadow: 0 1px 2px #d1d1d1;
      box-shadow: 0 1px 2px #d1d1d1;
    }
    table.eligibility th {
      padding:21px 25px 22px 25px;
      border-top:1px solid #fafafa;
      border-bottom:1px solid #e0e0e0;

      background: #ededed;
      background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
      background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
    }
    table.eligibility th:first-child {
      text-align: left;
      padding-left:20px;
    }
    table.eligibility tr:first-child th:first-child {
      -moz-border-radius-topleft:3px;
      -webkit-border-top-left-radius:3px;
      border-top-left-radius:3px;
    }
    table.eligibility tr:first-child th:last-child {
      -moz-border-radius-topright:3px;
      -webkit-border-top-right-radius:3px;
      border-top-right-radius:3px;
    }
    table.eligibility tr {
      text-align: center;
      padding-left:20px;
    }
    table.eligibility td:first-child {
      text-align: left;
      padding-left:20px;
      border-left: 0;
    }
    table.eligibility td {
      padding:18px;
      border-top: 1px solid #ffffff;
      border-bottom:1px solid #e0e0e0;
      border-left: 1px solid #e0e0e0;

      background: #fafafa;
      background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
      background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
    }
    table.eligibility tr.even td {
      background: #f6f6f6;
      background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
      background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
    }
    table.eligibility tr:last-child td {
      border-bottom:0;
    }
    table.eligibility tr:last-child td:first-child {
      -moz-border-radius-bottomleft:3px;
      -webkit-border-bottom-left-radius:3px;
      border-bottom-left-radius:3px;
    }
    table.eligibility tr:last-child td:last-child {
      -moz-border-radius-bottomright:3px;
      -webkit-border-bottom-right-radius:3px;
      border-bottom-right-radius:3px;
    }
    table.eligibility tr:hover td {
      background: #f2f2f2;
      background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
      background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);	
    }
    </style>
    EOS
    s
  end

end