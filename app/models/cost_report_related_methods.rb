require 'jasper-rails'
require 'tempfile'

module CostReportRelatedMethods
  include JasperRails

  def cost_visits_sub_report_url
    "#{Rails.root}/app/views/reports/cost/cost_visit.jasper"
  end

  def msa_sub_report_url
    "#{Rails.root}/app/views/reports/cost/msa.jasper"
  end

  def reimbursement_settlement_url
    "#{Rails.root}/app/views/reports/cost/medicare_reimbursement.jasper"
  end

  def medicare_report_sub_report_url
    "#{Rails.root}/app/views/reports/cost/medicare_report_sub_report.jasper"
  end

  def pps_activity_sub_report_url
    "#{Rails.root}/app/views/reports/cost/pps_activity.jasper"
  end

  def period_covers_from
    period_covers_from_date.strftime("%m/%d/%y")
  end

  def period_covers_to
    period_covers_end_date.strftime("%m/%d/%y")
  end

  def period_covers_from_date
    date.at_beginning_of_year
  end

  def period_covers_end_date
    date.at_end_of_year
  end

  def org
    Org.current
  end

  def agency_provider_number
    org.agency_provider_number
  end

  def period_covers_string
    "Period Covered From #{period_covers_from_date.strftime("%b %d, %Y")} To #{period_covers_end_date.strftime("%b %d, %Y")}" if period_covers_from_date and period_covers_end_date
  end

  def street_address_string
    if org.suite_number
      "STREET: #{org.street_address} Suite #{org.suite_number}"
    else
      "STREET: #{org.street_address}"
    end
  end

  def agency_address_string
    org.agency_address_string + "#{(org.zip_code_part2 if org.zip_code_part2?)}"
  end

  def street_address
    (org.street_address) ? org.street_address : ' '
  end

  def suite_number
    (org.suite_number) ? org.suite_number : ' '
  end

  def city
    (org.city) ? org.city : ' '
  end

  def state
    org.state
  end

  def zip_code
    org.zip_code+"#{(org.zip_code_part2 if org.zip_code_part2?)}"
  end

  def printed_date
    Time.current.strftime("%m/%d/%Y, %H:%M:%S%p")
  end

  def disciplines_for_cost_report
    return @disciplines if defined?(@disciplines)
    @disciplines = Discipline.order('sort_order').all.select{|x| ['SN','PT','OT','MSW','ST','CHHA'].include? x.discipline_code}
  end

  def org_name
   org.to_s
  end

  def get_msa_codes(zip_code)
    zip = get_patient_zip_code(zip_code)
    county_name(zip.admin_name_2, zip.admin_name_1)
  end

  def county_name(county_name, state)
    ProspectivePaymentSystem::MedicareCoreStatArea.where({state_name: state, county_name: county_name, calender_year: year}).first
  end

  def get_patient_zip_code(zip_code)
    ZipCode.where(zip_code: zip_code).first
  end

  def to_pdf
    file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/cost/cost.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end


  def to_xml(options = {})
    list = {street_address: street_address, state: state, suite_number: suite_number, city: city, zip_code: zip_code,
            period_covers_from: period_covers_from, period_covers_to: period_covers_to,
            agency_provider_number: agency_provider_number, cost_visits: cost_visits,
            period_covers_string: period_covers_string, to_s: org_name, street_address_string: street_address_string,
            agency_address_string: agency_address_string, printed_date: printed_date, msa_codes_list: msa_codes_list,
            medicare_services_area_count: medicare_services_area_count, pps_visits: pps_visits,
            cost_visits_sub_report_url: cost_visits_sub_report_url, msa_sub_report_url: msa_sub_report_url,
            pps_activity_sub_report_url: pps_activity_sub_report_url,
            medicare_report_sub_report_url: medicare_report_sub_report_url,
            computation_of_reimbursement_settlement_sub_report_url: reimbursement_settlement_url,
            medicare_cost_and_limitation: treatment_visits_count,
            computation_of_reimbursement_settlement: reimbursement_settlement
    }
    list.to_xml(root: "health_agency")
  end

end
