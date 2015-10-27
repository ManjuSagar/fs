require 'csv'

class Array
  def contains_all? other
    other = other.dup
    each{|e| if i = other.index(e) then other.delete_at(i) end}
    other.empty?
  end
end

def deactivation_date_with_in_six_months(deactivation_date)
  deactivation_date = Date.parse(deactivation_date, '%Y%m%d')
  (Date.current..Date.current - 6.months).include_with_range? deactivation_date
end

desc "Import NPI registry, EX: rake import_npi_registry"
task :import_npi_registry  => [:environment] do
  msg = "NPI registry Successfully imported on #{Date.current.strftime('%m/%d/%Y')}"
  begin
    weekday = Date.today.beginning_of_week(:monday)
    day = Date.today.beginning_of_week(:monday)
    start_date = if (Date.today.strftime("%a")== "Mon")
                   Date.today.beginning_of_week(:monday) - 14.days
                 else
                   Date.today.beginning_of_week(:monday) - 7.days
                 end
    end_date = start_date + 6.days
    formatted_start_date = start_date.strftime("%m%d%y")
    formatted_end_date = end_date.strftime("%m%d%y")
    file_name = "NPPES_Data_Dissemination_#{formatted_start_date}_#{formatted_end_date}_Weekly"
    `wget http://download.cms.gov/nppes/#{file_name}.zip`
    `unzip -o #{file_name}.zip -d npi_registry`
    create_or_update_physicians
    `rm -rf npi_registry`
    `rm -rf #{file_name}.zip`
  rescue Exception => e
    msg = "While importing NPI registry something went wrong. Details are\n #{e.message}, #{e.backtrace}"
  end

  NpiRegistryMailer.send_npi_registry_import_notification(msg).deliver
end



desc "Update PECOS flag for physician, EX: rake update_pecos_flag_to_physician"
task :update_pecos_flag_to_physician  => [:environment] do
  msg = "PECOS flag updating on #{Date.current.strftime('%m/%d/%Y')}"
  begin
    file_exists = File.exist?('last_modified.txt')
     if(file_exists == false)
       update_pecos_based_on_modified_time
     else
       lines = File.readlines('last_modified.txt').each {|l| l.chomp!}
       last_modified_time = Time.parse(lines.first) unless lines.empty?
       current_time = get_last_modified_time
       if(last_modified_time != current_time)
         update_pecos_based_on_modified_time
       end
     end
  rescue Exception => e
    msg = "While importing NPI registry something went wrong. Details are\n #{e.message}, #{e.backtrace}"
  end
  NpiRegistryMailer.send_pecos_flag_update(msg).deliver
end


def update_pecos_based_on_modified_time
  File.open("last_modified.txt", "w"){|t| t.puts get_last_modified_time}
  `wget https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/MedicareProviderSupEnroll/Downloads/OrderingReferringFile-CSV.zip`
  `unzip -o OrderingReferringFile-CSV.zip -d pecos_flags`
  Dir.glob("#{Rails.root}/pecos_flags/**/*.csv").each do |file|
    update_physician_pecos_flags(file)
  end
  'rm -rf pecos_flags'
  'rm -rf OrderingReferringFile-CSV.zip'
end

def get_last_modified_time
  require 'open-uri'
  url = 'https://www.cms.gov/Medicare/Provider-Enrollment-and-Certification/MedicareProviderSupEnroll/Downloads/OrderingReferringFile-CSV.zip'
  open(url){|x| x.last_modified}
end

def create_or_update_physicians
  puts "hey i am doing process......."
  ActiveRecord::Base.transaction do
    puts "transaction..............."
    start_date = if (Date.today.strftime("%a")== "Mon")
                   Date.today.beginning_of_week(:monday) - 14.days
                 else
                   Date.today.beginning_of_week(:monday) - 7.days
                 end
    end_date = start_date + 6.days
    formatted_start_date = start_date.strftime("%Y%m%d")
    formatted_end_date = end_date.strftime("%Y%m%d")

    begin
      physicians = CSV.readlines("npi_registry/npidata_#{formatted_start_date}-#{formatted_end_date}.csv", :headers=>true, skip_blanks: true)
      count = 0
      physicians.each do |row|
        entity_type = row[1]
        puts "Record processing....."
        next if (entity_type.blank? || entity_type == 2)
        deactivation_date = row[39]
        reactivation_date = row[40]
        credential_text = row[10]
        physician_credentials = ['DPM', "D.P.M.", "D P M", 'D.S.C', 'DSC', "D.P.M", "DO", "D.O.", "D.O", "MD", "M.D.", "M.D", "DC", "D.C", "D.C."]
        non_physician_credentials = ['AA', 'MA', 'CCA', 'CCC','CCC-A', 'CCC-SLP', 'Au.D.', 'CNM', 'CRNA', 'CNS', 'CSW', 'LCSW', 'LCPC',
                                     'LICSW', 'LICSW', 'MSW', 'LMSW', 'CNP', 'ANP','FNP-BC', 'FNP','FNP-C', 'ARNP', 'NP', 'APN', 'ARPN', 'WHNP', 'CFNP',
                                     'OT', 'FNPC, OTR', 'ROT', 'OTRL', 'RPT', 'MSPT', 'PT', 'MPT', 'DDT', 'PA', 'LPA', 'PA-C', 'Ph. D.',
                                     'SLP', 'ST', 'RST', 'SLP', 'SPT','DPT', 'D.P.T', 'D.P.T.', 'CFCC', 'MFT', 'RD','APRN','RN','R.N.', 'R.N',
                                     'A.A', 'M.A', 'C.C.A', 'C.C.C-A', 'C.C.C.A' 'CCC-SLP', 'Au.D.', 'C.N.M', 'C.R.N.A', 'C.N.S', 'C.S.W', 'L.C.S.W', 'L.C.P.C',
                                     'L.I.C.S.W', 'L.I.C.S.W','M.S.W', 'L.M.S.W', 'C.N.P', 'F.N.P-B.C', 'F.N.P', 'F.N.P.', 'A.R.N.P', 'N.P', 'A.P.N', 'A.R.P.N', 'W.H.N.P', 'C.F.N.P',
                                     'O.T', 'O.T.R', 'R.O.T', 'O.T.R.L', 'R.P.T', 'M.S.P.T', 'P.T', 'M.P.T', 'D.D.T', 'P.A', 'L.P.A', 'P.A-C', 'Ph. D.',
                                     'S.L.P', 'S.T', 'R.S.T', 'S.L.P', 'S.P.T', 'C.F.C.C', 'M.F.T', 'R.D', 'A.P.R.N',
                                     'A.A.', 'M.A.', 'L.I.C.S.W.','C.C.A.', 'C.C.C-A.', 'C.C.C.A.' 'C.C.C L-SLP', 'C.C.C L/S.L.P.', 'Au.D.', 'C.N.M.', 'C.R.N.A.', 'C.N.S.', 'C.S.W.', 'L.C.S.W', 'L.C.P.C.',
                                     'L.I.C.S.W.', 'M.S.W', 'L.M.S.W.', 'C.N.P.', 'F.N.P-B.C.', 'F.N.P.', 'F.N.P.', 'A.R.N.P.', 'N.P.', 'A.P.N.', 'A.R.P.N.', 'W.H.N.P.', 'C.F.N.P.',
                                     'O.T.', 'O.T.R.', 'R.O.T.', 'O.T.R.L.', 'R.P.T.', 'M.S.P.T.', 'P.T.', 'M.P.T.', 'D.D.T.', 'P.A.', 'L.P.A.', 'P.A-C.', 'Ph. D.',
                                     'S.L.P', 'S.T.', 'R.S.T.', 'S.L.P.', 'S.P.T.', 'C.F.C.C.', 'M.F.T.', 'R.D.', 'A.P.R.N.',
                                     'ARNP-C']
        credentials = []
        credential_text.split(',').each{|c| credentials << c.strip} if credential_text.present?
        physician = false
        credentials = credentials.flatten
        if credentials.present?
          credentials.each{ |credential|
            physician = physician_credentials.include? credential.strip
            break if physician == true
          }
        end
        non_physician = non_physician_credentials.contains_all? credentials if (physician == false and credentials.present?)
        res = (entity_type != '2' and
            (non_physician == false || physician == true ) and
            (deactivation_date == ""  || (deactivation_date.present? and reactivation_date.present?) ||
                (deactivation_date.present? and deactivation_date_with_in_six_months(deactivation_date))))
        if (res)
          p = NpiRegistryPhysician.find_by_npi_number(row[0])
          p = if p.present?
                p
              else
                NpiRegistryPhysician.new
              end
          p.npi_number =  row[0]
          p.last_name =  row[5]
          p.first_name =  row[6]
          p.middle_name =  row[7]
          p.prefix =  row[8]
          p.suffix =  row[9]
          p.credential_text =  row[10]
          p.address_line1 =  row[20]
          p.address_line2 =  row[21]
          p.city =  row[22]
          p.state = row[23]
          p.zip_code =  row[24]
          p.country_code =  row[25]
          p.phone_number =  row[26]
          p.fax_number =  row[27]
          p.deactivation_date =  (row[39].present? ? Date.strptime(deactivation_date, '%m/%d/%y') : "")
          p.reactivation_date =  (row[40].present? ? Date.strptime(reactivation_date, '%m/%d/%y'): "")
          p.deactivation_reason_code =  row[38]
          p.gender =  row[41]
          p.taxanomy_code =  row[47]
          p.license_number =  row[48]
          p.license_number_state =  row[49]
          p.save!
          count += 1
        end
      end
    rescue Exception => e
      msg = "While CSV parsing errors occured. Details are\n #{e.message}, #{e.backtrace}"
    end
    puts "number of records processed .....#{count}"
  end
end


def update_physician_pecos_flags(file_name)
  ActiveRecord::Base.transaction do
    physicians = CSV.readlines("#{file_name}", :headers=>true, skip_blanks: true)
    physicians.each do |row|
      npi_number = row[0].strip
      physician = NpiRegistryPhysician.where(npi_number: npi_number).first
      if physician
        physician.update_column(:pecos_verification, true)
      end
    end
  end

end