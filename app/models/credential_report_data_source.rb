require "jasper-rails"
class CredentialReportDataSource
  include JasperRails
  def agency_name(fs)
    (fs.user_type=="FieldStaff") ? org_name : fs.orgs.where(org_type: "StaffingCompany").first.org_name
  end

  def check_expiry(exp_date)
    if exp_date
      if exp_date > Date.current
        days = (exp_date - Date.current).to_i
        "#{days.abs} day(s)" if days < 30
      elsif exp_date < Date.current
        days = (exp_date - Date.current).to_i
        "#{days.abs} day(s)"
      elsif exp_date == Date.current
        days = (exp_date - Date.current).to_i
        "#{days.abs} day(s)"
      end
    else
      ""
    end

  end

  def contact_details
    org.contact_details
  end


  def check_credential_status(exp_date)
    if exp_date
      formatted_exp_date = exp_date.strftime("%m/%d/%Y")
      if exp_date > Date.current
        days = (exp_date - Date.current).to_i
        "Expiring - #{formatted_exp_date}" if days < 30
      elsif exp_date < Date.current
        days = (exp_date - Date.current).to_i
        "Expired - #{formatted_exp_date}"
      else
        "Expiring - #{formatted_exp_date}"
      end
    end

  end

  def org_name
    org.to_s
  end

  def title(fs)
    fs.license_type.license_type_code
  end

  def field_staffs_list
    staffing_company_staffs = org.staffing_companies.collect {|s| s.staffs.sort_by{|fs| fs.last_name}}.flatten
    fs = org.field_staffs.sort_by{|fs| fs.last_name}
    fs + staffing_company_staffs
  end

  def staffing_company(fs)
    (fs.user_type=="LiteFieldStaff") ? fs.orgs.where(org_type: "StaffingCompany").first.org_name : ""
  end

  def get_credentials(fs, is_sc_fs_credentials = false )
    expire_credentials = []
    missed_credentials = []
    fs_credential_types = fs.license_type.discipline.field_staff_credential_types
    fs_credentials = fs.credentials
    if fs_credentials.present?
      field_staff_added_to_list = false
      fs_credential_types.each do |ct|
        next if (ct.expiry_flag == false)
        credential = fs_credentials.detect{|fsc| fsc.field_staff_credential_type == ct}
        if credential
          if check_expiry(credential.expiry_date).present?
            credential = credential(fs, credential.field_staff_credential_type, field_staff_added_to_list).merge("status" => check_credential_status(credential.expiry_date), "aging" => (check_expiry(credential.expiry_date)))
            credential = credential.merge("staffing_company" => staffing_company(fs) ) if is_sc_fs_credentials
            expire_credentials << credential
            field_staff_added_to_list = true
          end
        else
          credential = credential(fs, ct, field_staff_added_to_list).merge("status" => "Missing", "aging" => "NA")
          credential = credential.merge("staffing_company" => staffing_company(fs) ) if is_sc_fs_credentials
          missed_credentials << credential
          field_staff_added_to_list = true
        end
      end
    else
      field_staff_added_to_list = false
      fs_credential_types.each do |ct|
        credential = credential(fs, ct, field_staff_added_to_list).merge("status" => "Missing", "aging" => "NA")
        credential = credential.merge("staffing_company" => staffing_company(fs)) if is_sc_fs_credentials
        missed_credentials << credential
        field_staff_added_to_list = true
      end
    end
    expired_credentials = expire_credentials.select{|x| x["status"].start_with? "Expired"}.sort_by{|h| h["aging"].gsub(" day(s)", "").to_i}.reverse
    expiring_credentials = expire_credentials.select{|x| x["status"].start_with? "Expiring"}.sort_by{|h| h["aging"].gsub(" day(s)", "").to_i}
    missed_credentials + expired_credentials + expiring_credentials
  end

  def field_staff_credentials
    credential_list = []
    fs_list = field_staffs_list
    if fs_list
      fs_list.each do |fs|
        credentials = get_credentials(fs)
        credentials.each_with_index{|c, i|
          credentials[i].merge!("repeating_fs" => ((i==0)? "F" : "T"))
        }
        credential_list += credentials
      end
    end
    credential_list
  end

  def fs_credentials(staff)
    if (staff.user_type ==  "FieldStaff")
      individual_fs_credentials(staff)
    elsif(staff.user_type ==  "LiteFieldStaff")
      staffing_company_credentials(staff)
    end
  end

  def individual_fs_credentials(staff = nil)
    credential_list = []
    if staff
      credential_list += get_credentials(staff)
    else
      fs_list = org.field_staffs.sort_by{|fs| fs.last_name}.flatten
      fs_list.each do |fs|
        credential_list += get_credentials(fs)
      end
    end
    credential_list
  end


  def staffing_company_credentials(staff = nil)
    credential_list = []
    if staff
      credential_list += get_credentials(staff, true)
    else
      fs_list = org.staffing_companies.collect {|s| s.staffs.sort_by{|fs| fs.last_name}}.flatten
      fs_list.each do |fs|
        credential_list += get_credentials(fs, true)
      end
    end
    credential_list
  end

  def credential(fs, ct, fs_added_list)
    hsh = {"field_staff" => fs.full_name, "title" => title(fs), "agency_name" => agency_name(fs),
           "Credential" => ct.ct_description, "user_type" => fs.user_type}
    hsh
  end

  def to_pdf(report_file = "credentials_summary", directory = "fs_credentials")
    file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/#{directory}/#{report_file}.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end


  def combined_reports
    pdfs = []
    pdfs << self.to_pdf
    pdfs << to_pdf("credentials_detail_individual_fs") unless org.field_staffs.blank?
    pdfs << to_pdf("credentials_detail_staffing_company")
    combined_pdf_file = "#{tempfile}.pdf"
    require 'pdf_merger'
    PdfMerger.new.merge(pdfs, combined_pdf_file)
    combined_pdf_file
  end

  def org
    Org.current
  end

  def office_staff_name
    org.office_staff_name
  end

  def credential_generation_date
    Date.current.strftime("%m/%d/%Y")
  end

  def address_string
    org.address_string
  end


  def to_xml(options={})
    list = { office_staff_name: office_staff_name,
             credential_generation_date: credential_generation_date,
             contact_details: contact_details,
             to_s: org_name,
             address_string: address_string,
             field_staff_credentials: field_staff_credentials,
             staffing_company_credentials: staffing_company_credentials,
             individual_fs_credentials: individual_fs_credentials
           }
    list.to_xml(root: "health_agency")

  end
end