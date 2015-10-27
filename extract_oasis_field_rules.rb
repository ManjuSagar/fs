require 'rubygems'
require 'nokogiri'
require 'open-uri'

files = Dir['/home/msuser1/Downloads/oasissubmission/oasissubmission/*.html']
#files = ['oh_acy_addr_1.html']
#files = ['ob_m0050_pat_st.html']
checks = {}
files.each {|file|
#  puts "Doing file #{file}...."
  page = Nokogiri::HTML(open(file))

  if page.css('table')[1] 
    #puts page.css('table')[1].css('tr').size
    consistancy_position = page.css('table')[1].css('tr').size == 14 ? 12  :  14
    section_value = page.css('table')[1].css('tr')[consistancy_position].text.lstrip.rstrip
    if section_value != 'Consistency Required'
      result = section_value.gsub('Consistency Required', '').strip
      if result != 'Reserved for future use.' && result != '1.  For state use only.' &&
        result != '1.  For Medicare use only.'
        checks[File.basename(file)[3..-6].upcase] = result
      end
    end
  end
}

require 'pp'
pp checks
puts checks.keys.size  
