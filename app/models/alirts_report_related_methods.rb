require 'jasper-rails'
require 'tempfile'

module AlirtsReportRelatedMethods
  include JasperRails

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/alirts/alirits_report.jasper"
  end

  def xml_root
    "alirts"
  end

  def to_pdf
    file_content =  Jasper::Rails.render_pdf(jasper_report_url, self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def to_xml(options = {})
    non_covered_visits, total_visits = non_covered_excess_visits
    list = {sub_report_url: "#{Rails.root}/app/views/reports/alirts/"}
    list.merge!({agency_name: agency_name_only})
    list.merge!({current_date: current_date})
    list.merge!({current_time: current_time})
    list.merge!({agency_street_address: agency_street_address})
    list.merge!({agency_suite_number: agency_suite_number})
    list.merge!({agency_city_state_phone: agency_city_state_phone})
    list.merge!({fiscal_period_from_date: fiscal_period_from_date})
    list.merge!({fiscal_period_to_date: fiscal_period_to_date})
    list.merge!({:patients => non_covered_visits})
    list.merge!(total_visits)
    list.merge!({patients_and_visits_by_ages: patients_and_visits_by_ages })
    list.merge!({discharge_reasons: discharge_reasons })
    list.merge!({primary_source_of_payments: primary_source_of_payments})
    list.merge!({discipline_visits: discipline_visits})
    list.merge!({source_of_referral_admissions: source_of_referral_admissions})
    list.merge!({patient_and_visits_by_icd_codes: patient_and_visits_by_icd_codes})
    list.merge!({patient_and_visits_by_hiv_alzeimers: patient_and_visits_by_hiv_alzeimers})
    list.to_xml(:root => xml_root)
  end

  def fiscal_period_from_date
    @date.beginning_of_year.strftime('%m-%d-%Y')
  end

  def fiscal_period_to_date
    @date.end_of_year.strftime('%m-%d-%Y')
  end

  def org
    Org.current
  end

  def agency_name_only
    org.org_name
  end

  def agency_street_address
    list = []
    list << org.street_address unless org.street_address.blank?
    list << "Suite " + org.suite_number unless org.suite_number.blank?
    list.join(",")
  end

  def agency_suite_number
    "Suite " + org.suite_number unless org.suite_number.blank?
  end

  def agency_city_state_phone
    city = org.city unless org.city.blank?
    state = org.state
    phone_number = org.phone_number unless org.phone_number.blank?
    "#{city} #{state}, #{phone_number}"
  end

  def current_date
    Date.current.strftime("%m/%d/%Y")
  end

  def current_time
    Time.now.in_time_zone.strftime("%I:%M:%S %p")
  end

end