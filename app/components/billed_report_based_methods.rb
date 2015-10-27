require 'jasper-rails'
require 'tempfile'

module BilledReportBasedMethods
  include JasperRails

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/billed_claims/billed_claims.jasper"
  end

  def xml_root
    "billed_claims"
  end

  def to_pdf
    file_content =  Jasper::Rails.render_pdf(jasper_report_url, self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def agency_name_with_phone_number
    agency_details = ""
    agency_details = "<b>#{org.org_name}</b>"unless org.org_name.blank?
    agency_details += " Tel #{org.phone_number}" unless org.phone_number.blank?
    agency_details
  end

  def to_xml(options = {})
    list = {sub_report_url: "#{Rails.root}/app/views/reports/billed_claims/"}
    list.merge!(agency_name: agency_name_with_phone_number)
    list.merge!(group_by: @group_by)
    list.merge!({:invoices => @payload})
    list.to_xml(:root => xml_root)
  end

  def org
    Org.current
  end

  def agency_name_only
    org.org_name
  end
end