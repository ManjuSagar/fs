module ReportDataSource
  class VisitListReport

    include ReportRelatedBasicMethods

    attr_accessor :visits, :filters

    def initialize(params)
      @filters = params
      filters[:disciplines].select!{|d| d.blank? == false }
      filters[:visit_status].select!{|v| v.blank? == false }
      @visits = collect_visits
    end

    def collect_visits
      treatment_visits = get_filtered_visits

      list = []
      treatment_visits.each do |visit|
        list << collect_visit_details(visit)
      end

      list.sort_by{|x| [x[:visit_date], x[:field_staff_last_name], x[:field_staff_first_name], x[:visit_start_time],
                        x[:visit_end_time], x[:patient_last_name], x[:patient_first_name]] }
    end

    def get_filtered_visits
      actual_visits + scheduled_visits
    end

    def scheduled_visits
      return [] if (filters[:visit_status].include?("Scheduled") == false and filters[:visit_status].size > 0)
      res = ScheduledVisit.not_visited.includes(:treatment).
          where(["patient_treatments.treatment_status IN (?) AND (DATE(scheduled_visits.scheduled_date) BETWEEN ? AND ?)",
                 filters[:treatment_status_filter], filters[:from_date], filters[:to_date]])
      if filters[:disciplines].size > 0
        res = res.includes(:visit_type).where(["visit_types.discipline_id IN (?)", filters[:disciplines]])
      end
      if filters[:patient_id].blank? == false
        res = res.includes(:treatment => :patient).where(["users.id = (?)", filters[:patient_id]])
      end
      if filters[:field_staff_id].blank? == false
        res = res.where(["scheduled_visits.field_staff_id = (?)", filters[:field_staff_id]])
      end
      if filters[:insurance_company_id].blank? == false
        res = res.includes({:treatment => :treatment_request}).where(["treatment_requests.insurance_company_id = (?)", filters[:insurance_company_id]])
      end
      if filters[:visit_type_id].blank? == false
        res = res.where(["scheduled_visits.visit_type_id = (?)", filters[:visit_type_id]])
      end
      res
    end

    def actual_visits
      v_status = []
      filters[:visit_status].each do |vs|
        v_status += ['D', 'S', 'P', 'F'] if vs == "Pending"
        v_status << 'C' if vs == "Completed"
      end
      return [] if (v_status.empty? and filters[:visit_status].size > 0)
      res = TreatmentVisit.org_scope.includes(:treatment).
          where(["patient_treatments.treatment_status IN (?) AND (DATE(treatment_visits.visit_start_time) BETWEEN ? AND ?) AND treatment_visits.draft_status = ?",
                 filters[:treatment_status_filter], filters[:from_date], filters[:to_date], false])

      if filters[:disciplines].size > 0
        res = res.where(["treatment_visits.discipline_id IN (?)", filters[:disciplines]])
      end
      if v_status.size > 0
        res = res.where(["treatment_visits.visit_status IN (?)", v_status])
      end
      if filters[:patient_id].blank? == false
        res = res.includes(:treatment => :patient).where(["users.id = (?)", filters[:patient_id]])
      end
      if filters[:field_staff_id].blank? == false
        res = res.where(["treatment_visits.visited_user_id = (?)", filters[:field_staff_id]])
      end
      if filters[:insurance_company_id].blank? == false
        res = res.includes({:treatment => :treatment_request}).where(["treatment_requests.insurance_company_id = (?)", filters[:insurance_company_id]])
      end
      if filters[:visit_type_id].blank? == false
        res = res.where(["treatment_visits.visit_type_id = (?)", filters[:visit_type_id]])
      end
      res
    end

    def collect_visit_details(visit)
      data = {}
      patient = visit.treatment.patient
      date = field_staff = visit_status = start_time = end_time = nil
      if visit.is_a? ScheduledVisit
        date = visit.scheduled_date
        field_staff = visit.field_staff
        visit_status = "Scheduled"
        start_time = visit.start_time.size > 0 ?  visit.start_time.insert(2, ':') : ""
        end_time = visit.end_time.size > 0 ?  visit.end_time.insert(2, ':') : ""
      else
        date = visit.visit_date
        field_staff = visit.visited_user
        visit_status = visit.completed? ? "Completed" : "Pending"
        start_time = visit.visit_start_time.strftime("%H:%M")
        end_time = visit.visit_end_time.strftime("%H:%M")
      end
      data[:visit_date] = date
      data[:formatted_visit_date] = date.strftime("%A, %B %d, %Y")
      data[:field_staff_name] = field_staff_name(field_staff)
      data[:patient_name_mr_phone_number] = patient_name_mr_phone_number(patient)
      data[:visit_type] = "#{visit.visit_type}"
      data[:visit_status] = visit_status
      data[:visit_start_time] = start_time
      data[:visit_end_time] = end_time

      #For sorting purpose
      data[:field_staff_last_name] = field_staff.last_name
      data[:field_staff_first_name] = field_staff.first_name
      data[:patient_last_name] = patient.last_name
      data[:patient_first_name] = patient.first_name
      data
    end

    def filtered_dates
      "<b>Visit List </b>#{filters[:from_date]} - #{filters[:to_date]}"
    end

    def filtered_by
      str = "<b>Filtered by: </b>"
      str_arr = []
      disciplines = filters[:disciplines].collect{|x| Discipline.find(x).discipline_code }
      status = filters[:treatment_status_filter].select{|v| v.blank? == false }.collect{|v| Hash[*PatientTreatment::COMBO_STORE_DISPLAY.flatten][v] }

      if filters[:patient_id].blank? == false
        str_arr << "Patient (#{Patient.org_scope.find(filters[:patient_id])})"
      end
      if filters[:treatment_status_filter]
        str_arr << "Patient Status (#{status.join(', ')})"
      end
      if disciplines.size > 0
        str_arr << "Discipline (#{disciplines.join(', ')})"
      end
      if filters[:visit_status].size > 0
        str_arr << "Visit Status (#{filters[:visit_status].join(', ')})"
      end
      if filters[:field_staff_id].blank? == false
        str_arr << "Field Staff (#{FieldStaff.org_scope.find(filters[:field_staff_id])})"
      end
      if filters[:insurance_company_id].blank? == false
        str_arr << "Insurance (#{InsuranceCompany.org_scope.find(filters[:insurance_company_id])})"
      end
      if filters[:visit_type_id].blank? == false
        str_arr << "Visit Type (#{VisitType.org_scope.find(filters[:visit_type_id])})"
      end
      (str_arr.size > 0) ? str + str_arr.join(", ") : nil
    end

    def jasper_report_url
      "#{Rails.root}/app/views/reports/visit_list/visit_list.jasper"
    end

    def xml_root
      "visit_list"
    end

    def pdf_options
      {methods: {agency_name_with_phone_number: agency_name_with_phone_number, filtered_dates: filtered_dates,
                 filtered_by: filtered_by, visits: visits}}
    end

  end
end