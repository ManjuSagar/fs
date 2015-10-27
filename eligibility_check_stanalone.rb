require 'rubygems'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

#Only for standalon run these are required.

# START

require 'action_view/helpers/number_helper'
require 'active_support/all'
require 'i18n'

# END

require 'extracter_of_271'
require 'html_view_of_271'
require 'ivans_client'

agency_npi = '1942484381'
agency_name = "xxx"
patient_id = '128649469A'
patient_first_name = 'GEORGE'
patient_last_name = 'DOUGLAS'
patient_dob = '19640326'

hcpc_codes_file_path = nil
edi_content = nil

rails_mode = false

if rails_mode
  client = IvansClient.new agency_npi, agency_name, patient_id, patient_first_name, patient_last_name, patient_dob, Date.today, 42
  edi_content = client.call
  hcpc_codes_file_path = File.join(Rails.root, 'static_data', 'hipps_codes','2013', 'hcpc_2013.csv')
else
  hcpc_codes_file_path = 'static_data/hipps_codes/2013/hcpc_2013.csv'
#  edi_content = File.open("HB271.txt").read
    edi_content = File.open("real_hb_271_3.txt").read
end

#Pass hcpc_codes_file_path as second param during Rails call
extracter = ExtracterOf271.new edi_content, hcpc_codes_file_path
data_hash = extracter.extract
require 'pp'

pp data_hash

view = HtmlViewOf271.new data_hash
html = view.generate
File.open('/tmp/temp.html', 'w') do |f|
  f.puts html
end

`open /tmp/temp.html`
