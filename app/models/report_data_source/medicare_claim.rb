module ReportDataSource
  class MedicareClaim

    include ReportRelatedBasicMethods
    attr_accessor :invoice, :invoice_details

    REPORT_METHODS = ["agency_name", "agency_suite_number_street_address", "agency_city_state_zip", "agency_phone_number",
                      "agency_fax_number", "payer_name", "total_amount", "invoice_date_display", "patient_name",
                      "patient_address", "patient_dob", "patient_gender", "soc_date", "patient_reference",
                      "receivables", "diagnosis_and_procedure_qualifier", "icd_9_1", "icd_9_2", "icd_9_3", "icd_9_4",
                      "icd_9_5", "icd_9_6", "icd_9_7", "icd_9_8", "icd_9_9", "patient_city", "patient_state", "patient_zip_code",
                      "primary_physician_first_name", "primary_physician_last_name", "primary_physician_npi", "fed_tax_number",
                      "agency_npi", "src", "statement_covers_period_from", "statement_covers_period_through", "provider_number",
                      "patient_control_number", "medical_record_number", "status_of_discharge", "medicare_number",
                      "value_codes", "prior_payment", "patient_relationship", "treatment_authorization_codes",
                      "invoice_type_display", "payer_address", "payer_contact", "payer_details", "transfer_from_hha",
                      "release_of_info", "assignment_benefit_cert", "code_code_field", "provider_taxonomy_code", "pt_value_code",
                      "pt_value_code_amount", "ot_value_code", "ot_value_code_amount", "st_value_code", "st_value_code_amount",
                      "sn_value_code", "sn_value_code_amount", "chha_value_code", "chha_value_code_amount", "patient_identifier",
                      "priority_of_visit", "agency_building_name"
    ]

    def initialize(invoice)
      @invoice = invoice
      @invoice_details = generate_medicare_claim
    end

    def generate_medicare_claim
      invoice.receivables_for_print = true
      data = {}
      data[:agency_name] = invoice.agency_name
      data[:agency_suite_number_street_address] = invoice.agency_suite_number_street_address
      data[:agency_city_state_zip] = invoice.agency_city_state_zip
      data[:agency_phone_number] = invoice.agency_phone_number
      data[:agency_fax_number] = invoice.agency_fax_number
      data[:payer_name] = invoice.payer_name
      data[:total_amount] = invoice.total_amount
      data[:invoice_date_display] = invoice.invoice_date_display
      data[:patient_name] = invoice.patient_name
      data[:patient_address] = invoice.patient_address
      data[:patient_dob] = invoice.patient_dob
      data[:patient_gender] = invoice.patient_gender
      data[:soc_date] = invoice.soc_date
      data[:patient_reference] = invoice.patient_reference
      data[:receivables] = invoice.receivables
      data[:diagnosis_and_procedure_qualifier] = invoice.diagnosis_and_procedure_qualifier
      data[:icd_9_1] = invoice.icd_9_1
      data[:icd_9_2] = invoice.icd_9_2
      data[:icd_9_3] = invoice.icd_9_3
      data[:icd_9_4] = invoice.icd_9_4
      data[:icd_9_5] = invoice.icd_9_5
      data[:icd_9_6] = invoice.icd_9_6
      data[:icd_9_7] = invoice.icd_9_7
      data[:icd_9_8] = invoice.icd_9_8
      data[:icd_9_9] = invoice.icd_9_9
      data[:patient_city] = invoice.patient_city
      data[:patient_state] = invoice.patient_state
      data[:patient_zip_code] = invoice.patient_zip_code
      data[:primary_physician_first_name] = invoice.primary_physician_first_name
      data[:primary_physician_last_name] = invoice.primary_physician_last_name
      data[:primary_physician_npi] = invoice.primary_physician_npi
      data[:fed_tax_number] = invoice.fed_tax_number
      data[:agency_npi] = invoice.agency_npi
      data[:src] = invoice.src
      data[:statement_covers_period_from] = invoice.statement_covers_period_from
      data[:statement_covers_period_through] = invoice.statement_covers_period_through
      data[:provider_number] = invoice.provider_number
      data[:patient_control_number] = invoice.patient_control_number
      data[:medical_record_number] = invoice.medical_record_number
      data[:status_of_discharge] = invoice.status_of_discharge
      data[:medicare_number] = invoice.medicare_number
      data[:value_codes] = invoice.value_codes
      data[:prior_payment] = invoice.prior_payment
      data[:patient_relationship] = invoice.patient_relationship
      data[:treatment_authorization_codes] = invoice.treatment_authorization_codes
      data[:invoice_type_display] = invoice.invoice_type_display
      data[:payer_address] = invoice.payer_address
      data[:payer_contact] = invoice.payer_contact
      data[:payer_details] = invoice.payer_details
      data[:transfer_from_hha] = invoice.transfer_from_hha
      data[:release_of_info] = 'Y'
      data[:assignment_benefit_cert] = 'Y'
      data[:code_code_field] = "B3"
      data[:provider_taxonomy_code] = "251E00000X"
      data[:pt_value_code] = "50"
      data[:pt_value_code_amount] = invoice.pt_value_code_amount
      data[:ot_value_code] = "51"
      data[:ot_value_code_amount] = invoice.ot_value_code_amount
      data[:st_value_code] = "52"
      data[:st_value_code_amount] = invoice.st_value_code_amount
      data[:sn_value_code] = "56"
      data[:sn_value_code_amount] = invoice.sn_value_code_amount
      data[:chha_value_code] = "57"
      data[:chha_value_code_amount] = invoice.chha_value_code_amount
      data[:patient_identifier] = nil
      data[:priority_of_visit] = invoice.priority_of_visit
      data[:agency_building_name] = invoice.org.building_name
      data
    end

    def jasper_report_url
      "#{Rails.root}/app/views/reports/invoice/invoice.jasper"
    end

    def jasper_without_border_url
      "#{Rails.root}/app/views/reports/invoice/invoice_wob.jasper"
    end

    def xml_root
      "invoice"
    end

    def pdf_options
      {methods: @invoice_details}
    end

    def to_xml(options = {})
      list = {}
      list.merge!(options[:methods] || {})
      list.to_xml(:root => xml_root)
    end

    def self.combine_selected_invoices(list)
      pdfs = list.collect do |inv|
        data_source = self.new(inv)
        data_source.to_pdf
      end
      combined_pdf_file = "#{tempfile}.pdf"
      require 'pdf_merger'
      PdfMerger.new.merge(pdfs, combined_pdf_file)
      combined_pdf_file
    end


    def to_pdf(flag=true)
      options = {}
      options.merge!(pdf_options) if self.respond_to?(:pdf_options)
      report_url = flag.present? ? jasper_report_url : jasper_without_border_url
      file_content =  Jasper::Rails.render_pdf(report_url, self, {}, options)
      file = File.open(tempfile, "w")
      file.binmode
      file.write(file_content)
      file.close
      File.absolute_path(file)
    end

  end
end