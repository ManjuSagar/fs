module PayrollReportDataSource
  # include ReportRelatedBasicMethods
  include JasperRails
  def agency_name
    org.to_s if org
  end

  def agency_suite_number_street_address
    agency_street_details + " " + agency_city_details
  end

  def agency_street_details
    street = []
    street << org.street_address unless org.street_address.blank?
    street << "Suite " + org.suite_number unless org.suite_number.blank?
    street.join(", ")
  end

  def agency_city_details
    street = []
    street << org.city unless org.city.blank?
    street << ["#{org.state} #{org.zip_code}"].reject{|x| x.blank?}
    street.join(", ")
  end


  def agency_phone_number
    street = []
    street << "Tel " + org.phone_number unless org.phone_number.blank?
    street << "Fax " + org.fax_number unless org.fax_number.blank?
    street.join(", ")
  end


  def office_staff_name
    office_staff.to_s if office_staff.present?
  end

  def payroll_date_display
    payroll_date.strftime("%m/%d/%Y")
  end

  def fs_credentials
    list = []
    credential_source = CredentialReportDataSource.new
    if staffing_company?
      payable = self.payables.first
      visited_fs = payable.source.visited_user
      list += credential_source.fs_credentials(visited_fs)
    else
      list += credential_source.fs_credentials(payee)
    end
    list
  end

  def field_staff?
    payee.is_a? User
  end

  def staffing_company?
    payee.is_a? StaffingCompany
  end

  def to_xml (options = {})
    super :methods => [:agency_name,
                       :agency_suite_number_street_address,
                       :agency_phone_number,
                       :office_staff_name,
                       :payroll_date_display,
                       :payroll_individual_print,
                       :fs_credentials,
                       :fs_credentials_in_payroll_sub_report_url
    ] +
        xml_tags_based_on_context
  end

  def xml_tags_based_on_context
    if ["field_staff_details","staffing_company_details"].include? (report_context)
      [:payables]
    else
      [:actual_payrolls]
    end
  end

  def to_pdf(report_file = "payroll_summary")
    File.open('ss.txt', 'w'){|p| p.write(to_xml)}
    file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/payroll/#{report_file}.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def fs_credentials_in_payroll_sub_report_url
    "#{Rails.root}/app/views/reports/payroll/credentials_in_payroll_detail_individual_fs_subreport.jasper"
  end

  def payrolls
    self.actual_payroll_ids.collect{|id| Org.current.payrolls.find(id)}
  end

  def fs_payrolls
    payrolls.select{|p| p.field_staff?}
  end

  def sc_payrolls
    payrolls - fs_payrolls
  end

  def payrolls_pdf(payrolls, pdfs)
    payrolls.each do |payroll|
      payroll.report_context = payroll.set_report_context
      pdfs << fs_sc_payroll_pdf(payroll)
    end
    pdfs
  end

  def set_report_context
    (field_staff? ? "field_staff_details" : "staffing_company_details")
  end

  def fs_sc_payroll_pdf(payroll)
    ((payroll.report_context == "field_staff_details") ? payroll.to_pdf("payroll_detail_individual_fs") : payroll.to_pdf("payroll_detail_staffing_company"))
  end


  def combine_payroll_summary_and_individual_details
    pdfs = []
    pdfs << self.to_pdf
    pdfs = payrolls_pdf(fs_payrolls, pdfs)
    pdfs = payrolls_pdf(sc_payrolls, pdfs)
    combined_pdf_file = "#{tempfile}.pdf"
    require 'pdf_merger'
    PdfMerger.new.merge(pdfs, combined_pdf_file)
    combined_pdf_file
  end


  end