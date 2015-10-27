class UnverifiedMedicationsReportDataSource

  include JasperRails
  include ReportRelatedBasicMethods

  def initialize params
    collect_unverified_medications params
  end

  def collect_unverified_medications(params)
    @patient_id = params[:patient_id]
    @field_staff_id = params[:field_staff_id]
    @md_id = params[:md_id]
    @medications = get_unverified_medications
  end

  def empty?
    @medications.empty?
  end

  def get_unverified_medications
    unverified_medications = TreatmentMedication.org_scope.where(:medication_status => 'D')

    if @patient_id
      unverified_medications = unverified_medications.includes(:treatment => :patient).where({:users => {:id => @patient_id}})
    elsif @field_staff_id
      unverified_medications = unverified_medications.includes(:treatment => :treatment_staffs).
          where(["treatment_staffs.staff_id = ? and treatment_staffs.staff_type = 'User'", @field_staff_id])
    elsif @md_id
      unverified_medications = unverified_medications.includes(:treatment => :treatment_physicians).where(
          {:treatment_physicians => {:physician_id => @md_id}})
    end

    allergies = {}
    medications = []
    unverified_medications.each do |med|
      treatment = med.treatment
      next if treatment.nil?

      allergies["#{treatment.id}"] = allergies(med) if allergies["#{treatment.id}"].nil?

      medications << medications_list(treatment, med, allergies["#{treatment.id}"])

    end
    medications.sort_by{|record| [record[:physcn_last_name].downcase, record[:physcn_first_name].downcase,
                        record[:patient_name].downcase, record[:assessment_date], record[:medication_name]]}
  end

  def medications_list(treatment, med, allergies)
    patient = treatment.patient
    physician = patient.primary_physician
    {patient_mr_number: patient.patient_reference, patient_name: patient.full_name_with_out_mr_number,patient_home_number: patient.phone_number_2,
                    patient_mobile_number: patient.phone_number, soc_date: treatment.soc_date, patient_acuity: patient.patient_acuity_level,
                    treatment_status: PatientTreatment::STATUS_DISPLAY[treatment.treatment_status], allergies: allergies, physician_name: physician.full_name_without_suffix,
                    physician_phone_number: physician.phone_number, assessment_date: med.assessment_date_format, medication_name: med.medication_description,
                    medication_reporter: get_reporter_name(med), medication_reason: medication_reason(med),
                    # Below fields are used for sorting purpose only
                    physcn_first_name: physician.first_name,physcn_last_name: physician.last_name}
  end


  def allergies(med)
    med.allergies.strip if med.allergies
  end

  def medication_reason(med)
    med.purpose.nil? ? " " : med.purpose
  end

  def get_reporter_name(med)
    staff = med.created_user
    staff_full_name = ""
    if staff.present?
      staff_full_name = staff.full_name unless staff.full_name.blank?
      staff_full_name += " #{staff.phone_number}" unless staff.phone_number.blank?
      staff_full_name
    else
      " "
    end
  end

  def jasper_report_url
    "#{Rails.root.to_s}/app/views/reports/unverified_medications/unverified_medications.jasper"
  end

  def xml_root
    "unverified-medications"
  end

  def pdf_options
    {methods: {medications: @medications}}
  end

end