require 'jasper-rails'
require 'tempfile'

class RcDcPlanReportDataSource

  attr_accessor :treatment_status_arr, :filter_by, :from_date, :to_date, :case_manager, :rc_episodes

  include JasperRails
  include ReportRelatedBasicMethods

  def initialize params
    assign_filters(params)
  end

  def assign_filters(params)
    @treatment_status_arr = params[:treatment_status_arr]
    @filter_by = params[:filter_by]
    @from_date = Date.parse(params[:from_date], "%m/%d/%Y") if params[:from_date]
    @to_date = Date.parse(params[:to_date], "%m/%d/%Y") if params[:to_date]
    @case_manager = params[:case_manager]
    @rc_episodes = collect_episodes
  end

  def episode_empty?
    rc_episodes.empty?
  end

  def collect_episodes
    episodes_info = []
    rc_episodes = TreatmentEpisode.treatments_latest_episode.includes(:treatment).
                        where({patient_treatments: {treatment_status: treatment_status_arr}}).order("end_date ASC")

    calculated_from_date, calculated_to_date = collect_from_and_to_dates
    @calculated_from_date, @calculated_to_date = format_date(calculated_from_date), format_date(calculated_to_date)

    rc_episodes = rc_episodes.where(["end_date between ? and ?", @calculated_from_date, @calculated_to_date])
    filtered_rc_episodes, field_staff = rc_episodes_filtered_based_on_staff_type(rc_episodes)

    filtered_rc_episodes.each do |episode|
        oasis_field_staff = latest_oasis_field_staff(episode)
        next if oasis_field_staff.nil? or (field_staff.present? and oasis_field_staff != field_staff)
        case_manager_with_phone_number = field_staff_and_phone_number(oasis_field_staff)
        case_manager = oasis_field_staff.to_s
        next if case_manager.nil?
        episodes_info  << collect_episode_details(episode, case_manager, case_manager_with_phone_number)
      end
    episodes_info.sort_by {|episode| [episode[:case_manager].downcase, episode[:soc_date]]}
  end

  def collect_episode_details(episode,case_manager, case_manager_with_phone_number)
    patient = episode.treatment_patient
    primary_physician = "MD #{patient.primary_physician.to_s}"
    sorted_treatment_disciplines = episode.treatment_disciplines.sort_by{|s| s.discipline[:sort_order]}
    discipline_with_visits_count = discipline_with_visits_count(sorted_treatment_disciplines, episode)
    {
         patient_name_and_mr_number: patient.full_name_with_mr_num_first_name_first,
         patient_home_number: patient.phone_number_2,
         patient_mobile_number: patient.phone_number,
         patient_address: patient.patient_address,
         episode: episode.certification_period_mmddyyyy,
         five_days_window: episode.five_days_window,
         primary_physician: primary_physician,
         physician_phone_number: patient.primary_physician_phone_number,
         visits: discipline_with_visits_count,
         case_manager_with_phone_number: case_manager_with_phone_number,
         case_manager: case_manager,
         soc_date: episode.treatment_soc_date,
         date_range_statement: filter_statement_by_case_manager
    }
  end

  def rc_episodes_filtered_based_on_staff_type(rc_episodes)
    field_staff = nil
    if case_manager
      staff_type = "User"
      staff_class, staff_id = case_manager.split("_")
      field_staff = User.find(staff_id) if staff_id
      if staff_class == "LiteFieldStaff"
        staff_type = "Org"
        staff_id = LiteFieldStaff.find(staff_id).staffing_companies.last.id
      end
      rc_episodes = rc_episodes.includes(:treatment => :treatment_staffs).
          where({:treatment_staffs => {staff_type: staff_type, :staff_id => staff_id}})
    end
    [rc_episodes, field_staff]
  end

  def total_rc_dc
    if case_manager.present?
      @rc_episodes.size.to_s.center(60)
    else
      res = @rc_episodes.group_by { |d| d[:case_manager] }
      str = ""
      res.each{|k, v|
        str += "#{k} - #{v.size}\n"
      }
      str
    end
  end

  def filter_statement_by_case_manager
    if case_manager.present?
      date_range_statement
    else
      date_range_statement + " - Filter By Case Manager"
    end
  end

  def date_range_statement
    "Episode End Date from #{@calculated_from_date} to #{@calculated_to_date}"
  end

  def collect_from_and_to_dates
    current_date = Date.current
    case filter_by
      when "CM"
        [current_date.at_beginning_of_month, current_date.at_end_of_month]
      when "PM"
        [current_date.at_beginning_of_month - 1.month, current_date.at_end_of_month - 1.month]
      when "NM"
        [current_date.at_beginning_of_month + 1.month, current_date.at_end_of_month + 1.month]
      when "CU"
        [from_date, to_date]
      else
        raise "Unknown Filter by Option (#{filter_by}) in RC DC Plan Report DataSource"
    end
  end

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/rc_dc_planning/rc_dc_planning.jasper"
  end

  def xml_root
    "rc_dc_plans"
  end

  def discipline_with_visits_count(sorted_treatment_disciplines, episode)
    sorted_treatment_disciplines.
        collect{|treatment_discipline| collect_discipline_with_visits_count(treatment_discipline, episode)}.join(" ")
  end

  def collect_discipline_with_visits_count(treatment_discipline, episode)
    discipline = treatment_discipline.discipline
    discipline_total_visits = episode.treatment_visits.where(:discipline_id => discipline.id).size
    "#{discipline.discipline_code} - #{discipline_total_visits}"
  end

  def latest_oasis_field_staff(episode)
    oasis_document = episode.documents.order("document_date DESC").detect{|d| Document::OASIS_DOCUMENTS.include?(d.class.name) }
    oasis_document.field_staff if oasis_document
  end

  def field_staff_and_phone_number(field_staff)
    "CM #{field_staff.to_s} #{field_staff.phone_number}"
  end

  def pdf_options
    {methods: {plans: @rc_episodes, total_rc_dc: total_rc_dc}}
  end

  def format_date(date)
    date.strftime("%m/%d/%Y")
  end
end