require 'jasper-rails'
require 'tempfile'

module ReportRelatedBasicMethods
  include JasperRails

  def to_pdf(options = {})
    options.merge!(pdf_options) if self.respond_to?(:pdf_options)
    file_content =  Jasper::Rails.render_pdf(jasper_report_url, self, {}, options)
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

  def field_staff_name(field_staff)
    name = field_staff.full_name
    field_staff.phone_number.present? ? (name + " " + field_staff.phone_number) : name
  end

  def patient_name_mr_phone_number(patient)
    name = patient.full_name + " " + patient.patient_reference
    patient.phone_number.present? ? (name + " " + patient.phone_number) : name
  end

  def to_xml(options = {})
    list = {}
    list.merge!(agency_name: agency_name_with_phone_number)
    list.merge!(agency_name_only: agency_name_only)
    list.merge!(agency_address)
    list.merge!(agency_city_details)
    list.merge!(agency_contact)
    list.merge!(options[:methods] || {})
    list.to_xml(:root => xml_root)
  end

  def agency_name_only
    org.org_name
  end

  def org
    Org.current
  end

  def agency_address
    address = ""
    address = org.street_address unless org.street_address.blank?
    address += " Suite #{org.suite_number}" unless org.suite_number.blank?
    address
    {agency_address_line1: address}
  end

  def agency_city_details
    {agency_address_line2: "#{org.city}, #{org.state} #{org.zip_code}"}
  end

  def agency_contact
    contact = ""
    contact = "<b>Tel</b> #{org.phone_number}" if org.phone_number.present?
    contact += ", " if org.phone_number && org.fax_number
    contact += "<b>Fax</b> #{org.fax_number}" if org.fax_number.present?
    contact
    {agency_contact: contact}
  end
end