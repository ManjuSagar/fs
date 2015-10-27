require 'jasper-rails'
require 'tempfile'

class TherapyReevaluation
  include JasperRails
  include ReportRelatedBasicMethods

  def display_therapy_reevaluation_info(options)

    treatment_arr = []
    treatments = PatientTreatment.org_scope.includes(:patient).where({:treatment_status => options[:treatment_status_arr]}).
                    order("users.last_name", "users.first_name")

    if options[:patient_id]
      treatments = treatments.includes(:patient).where({:users => {:id => options[:patient_id]}})
    end

    if options[:field_staff_id]
      treatments = treatments.includes(:treatment_staffs).where(
          {:treatment_staffs => {:staff_type => "User", :staff_id => options[:field_staff_id]}})
    end

    if options[:staffing_company_id]
      treatments = treatments.includes(:treatment_staffs).where(
          {:treatment_staffs => {:staff_type => "Org", :staff_id => options[:staffing_company_id]}})
    end

    treatments.each do |treatment|
      soc_date = treatment.treatment_start_date.strftime("%m/%d/%Y")
      patient = treatment.patient
      patient_full_name_with_mr = "#{patient.last_name}, #{patient.first_name} <b>MR</b> #{patient.patient_reference}"
      episodes = treatment.treatment_episodes.order("start_date ASC")
      episodes.each do |episode|

        episode_disciplines = episode.disciplines.where(:discipline_code => ["PT", "OT", "ST"])
        disciplines_ids = episode_disciplines.map(&:id)
        treatment_disciplines = episode.treatment_disciplines.includes(:discipline).where("disciplines.discipline_code IN ('PT','OT','ST')")
        episode_completed_theraphy_visits = episode.treatment_visits.where(:discipline_id => disciplines_ids)

        if options[:field_staff_id]
          treatment_disciplines = treatment_disciplines.includes({:treatment => :treatment_staffs}).where(
              {:treatment_staffs => {:staff_type => "User", :staff_id => options[:field_staff_id]}})
        end

        if options[:staffing_company_id]
          treatment_disciplines = treatment_disciplines.includes({:treatment => :treatment_staffs}).where(
              {:treatment_staffs => {:staff_type => "Org", :staff_id => options[:staffing_company_id]}})
        end

        sorted_treatment_disciplines = treatment_disciplines.sort_by{|s| s.discipline[:sort_order]}
        sorted_treatment_disciplines.each do  |treatment_discipline|
          discipline = treatment_discipline.discipline
          discipline_code = discipline.discipline_code
          discipline_status =  PatientTreatment::STATUS_DISPLAY[treatment_discipline.treatment_status]

          discipline_frequencies = episode.visit_frequencies.where(:discipline_id => discipline.id)
          scheduled_visits = 0
          discipline_frequencies.each do |discipline_frequency|
            unit_count = discipline_frequency.unit_count
            visits_per_unit = discipline_frequency.visits_per_unit
            scheduled_visits += unit_count * visits_per_unit
          end

          treatment_staffs = treatment.treatment_staffs.where(:discipline_id => discipline.id).uniq_by{|s| s.staff}
          treatment_staffs.each do |treatment_staff|
            is_staffing_company = treatment_staff.staff.is_a? StaffingCompany

            next if treatment_staff.staff.nil?
            staff_phone_number = treatment_staff.staff.phone_number
            staff_type, staff_full_name = if is_staffing_company
                                            [treatment_staff.staff.full_name, " "]
                                          else
                                            ["Direct Staff", treatment_staff.staff.full_name]
                                          end
            last_visit_date = "NA"

            if !episode.treatment_visits.empty?
              staff_last_visit = episode.treatment_visits.where(:visited_staff_id => treatment_staff.staff_id,
                                                                :visited_staff_type => treatment_staff.staff_type,
                                                                :discipline_id => discipline.id).last
              staff_full_name, last_visit_date, last_visit_type = if staff_last_visit.present?
                                                                    visit_type = staff_last_visit.visit_type
                                                                    [staff_last_visit.visited_user.full_name, staff_last_visit.visit_start_time.strftime("%m/%d/%Y"),
                                                                     (visit_type ? visit_type.visit_type_code : "")]
                                                                  else
                                                                    name = is_staffing_company ? " " :  treatment_staff.staff.full_name
                                                                    [name, "NA" , " "]
                                                                  end

            end
            treatment_discipline_visits = episode.treatment_visits.where(:discipline_id => discipline.id)
            eval_visits = treatment_discipline_visits.select{|v| v.visit_type.visit_type_code.downcase.include? "eval"}
            last_eval = eval_visits.sort_by!{|v| v.visit_start_time}.last
            last_eval_date =  if last_eval
                                last_eval.visit_date_display
                              else
                                "NA"
                              end
            if (last_eval_date!= "NA")
              parsed_last_eval_date = Date.strptime(last_eval_date, "%m/%d/%Y")
              days_since_last_eval = (Date.current - parsed_last_eval_date).to_i
            else
              days_since_last_eval = "NA"
            end
            oasis_theraphy_visits_count = episode.valid_oasis_doc ? episode.valid_oasis_doc.m2200_ther_need_nbr.to_i.to_s : "NA"

            treatment_arr << {field_staff_name_and_license_type: staff_full_name, phone_number: staff_phone_number,
                              staff_type: staff_type, visit_type: last_visit_type, visit_date: last_visit_date,
                              patient_name_and_mr_number: patient_full_name_with_mr ,
                              patient_home_number: patient.phone_number_2, patient_phone_number: patient.phone_number,
                              certification_period: episode.certification_period_mmddyyyy, soc_date: soc_date,
                              treatment_status: PatientTreatment::STATUS_DISPLAY[treatment.treatment_status],
                              episode_theraphy_visits_completed: episode_completed_theraphy_visits.count,
                              discipline_visits_completed: treatment_discipline_visits.count, scheduled_visits: scheduled_visits,
                              discipline_and_status: "#{discipline_code} - #{discipline_status.to_s}",
                              last_eval_date: last_eval_date, days_since_last_eval: days_since_last_eval,
                              oasis_theraphy_visits_count: oasis_theraphy_visits_count }

          end
        end
      end
    end
    treatment_arr
  end

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/theraphy_re_evaluation/theraphy_re_evaluation.jasper"
  end

  def xml_root
    "theraphy_re_evaluation"
  end
end