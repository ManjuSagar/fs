require "csv"
class CahpsDataExport < Netzke::Basepack::FormPanel

  def configuration
    c = super
    c.merge(
        title: "CAHPS Data Export",
        bbar: ["->", :apply.action],
      items: [
          {
            xtype: 'borderlessFormPanel',
            layout: {
                type: "vbox",
                align: 'stretch'
            },
            items: [
                {name: :cahps_date, field_label: "Month", item_id: 'cahps_id', xtype: 'combo', store: month_data_store, allowBlank: false}
            ]

          },
      ]
    )
  end

  js_method :onApply, <<-JS
    function(){
     var cahpsDate = Ext.ComponentQuery.query('#cahps_id')[0].value;
     if (cahpsDate != null){
      this.getThePatients({cahps_date: cahpsDate}, function(url){
        url = window.location.protocol + "//" + window.location.host + url + "?target=_blank";
        window.location = url;
        //Ext.MessageBox.alert("OASIS Export Test", "Exported " + ids.length + " documents to " + file_name + " successfully.");
      }, this);
     } else{
       Ext.MessageBox.alert("Status", "Month can't be blank.")
      }

    }
  JS


  def month_data_store
    months = []
    12.times{|x| months << (Date.today - x.month).strftime("%b %Y")}
    months
  end

  action :apply, text: "Export CAHPS Data", icon: false

  endpoint :get_the_patients do |params|
    date = Date.parse(params[:cahps_date])
    month = date.month
    year = date.year
    last_month_date = date.prev_month
    previous_month = last_month_date.month
    previous_year = last_month_date.year
    ref = Time.current.strftime('%Y%m%dT%H%M')
    completed_visits = Org.current.treatment_visits.where("visit_status = ? AND EXTRACT(month FROM visit_start_time) = ?
                                                AND EXTRACT(year FROM visit_start_time) = ?", "C",  month, year)
    patients = completed_visits.collect{|v| v.treatment.patient}.uniq
    outputs = []
    patients.each{|patient|

      total_visits_in_selected_month = 0
      total_visits_in_previous_month = 0
      oasis_docs = []
      plan_of_care_docs = []
      patient.treatments.each{|t|
        visits_with_in_month = t.treatment_visits.skilled_visits.where("visit_status = ? AND EXTRACT(month FROM visit_start_time) = ?
                                                AND EXTRACT(year FROM visit_start_time) = ?", "C",  month, year)
        visits_in_previous_month = t.treatment_visits.skilled_visits.where("visit_status = ? AND EXTRACT(month FROM visit_start_time) = ?
                                                AND EXTRACT(year FROM visit_start_time) = ?", "C",  previous_month, previous_year)
        oasis_docs += t.documents.select{|d| (d.oasis_eval_document? or d.oasis_resumption_of_care? or d.oasis_rc?) and d.valid_document? and d.document_date.month == month and d.document_date.year == year}
        plan_of_care_docs += t.documents.select{|d| d.respond_to?("is_poc?") and d.document_date.month == month and d.document_date.year == year}

        total_visits_in_selected_month += visits_with_in_month.size
        total_visits_in_previous_month += visits_in_previous_month.size
      }

      medicare_flag = "M"
      medicaid_flag = "M"
      dual_eligibility = "M"

      hmo_indicator = "M"
      private_payer = "M"
      other_payment = "M"
      admin_source_hosp = "M"
      admin_source_rehab = "M"
      admin_source_skilled = "M"
      admin_source_nursing = "M"
      admin_source_inpat = "M"
      admin_source_community = "M"
      icd_primary_diagnosis = "M"
      icd_other_diagnosis_1 = "M"
      icd_other_diagnosis_2 = "M"
      icd_other_diagnosis_3 = "M"
      icd_other_diagnosis_4 = "M"
      icd_other_diagnosis_5 = "M"
      language = patient.languages.first.present? ? patient.languages.first.language_code : "M"

      dress_upper = "M"
      dress_lower = "M"
      bathing = "M"
      toileting = "M"
      transferring = "M"
      surgical_wound = "M"
      renal_disease = "M"
      location = "M"
      gender = (patient.gender == "M") ? 1 : 2
      icd_codes = []

      if (oasis_docs.empty? == false)
        doc = oasis_docs.sort_by{|d| d.document_date}.last
        cms_certification_number = doc.send("m0010_ccn")
        medicare_flag = (doc.send("m0150_cpay_mcare_ffs") || doc.send("m0150_cpay_mcare_hmo") == "1") ? 1 : 0
        medicaid_flag = (doc.send("m0150_cpay_mcaid_ffs") || doc.send("m0150_cpay_mcaid_hmo") == "1") ? 1 : 0
        dual_eligibility = (medicare_flag == "1" and medicaid_flag == "1")? 1 : 0
        hmo_indicator =  (doc.m0150_cpay_mcare_hmo == "1" || doc.m0150_cpay_mcaid_hmo == "1" || doc.m0150_cpay_priv_hmo == "1") ? 1 : 0
        private_payer = (doc.m0150_cpay_priv_hmo == "1" || doc.m0150_cpay_priv_ins == "1") ? 1 : 0
        other_payment = (doc.m0150_cpay_other == "1") ? 1 : 0
        admin_source_hosp = (doc.m1000_dc_ipps_14_da == "1" || doc.m1000_dc_ltch_14_da == "1" || doc.m1000_dc_psych_14_da == "1") ? 1 : 0
        admin_source_rehab = (doc.m1000_dc_irf_14_da == "1") ? 1 : 0
        admin_source_skilled = (doc.m1000_dc_snf_14_da == "1") ? 1 : 0
        admin_source_nursing = (doc.m1000_dc_ltc_14_da == "1") ? 1 : 0
        admin_source_inpat = (doc.m1000_dc_oth_14_da == "1") ? 1 : 0
        admin_source_community = (doc.m1000_dc_none_14_da == "1") ? 1 : 0
        location = doc.m0016_branch_id if doc.m0016_branch_id.present?
        info_completed = doc.m0090_info_completed_dt if doc.m0090_info_completed_dt.present?
        to_date=  Date.new(2015,10,01).strftime("%m/%d/%Y")
        if (info_completed >= to_date)
          icd_codes = doc.check_icd10_fields(doc)
        else
          icd_codes = doc.check_icd9_fields(doc)
        end
        icd_primary_diagnosis = icd_codes[0]
        icd_other_diagnosis_1 = icd_codes[1]
        icd_other_diagnosis_2 = icd_codes[2]
        icd_other_diagnosis_3 = icd_codes[3]
        icd_other_diagnosis_4 = icd_codes[4]
        icd_other_diagnosis_5 = icd_codes[5]
        dress_upper = doc.m1810_crnt_dress_upper if doc.m1810_crnt_dress_upper
        dress_lower = doc.m1820_crnt_dress_lower if doc.m1820_crnt_dress_lower
        bathing = doc.m1830_crnt_bathg if doc.m1830_crnt_bathg
        toileting = doc.m1840_crnt_toiltg if doc.m1840_crnt_toiltg
        transferring = doc.m1850_crnt_trnsfrng if doc.m1850_crnt_trnsfrng
        surgical_wound = if (doc.m1340_srgcl_wnd_prsnt == "01" || doc.m1340_srgcl_wnd_prsnt == "02")
                  1
                elsif (doc.m1340_srgcl_wnd_prsnt == "00")
                  0
                else
                  "M"
                end
        icd_codes = ["m1010_14_day_inp1_icd", "m1010_14_day_inp2_icd", "m1010_14_day_inp3_icd", "m1010_14_day_inp4_icd",
                     "m1010_14_day_inp5_icd", "m1010_14_day_inp6_icd", "m1016_chgreg_icd1", "m1016_chgreg_icd2", "m1016_chgreg_icd3",
                     "m1016_chgreg_icd4", "m1016_chgreg_icd5", "m1016_chgreg_icd6", "m1020_primary_diag_icd", "m1022_oth_diag1_icd",
                     "m1022_oth_diag2_icd", "m1022_oth_diag3_icd", "m1022_oth_diag4_icd", "m1022_oth_diag5_icd",
                     "m1011_14_day_inp1_icd", "m1011_14_day_inp2_icd", "m1011_14_day_inp3_icd", "m1011_14_day_inp4_icd",
                     "m1011_14_day_inp5_icd", "m1011_14_day_inp6_icd", "m1017_chgreg_icd1", "m1017_chgreg_icd2", "m1017_chgreg_icd3",
                     "m1017_chgreg_icd4", "m1017_chgreg_icd5", "m1017_chgreg_icd6", "m1021_primary_diag_icd", "m1023_oth_diag1_icd",
                     "m1023_oth_diag2_icd", "m1023_oth_diag3_icd", "m1023_oth_diag4_icd", "m1023_oth_diag5_icd"]

        renal_icd_codes = ["403.01", "403.11", "404.02", "404.03", "404.12", "404.13", "404.92", "404.93", "585.6"]
        renal_disease_existance = icd_codes.any?{|x| renal_icd_codes.include? doc.send(x)}
        renal_disease = renal_disease_existance ? 1 : 0

      elsif (plan_of_care_docs.empty? == false)
        poc = plan_of_care_docs.sort_by{|d| d.document_date}.last
        icd_primary_diagnosis = poc.send("principal_icd1") if poc.send("principal_icd1").present?
        icd_other_diagnosis_1 = poc.send("principal_icd2") if poc.send("principal_icd2").present?
        icd_other_diagnosis_2 = poc.send("principal_icd3") if poc.send("principal_icd3").present?
        icd_other_diagnosis_3 = poc.send("principal_icd4") if poc.send("principal_icd4").present?
        icd_other_diagnosis_4 = poc.send("principal_icd5") if poc.send("principal_icd5").present?
        icd_other_diagnosis_5 = poc.send("principal_icd6") if poc.send("principal_icd6").present?
      end

      output = []
      output << month
      output << year
      output << location
      output << Org.current.health_agency_detail.cms_cert_number
      output << Org.current.health_agency_detail.npi_number
      output << patients.size
      output << patient.first_name
      output << patient.middle_initials
      output << patient.last_name
      output << patient.dob.strftime("%m%d%Y")
      output << gender
      output << patient.street_address
      output << patient.suite_number
      output << patient.city
      output << patient.state
      output << patient.zip_code
      output << patient.phone_number_without_separator
      output << patient.patient_reference
      output << language
      output << total_visits_in_selected_month
      output << total_visits_in_previous_month + total_visits_in_selected_month
      output << medicare_flag
      output << medicaid_flag
      output << hmo_indicator
      output << private_payer
      output << other_payment
      output << admin_source_hosp
      output << admin_source_rehab
      output << admin_source_skilled
      output << admin_source_nursing
      output << admin_source_inpat
      output << admin_source_community
      output << dual_eligibility
      output << icd_primary_diagnosis
      output << icd_other_diagnosis_1
      output << icd_other_diagnosis_2
      output << icd_other_diagnosis_3
      output << icd_other_diagnosis_4
      output << icd_other_diagnosis_5
      output << surgical_wound
      output << renal_disease
      output << dress_upper
      output << dress_lower
      output << bathing
      output << toileting
      output << transferring

      outputs << output
    }
    file_name = export_file_path(ref)

    CSV.open(file_name, "wb") {|csv|
      csv << ["Month", "Year", "LocationCode", "CMSProviderID", "NPINumberID", "TotalServed", "FirstName", "MiddleInitial",
              "LastName", "Birthday", "Gender", "Address1", "Address2", "City", "State", "ZipCode", "Telephone", "MedicalRecord",
              "Language", "SkilledVisits", "LookBackVisits", "MedicarePayer", "MedicaidPayer", "HMOIndicator", "PrivatePayer",
              "OtherPayerSource", "AdminSourceHospital", "AdmissionSourceRehab", "AdminSourceSkilled", "AdminSourceNursing",
              "AdminSourceInpatient", "AdminSourceCommunity", "CMSDualEligibility", "ICD9PrimaryDiagnosis", "ICD9OtherDiagnosis1",
              "ICD9OtherDiagnosis2", "ICD9OtherDiagnosis3", "ICD9OtherDiagnosis4", "ICD9OtherDiagnosis5", "SurgicalDischarge",
              "EndStageRenalDisease", "DressUpperADL", "DressLowerADL", "BathingADL", "ToiletingADL", "TransferingADL"]
      outputs.each{|out|
        csv << out
      }
    }
    result = Rails.application.routes.url_helpers.cahps_export_path(ref)
    {:set_result => result}
  end

  def export_file_path(reference)
    "#{Rails.root}/tmp/CAHPS_#{reference}.csv"
  end
end