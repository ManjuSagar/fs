require 'jasper-rails'
require 'tempfile'


class MissingFrequencyReportDataSource

  include JasperRails
  include ReportRelatedBasicMethods

  def collect_missing_frequencies(options)
    treatment_arr = []
    treatments = PatientTreatment.org_scope.includes(:patient).where({:treatment_status => options[:treatment_status_arr]}).
                    order("users.last_name", "users.first_name")

    treatments = treatment_filter_based_on_options(options, treatments)

    treatments.each do |treatment|
      episodes = treatment.treatment_episodes
        episodes.each do |episode|
          treatment_disciplines = treatment_disciplines_filter_based_on_options(episode, options)

          sorted_treatment_disciplines = treatment_disciplines.sort_by{|s| s.discipline[:sort_order]}

          sorted_treatment_disciplines.each do |treatment_discipline|
            discipline = treatment_discipline.discipline
            next if episode.visit_frequencies.where(:discipline_id => discipline.id).count > 0

            treatment_staffs = treatment.treatment_staffs.where(:discipline_id => discipline.id).uniq_by{|s| s.staff}
            treatment_staffs.each do |treatment_staff|
              next if treatment_staff.staff.nil?

              treatment_arr << collect_treatment_details({treatment: treatment, episode: episode,
                                                          treatment_staff: treatment_staff, discipline: discipline,
                                                          treatment_discipline: treatment_discipline})
            end
          end
        end
    end
    treatment_arr
  end

  def collect_treatment_details(params)
    is_staffing_company = params[:treatment_staff].staff.is_a? StaffingCompany

    episode_disciplines = params[:episode].disciplines
    discipline_total_visits, discipline_code_and_status = collect_discipline_details(params[:discipline], params[:episode], params[:treatment_discipline])
    staff_phone_number, staff_type, staff_full_name, last_visit_date, last_visit_type =
        collect_staff_and_visit_details(params[:treatment_staff], is_staffing_company, params[:episode], params[:discipline])
    patient = params[:treatment].patient
    { soc_date: params[:treatment].soc_date, patient_name_and_mr_number: patient.full_name_with_mr_number,
      field_staff_name_and_license_type: staff_full_name, phone_number: staff_phone_number,
      staff_type: staff_type, visit_type: last_visit_type, visit_date: last_visit_date,
      discipline_code_and_status: discipline_code_and_status, completed_visits: discipline_total_visits,
      certification_period: params[:episode].certification_period_mmddyyyy, total_disciplines: episode_disciplines.join(', '),
      treatment_status: PatientTreatment::STATUS_DISPLAY[params[:treatment].treatment_status],
      patient_home_number: patient.phone_number_2, patient_phone_number: patient.phone_number
    }
  end

  def collect_staff_and_visit_details(treatment_staff, is_staffing_company, episode, discipline)
    staff_phone_number = treatment_staff.staff_phone_number
    staff_type, staff_full_name = if is_staffing_company
                                    [treatment_staff.staff.full_name, " "]
                                  else
                                    ["Direct Staff", treatment_staff.staff.full_name]
                                  end
    last_visit_date = "NA"
    last_visit_type = "NA"
    if !episode.treatment_visits.empty?
      staff_last_visit = episode.treatment_visits.where(:visited_staff_id => treatment_staff.staff_id,
                                                        :visited_staff_type => treatment_staff.staff_type,
                                                        :discipline_id => discipline.id).last
      staff_full_name, last_visit_date, last_visit_type = if staff_last_visit.present?
                                                            visit_type = staff_last_visit.visit_type
                                                            [staff_last_visit.visited_user.full_name, staff_last_visit.visit_start_time.strftime("%m/%d/%Y"),
                                                             (visit_type ? visit_type.visit_type_code : "NA")]
                                                          else
                                                            name = is_staffing_company ? " " :  treatment_staff.staff.full_name
                                                            [name, "NA" , "NA"]
                                                          end
    end
    [staff_phone_number, staff_type, staff_full_name, last_visit_date, last_visit_type]
  end
  def collect_discipline_details(discipline, episode, treatment_discipline)
    discipline_code = discipline.discipline_code
    discipline_total_visits = episode.treatment_visits.where(:discipline_id => discipline.id).size

    discipline_status =  PatientTreatment::STATUS_DISPLAY[treatment_discipline.treatment_status]
    discipline_code_and_status = "#{discipline_code} - #{discipline_status.to_s}"
    [discipline_total_visits, discipline_code_and_status]
  end

  def treatment_filter_based_on_options(options, treatments)
    if options[:patient_id]
      treatments = treatments.includes(:patient).where({:users => {:id => options[:patient_id]}})
    elsif options[:field_staff_id]
      treatments = treatments.includes(:treatment_staffs).where(
          {:treatment_staffs => {:staff_type => "User", :staff_id => options[:field_staff_id]}})
    elsif options[:staffing_company_id]
      treatments = treatments.includes(:treatment_staffs).where(
          {:treatment_staffs => {:staff_type => "Org", :staff_id => options[:staffing_company_id]}})
    end
    treatments
  end

  def treatment_disciplines_filter_based_on_options(episode, options)
    treatment_disciplines = episode.treatment_disciplines
    if options[:field_staff_id]
      treatment_disciplines = treatment_disciplines.includes({:treatment => :treatment_staffs}).where(
          {:treatment_staffs => {:staff_type => "User", :staff_id => options[:field_staff_id]}})
    elsif options[:staffing_company_id]
      treatment_disciplines = treatment_disciplines.includes({:treatment => :treatment_staffs}).where(
          {:treatment_staffs => {:staff_type => "Org", :staff_id => options[:staffing_company_id]}})
    end
    treatment_disciplines
  end

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/missing_frequencies/missing_frequencies.jasper"
  end

  def xml_root
    "missing_frequency"
  end
end