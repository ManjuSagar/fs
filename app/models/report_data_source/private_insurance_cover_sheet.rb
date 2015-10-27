module ReportDataSource
  class PrivateInsuranceCoverSheet
    include ReportRelatedBasicMethods
    attr_accessor :insurance, :line_items, :package_count, :action, :invoice_no

    def initialize(insurance_company, receivables, package_count, action)
        package = insurance_company.last
       @insurance = insurance_company.first
       @line_items = receivables
       @package_count = package_count
       @invoice_no = package.present? ? package.package_number : ' '
       @action = action
    end

    def org
      line_items.first.treatment.health_agency
    end


    def jasper_report_url
      "#{Rails.root.to_s}/app/views/reports/private_insurance/private_insurance_cover_sheet_and_summary_page.jasper"
    end

    def agency_phone
      "Phone: #{org.phone_number}" if org.phone_number.present?
    end

    def agency_fax
      "Fax: #{org.fax_number}" if org.fax_number.present?
    end

    def ins_name
      insurance.to_s
    end

    def ins_address
      address = ""
      address = insurance.claim_street_address unless insurance.claim_street_address.blank?
      address += " Suite #{insurance.claim_suite_number}" unless insurance.claim_suite_number.blank?
      address
    end


    def ins_city_details
      "#{insurance.claim_city}, #{insurance.claim_state} #{insurance.claim_zip_code}"
    end

    def ins_fax
      "Fax: #{insurance.claim_phone_number}"
    end

    def ins_phone
      "Phone: #{insurance.claim_phone_number}"
    end

    def pages
      package_count ? package_count + 1 : 1
    end

    def hippa_text
      "The documents in this package contain confidential information that may be legally privileged and protected by federal and state law. This information is intended for use only by the individual to whom it is addressed. The authorized recipient is obligated to maintain the information in a safe, secure, and confidential manner.
      If you are in  possession of this protected health information, and are not the intended recipient, you are hereby notified that any improper disclosure, copying, or distribution of the contents of this information is strictly prohibited. Please notify the owner of this information immediately and arrange for its return or destruction."
    end
    
    def xml_root
      "private_invoice"
    end

    def sent_date
      invoice = @line_items.first.private_insurance_invoice
      invoice.present? ? "<b>Sent Date: </b>#{invoice.sent_date.strftime("%m/%d/%Y")}" : " "
    end

    def package_number
      invoice_no.present? ? invoice_no : ' '
    end


    def agency_name
      org.to_s
    end

    def agency_building_name
      org.building_name
    end

    def pdf_options
      {methods: {agency_name: agency_name, agency_phone: agency_phone, agency_fax: agency_fax,
                 ins_name: ins_name, ins_address: ins_address, ins_city_details: ins_city_details,
                 ins_fax: ins_fax, ins_phone: ins_phone, pages: pages, hippa_text: hippa_text,
                 package_number: package_number, sent_date: sent_date,
                 receivables: receivables_display, agency_building_name: agency_building_name,
                 }}
    end

    def receivables_display
      result = []
      receivables = if line_items.first.invoice_package.present?
                      package_ids = InvoicePackage.org_scope.where(package_number: invoice_no, insurance_company_id: insurance.id).map(&:id)
                      PrivateReceivable.org_scope.where(["invoice_package_id in (?)", package_ids])
                    else
                      line_items
                    end
      receivables.each do |x|
        visit = x.source
        result << {patient_name: x.treatment.to_s, field_staff_name: visit.visited_staff.full_name,
                        visit_type: visit.visit_type.visit_type_code, visit_date: x.receivable_date.strftime("%m/%d/%y"),
                        hcpcs_code: x.hcpcs_code, billed_amount: x.total_amount, received_amount: x.received_amount,
                        balance: x.balance_amount
        }
      end
      result
    end
 end
end
