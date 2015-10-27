class CensusReport
  include ReportRelatedBasicMethods
  attr_accessor :records_for_census_report, :selectd_group, :unduplicated, :filter_name, :filter_value, :icd_code, :date, :patients_icd_cod_not_set,
                :disciplines, :treatment_status_filter, :from_date, :to_date, :date_filter, :total_patients, :footer_print, :filter_value_for_footer,
                :patients_primary_physician_not_set, :agency_start_date
  def set_dates_for_census_report(params)
    self.selectd_group = params[:group_by_md]
    self.unduplicated = params[:unduplicated]
    self.filter_name = params[:selected_filter]
    self.filter_value = params[:selectd_filter_value]
    self.icd_code = params[:icd_code]
    self.date = Date.parse(params[:date_filter], "%m/%d/%Y") if params[:date_filter]
    self.agency_start_date = TreatmentEpisode.org_scope.sort_by{|x| x.start_date}.first.start_date.strftime('%m/%d/%y')
    self.from_date = (Date.parse(params[:from_date], "%m/%d/%Y") if params[:from_date]) || agency_start_date
    self.to_date = (Date.parse(params[:to_date], "%m/%d/%Y") if params[:to_date]) || Date.today.strftime('%m/%d/%y')
    self.date_filter = params[:date_source]
    self.disciplines  = params[:selected_disciplines].values.map { |x| x.to_i }
    self.treatment_status_filter = params[:selected_status].values
    filter = (self.filter_name == "PrimaryDiagnosis" || self.filter_name == "Physician")
    check_filter_or_group_by = (self.selectd_group == "PrimaryDiagnosis" || self.selectd_group == "Physician")
    self.footer_print =  ((self.filter_name.present? and filter) || (self.selectd_group.present? and check_filter_or_group_by))

    self.records_for_census_report = case date_filter
                                       when "SOC"
                                         res = episodes_with_date_range("soc")
                                         episode_record_for_census_report(res)
                                       when "EpisodeEnd"
                                         res = episodes_with_date_range("end_date")
                                         episode_record_for_census_report(res)
                                       when "ActiveDuring"
                                         res = episodes_with_date_range("active_during")
                                         episode_record_for_census_report(res)
                                       when "Discharge"
                                         res = episodes_with_date_range("discharge")
                                         episode_record_for_census_report(res)
                                       else
                                         res = episodes_with_date_range("start_date")
                                         episode_record_for_census_report(res)
                                     end
  end

  def date_filter_not_selected
    self.date_filter.blank?
  end

  def episodes_with_date_range(attr_to_filter)
    res = case attr_to_filter
            when 'start_date'
              TreatmentEpisode.treatments_start_date(from_date, to_date)
            when 'end_date'
              TreatmentEpisode.treatments_end_date(from_date, to_date)
            when 'active_during'
              TreatmentEpisode.active_during(from_date, to_date)
            when 'discharge'
              TreatmentEpisode.discharge_treatments(from_date, to_date)
            when 'soc'
              TreatmentEpisode.treatment_by_soc(from_date, to_date)
          end
    res = (disciplines.present?) ? res.includes(:treatment_disciplines).where("treatment_disciplines.discipline_id in (?)", disciplines) : res
    res = (treatment_status_filter.present?) ? res.includes(:treatment).where(["patient_treatments.treatment_status in (?)", treatment_status_filter]) : res
    filter_treatments(res)
  end

  def filter_treatments(res)
    filter = self.filter_name
    value = self.filter_value
    res = case filter
            when "Physician"
              self.filter_value_for_footer = Physician.find(value).to_s
              res.includes(:treatment => :treatment_physicians).where("physician_id = ?",value)
            when "InsuranceCompany"
              self.filter_value_for_footer = InsuranceCompany.find(value).to_s
              res.includes(:treatment => {:treatment_request=> :insurance_company}).where("insurance_company_id = ?", value)
            when "PrimaryDiagnosis"
              self.filter_value_for_footer = self.icd_code
              check_icd_codes(res, self.icd_code)
            when "FieldStaff"
              self.filter_value_for_footer = value
              self.filter_value_for_footer = FieldStaff.find(value).to_s
              res.includes(:treatment_visits).where("visited_staff_id = ?", value)
            when "Acuity"
              self.filter_value_for_footer = value
              res.includes(:treatment => {:patient => :patient_detail}).where("acuity_level = ?", value)
            when "SOC"
              self.filter_value_for_footer = self.date
              res.where("start_date = ?", self.date)
            else
              res
          end
    res
  end

  def check_icd_codes(episodes, icd_code)
    res = []
    episodes.each do |e|
      primary_diag = patient_details(e, false)
      if primary_diag["icd_code"].present?
        (icd_code == primary_diag["icd"])? res << e : nil
      else
        res << e
      end
    end
    res.uniq
  end

  def patient_details(episode, field_staff_required)
    result = {}
    rap_generated_id = episode.rap_generated_document
    if rap_generated_id.present?
      doc = Document.org_scope.find(rap_generated_id)
      if doc
        result["staff"] = doc.visited_staff_name if field_staff_required
        primary_icd_code = doc.m1020_primary_diag_icd || doc.m1021_primary_diag_icd
        type = (doc.m1020_primary_diag_icd.present?) ? "icd9" : "icd10"
        result["icd"] = primary_icd_code
        (primary_icd_code.present?) ? result["icd_code"] = primary_icd_code + " " + doc.get_icd_code_description(primary_icd_code, type) : result["icd_code"] = ""
      else
        result["icd_code"] = ""
      end
    end
    result
  end

  def episode_record_for_census_report(res)
    patients_list = []
    res = if unduplicated.present?
            treatments = res.collect{|x| x.treatment}
            treatments_order = treatments.sort_by{|x| x.treatment_start_date}.reverse
            patients = treatments_order.collect{|x| x.patient}.uniq
            res = patients.collect do |x|
              x.treatments.last.last_episode
            end
          else
            res
          end
    res.each do |episode|
      treatment = episode.treatment
      physician = treatment.primary_physician
      next unless physician
      patient_acuity = unduplicated.present? ? "" :"<b>Acuity</b> #{treatment.patient.patient_acuity_level}"
      disciplines = unduplicated.present? ? "" :"<b>Disciplines</b> #{episode.census_disciplines_display}"
      soc_date = unduplicated.present? ? "" :"#{treatment.treatment_start_date.strftime("%m/%d/%Y")}"
      certification_period = unduplicated.present? ? "" :episode.certification_period_mmddyyyy
      patient = treatment.patient
      details = patient_details(episode, true)
      activity = treatment.treatment_activities.where(activity_type: 'D').first if treatment.discharged?
      dc_date = (activity.present?)?  activity.activity_date.strftime("%m/%d/%Y") : ""

      patients = {patient_name: treatment.to_s, ptnt_last_name: patient.last_name, ptnt_first_name: patient.first_name,
                  patient_mr_num: patient.patient_reference, patient_cel: patient.phone_number,patient_tel: patient.phone_number_2,
                  patient_address: patient.patient_address,certification_period: certification_period, physician_name: physician.full_name_without_suffix,
                  physcn_first_name: (physician.first_name.present?)? physician.first_name : "", physcn_last_name: physician.physcn_last_name,
                  physician_phone: physician.phone_number, patient_acuity: patient_acuity ,
                  episode_disciplines: disciplines, soc_date: soc_date,
                  treatment_status: treatment.treatment_short_status, insurance: treatment.insurance_company.company_code,
                  case_manager: details["staff"],primary_diagnosis: (details["icd_code"].present?)? details["icd_code"] : "",
                  patient_insurance_number: treatment.insurance_number, dc_date: dc_date}

      case self.selectd_group
        when 'FieldStaff'
          episode.treatment_visits.uniq_by(&:visited_staff_id).each do |visit|
            patients_list << patients.merge!({field_staff: visit.visited_staff_full_name})
          end
        else
          patients_list << patients
      end
    end
    patients_list = add_unduplicated_records(patients_list.uniq)
    final_res = group_records_based_on_selected(patients_list)
    sort_by_filter_if_any(final_res)
  end

  def group_records_based_on_selected(patients_list)
    final_res = case self.selectd_group
                  when 'FieldStaff'
                    patients_list.sort_by! {|patient| [patient[:field_staff],patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                  when 'Acuity'
                    patients_list.sort_by! {|patient| [patient[:patient_acuity],patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                  when 'PrimaryDiagnosis'
                    self.patients_icd_cod_not_set =  patients_list.select{|l| l[:primary_diagnosis] == ""}
                    primary_diag_present = patients_list.select{|l| l[:primary_diagnosis] != ""}
                    primary_diag_present.sort_by!{|patient| [patient[:primary_diagnosis],patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                  when 'InsuranceCompany'
                    patients_list.sort_by! {|patient| [patient[:insurance],patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                  when 'SOC'
                    patients_list.sort_by!{|patient| [patient[:soc_date],patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                  when 'Physician'
                    self.patients_primary_physician_not_set = patients_list.select{|l| l[:physcn_first_name] == ""}
                    primary_physician_set = patients_list.select{|l| l[:physcn_first_name] != ""}
                    primary_physician_set.sort_by! {|patient| [patient[:physcn_first_name],patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                  else
                    patients_list.sort_by! {|patient| [patient[:ptnt_last_name].downcase, patient[:ptnt_first_name].downcase ]}
                end
    final_res
  end

  def sort_by_filter_if_any(final_res)
    case filter_name
      when 'Physician'
        self.patients_primary_physician_not_set = final_res.select{|l| l[:physcn_first_name] == ""}
        primary_physician_set = final_res.select{|l| l[:physcn_first_name] != ""}
        primary_physician_set.sort_by! {|patient| patient[:physcn_first_name]}
      when 'PrimaryDiagnosis'
        self.patients_icd_cod_not_set =  final_res.select{|l| l[:primary_diagnosis] == ""}
        primary_diag_present = final_res.select{|l| l[:primary_diagnosis] != ""}
        primary_diag_present.sort_by!{|patient| patient[:primary_diagnosis]}
      else
        final_res
    end
  end

  def add_unduplicated_records(patients_list)
    date_filter_res = date_filter_not_selected
    res = if unduplicated.present?
            patients_list += pending_evaluation_patients
            patients_list
          else
            patients_list += pending_evaluation_patients if(not treatment_status_filter.include?('N'))
            patients_list += rejected_referrals  if date_filter_res
            patients_list
          end
    self.total_patients = res.size
    res
  end

  def pending_evaluation_patients
    patients_list = []
    referrals_list = []
    if (disciplines.blank? && date_filter.blank?)
      filter = self.filter_name
      value = self.filter_value || self.date
      res = Patient.org_scope.includes(:treatment_requests).where("treatment_requests.patient_id is null and users.draft_status = false")
      patients =  case filter
                    when 'InsuranceCompany'
                      res.includes(:treatment_requests => :insurance_company).where("insurance_company_id = ?", value)
                    when 'Acuity'
                      res.includes(:patient_detail).where("acuity_level = ?", value)
                    when 'SOC'
                      []
                    when 'Physician'
                      []
                    when 'FieldStaff'
                      []
                    when 'PrimaryDiagnosis'
                      []
                    else
                      res.includes(:treatment_requests).where("treatment_requests.patient_id is null and draft_status = false")
                  end

      patients_list = patients.collect{|p|
        patient_acuity = unduplicated.present? ? "" :"<b>Acuity</b> #{p.patient_acuity_level}"
        {patient_name: p.full_name, ptnt_last_name: p.last_name, ptnt_first_name: p.first_name,
         patient_mr_num: p.patient_reference, patient_cel: p.phone_number,
         patient_tel: p.phone_number_2, patient_address: p.patient_address,
         certification_period: "", physician_name: "",
         physcn_first_name: "", physcn_last_name: "",#HACK:: For sorting by MD last_name, first_name null taking first according to Ascii
         physician_phone: "", patient_acuity: patient_acuity,
         episode_disciplines: "", soc_date: (p.soc_date.present?)? p.soc_date : "",
         treatment_status: "PE", patient_status: "physician", insurance:  p.insurance_companies.first.company_code,
         case_manager: "", primary_diagnosis: "", patient_insurance_number: p.medicare_number, dc_date: "", field_staff: ""
        }
      }
    else
      []
    end

    unless (date_filter == 'ActiveDuring' || date_filter == 'Discharge')
      if (date_filter == 'EpisodeEnd')
        patient_requests = TreatmentRequest.pending_referrals.includes(:patient_treatment => :treatment_episodes).where("end_date <= (?)", to_date)
      elsif (date_filter == 'EpisodeStart' || date_filter == "SOC")
        patient_requests = TreatmentRequest.pending_referrals.includes(:patient_treatment => :treatment_episodes).where("start_date >= (?)", from_date)
      else
        patient_requests = TreatmentRequest.pending_referrals.includes(:patient_treatment => :treatment_episodes)
      end
      referrals  = case filter
                     when 'Physician'
                       patient_requests.includes(:patient_treatment => :treatment_physicians).where("physician_id = ?",value)
                     when 'InsuranceCompany'
                       patient_requests.includes(:insurance_company).where("insurance_company_id = ?",value)
                     when 'SOC'
                       patient_requests.includes(:patient_treatment).where("treatment_start_date = ?", self.date)
                     when 'Acuity'
                       patient_requests.includes(:patient => :patient_detail).where("acuity_level = ?", value)
                     when 'FieldStaff'
                       patient_requests.joins(:request_staffs).where("staff_id = ?", value)
                     when 'PrimaryDiagnosis'
                       []
                     else
                       patient_requests
                   end
      (disciplines.present?) ? referrals.joins(:disciplines).where("treatment_disciplines.discipline_id in (?)", disciplines) : referrals
      referrals_list = referrals.collect{|r|
        patient = r.patient
        physician = r.referred_physician
        patient_acuity = unduplicated.present? ? "" :"<b>Acuity</b> #{patient.patient_acuity_level}"
        {patient_name: patient.full_name, ptnt_last_name: patient.last_name, ptnt_first_name: patient.first_name,
         patient_mr_num: patient.patient_reference, patient_cel: patient.phone_number,
         patient_tel: patient.phone_number_2, patient_address: patient.patient_address,
         certification_period: "", physician_name: physician.full_name_without_suffix,
         physcn_first_name: (physician.first_name.present?)? physician.first_name : "", physcn_last_name: physician.last_name,
         physician_phone: physician.phone_number, patient_acuity: patient_acuity,
         episode_disciplines: "", soc_date: (patient.soc_date.present?)? patient.soc_date : "",
         treatment_status: "PE", insurance:  patient.insurance_companies.first.company_code,
         case_manager: "", primary_diagnosis: "", patient_insurance_number: patient.medicare_number, dc_date: "", field_staff: ""
        }
      }
      patients_list + referrals_list
    else
      []
    end
  end

  def rejected_referrals
    filter = self.filter_name
    value = self.filter_value
    if (disciplines.blank? && date_filter.blank? && (treatment_status_filter.blank? || treatment_status_filter.include?('N')))
      res = TreatmentRequest.not_admitted
      referrals  = case filter
                     when 'Physician'
                       res.includes(:referred_physician).where("referred_physician_id = ?",value)
                     when 'InsuranceCompany'
                       res.not_admitted.includes(:insurance_company).where("insurance_company_id = ?",value)
                     when 'Acuity'
                       res.not_admitted.includes(:patient => :patient_detail).where("acuity_level = ?",value)
                     when 'SOC'
                       []
                     when 'FieldStaff'
                       []
                     when 'PrimaryDiagnosis'
                       []
                     else
                       res.not_admitted
                   end
      (disciplines.present?) ? referrals.joins(:disciplines).where("treatment_disciplines.discipline_id in (?)", disciplines) : referrals
      referral_rejected_patients = referrals.collect{|r|
        patient = r.patient
        physician = r.referred_physician
        patient_acuity = unduplicated.present? ? "" :"<b>Acuity</b> #{patient.patient_acuity_level}"
        {patient_name: patient.full_name, ptnt_last_name: patient.last_name, ptnt_first_name: patient.first_name,
         patient_mr_num: patient.patient_reference, patient_cel: patient.phone_number,
         patient_tel: patient.phone_number_2, patient_address: patient.patient_address,
         certification_period: "", physician_name: physician.full_name_without_suffix,
         physcn_first_name: (physician.first_name.present?)? physician.first_name : "", physcn_last_name: physician.last_name,
         physician_phone: physician.phone_number, patient_acuity: patient_acuity,
         episode_disciplines: "", soc_date:(patient.soc_date.present?)? patient.soc_date : "",
         treatment_status: "NA", insurance: (patient.insurance_companies.present?) ? patient.insurance_companies.first.company_code : "",
         case_manager: "", primary_diagnosis: "", patient_insurance_number: patient.medicare_number, dc_date: "", field_staff: ""
        }
      }
      referral_rejected_patients
    else
      []
    end
  end

  def patient_insurance_number(treatment)
    insurance = treatment.patient.patient_insurance_companies.where(primary_insurance_flag: true).first
    if insurance
      insurance.patient_insurance_number
    else
      nil
    end
  end

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/census_report/census_main.jasper"
  end

  def health_agency_name
    org.to_s
  end

  def xml_root
    "census_report"
  end

  def header
    unduplicated.present? ? "Unduplicated Census Report" : "Census Report"
  end

  def to_xml (options = {})
    list = {}
    list.merge! ({health_agency_name: health_agency_name, patients: patients, unduplicated: unduplicated, header: header, footer: footer_status,
                  group_by: selectd_group, total_patients: self.total_patients, footer_filter: self.footer_print, filter: check_filter_or_group_by,
                  patient_icd_code_not_set: self.patients_icd_cod_not_set, patient_primary_physician_not_set: self.patients_primary_physician_not_set,
                  sub_report_url: sub_report_url})
    res = list.to_xml(root: xml_root)
    res
  end

  def sub_report_url
    "#{Rails.root}/app/views/reports/census_report/"
  end

  def check_filter_or_group_by
    self.selectd_group.present?  #(filter_name.present? && (filter_value == "PrimaryDiagnosis"  || filter_value == "Physician")) ||
  end

  def patients
    patients_list = self.records_for_census_report
    patients_list
  end

  def footer_status
    status = (treatment_status_filter.length > 0)? "Status: #{treatment_status_for_footer}; " : ""
    disp = (disciplines.length > 0)? "Disciplines: #{disciplines_status}; ": ""
    filter = (filter_name.present?)? "#{filter_name}: #{filter_value_for_footer}; " : ""
    group = (selectd_group.present?)? "Group By: #{selectd_group}; " : ""
    date_range = (date_filter.present?)? "#{date_filter}: #{from_date} - #{to_date} ": " Soc: #{from_date} - #{to_date}"
    disp + status + filter + group + date_range
  end

  def treatment_status_for_footer
    status_hash = {'A'=> "Active", 'P'=> "Pending Evaluation", 'N'=> "Not Admited", 'D'=> "Discharge", 'O'=> "Hold"}
    res = []
    self.treatment_status_filter.each do |status|
      res << status_hash[status]
    end
    res.join(',')
  end

  def disciplines_status
    disp_hash = {30=> 'SN', 27=> 'PT', 28 =>'OT', 29=> 'ST', 31 => 'MSW', 32 => 'CHHA'}
    res = []
    self.disciplines.each do |status|
      res << disp_hash[status]
    end
    res.join(',')
  end

end