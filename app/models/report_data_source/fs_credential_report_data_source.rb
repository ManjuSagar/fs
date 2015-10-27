require 'jasper-rails'
require 'tempfile'
module ReportDataSource
  class FsCredentialReportDataSource
  include JasperRails
  attr_accessor :field_staff, :credentials

  def initialize(field_staff)
    @field_staff = field_staff
    @credentials = field_staff.credentials
  end

  def credential_details
    fs_credentials = []
    image_credentials.each do |x|
      fs_credentials << {credential_path: x.attachment.path}
    end
      fs_credentials
  end

  def image_credentials
    credentials - pdf_credentials
  end

  def pdf_credentials
    credentials.select{|x| (File.extname(x.attachment.path) == ".pdf")}
  end

  def jasper_report_url
    "#{Rails.root}/app/views/reports/field_staff_credentials/field_staff_credentials.jasper"
  end

  def xml_root
    "fs_credential"
  end

  def to_xml(options = {})
    list = {}
    list.merge!({credentials: credential_details})
    list.to_xml(:root => xml_root)
  end


  def to_pdf(options = {})
    file_content =  Jasper::Rails.render_pdf(jasper_report_url, self, {}, options)
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def combined_reports
    if credentials.empty?
      false
    else
      pdfs = []
      pdfs << self.to_pdf unless image_credentials.empty?
      pdf_credentials.each do |x|
        pdfs << x.attachment.path
      end
      combined_pdf_file = "#{tempfile}.pdf"
      require 'pdf_merger'
      PdfMerger.new.merge(pdfs, combined_pdf_file)
      combined_pdf_file
    end
  end

end
end