module ReportHeaderInfo
  def patient_full_name
    if oasis_evaluation_or_oasis_recertification?
      first_name = self.m0040_pat_fname
      last_name = self.m0040_pat_lname
      suffix = self.m0040_pat_suffix
      name = "#{first_name} #{last_name}"
      if suffix
        [name, suffix].reject{|n| n.blank?}.join(", ")
      else
        name
      end
    else
      patient_name
    end
  end

  def oasis_evaluation_or_oasis_recertification?
    (self.is_a? OasisEvaluation) or (self.is_a? OasisRecertification)
  end
  def patient_address1
    patient = treatment.patient
    address = []
    address << patient.street_address unless patient.street_address.blank?
    address << "Suite #{patient.suite_number}" unless patient.suite_number.blank?
    address << patient.city unless patient.city.blank?
    address.join(', ')
  end

  def patient_address2
    address = []

    if oasis_evaluation_or_oasis_recertification?
      address << self.m0050_pat_st unless self.m0050_pat_st.blank?
      address << self.m0060_pat_zip unless self.m0060_pat_zip.blank?
    else
      patient = treatment.patient
      address << patient.state unless patient.state.blank?
      address << patient.zip_code unless patient.zip_code.blank?
    end
    address.join(" ")
  end

  def patient_contact
    patient = treatment.patient
    patient_contact = patient.phone_number.present? ? patient.phone_number : patient.phone_number_2
    detail = []
    detail << "<b>DOB</b> " + date_of_birth unless date_of_birth.blank?
    detail <<  "<b>Tel</b> " +  patient_contact
    detail.join("  ")
  end

  def patient_address
    patient_address1 + ' ' + patient_address2
  end

  def physician_display
    "<b>#{treatment.primary_physician.full_name.upcase} </b> NPI <b>#{physician_npi_number}</b>"
  end

  def icd_type
    (formatted_date >= Date.parse('01-10-2015'))? 'ICD-10-CM' : 'ICD-9-CM'
  end

  def patient_details
    detail = []
    detail << "<b>#{patient_full_name.upcase}</b>" unless patient_full_name.blank?
    detail << gender unless gender.blank?
    detail << "<b>MR</b> " + mr unless mr.blank?
    detail.join(" ")
  end

  def start_of_care_date
    treatment.treatment_start_date.strftime("%m/%d/%Y")
  end

  def certification_period_from
    treatment_episode.start_date.strftime("%m/%d/%Y")
  end

  def certification_period_to
    treatment_episode.end_date.strftime("%m/%d/%Y")
  end

  def start_of_care_date_details
    date = []
    date << "<b>SOC</b> " + start_of_care_date unless start_of_care_date.blank?
    date << "<b>Episode</b> " + certification_period_from unless certification_period_from.blank?
    date <<  certification_period_to unless certification_period_to.blank?
    date.join(" ")
  end

  def provider_name
    org = treatment.patient.org
    org.org_name.upcase
  end

  def provider_address
    org = treatment.patient.org
    street = []
    street << org.street_address unless org.street_address.blank?
    street << "Suite " + org.suite_number unless org.suite_number.blank?
    street.join(", ")
  end

  def provider_city_details
    org = treatment.patient.org
    street = []
    street << org.city unless org.city.blank?
    street << "#{state_description(org.state)} #{org.zip_code}" unless org.zip_code.blank?
    street.join(", ")
  end

  def state_description(state_code)
    State.find_by_state_code(state_code).state_code if state_code
  end

  def provider_full_address
    provider_address + ', ' +  provider_city_details
  end

  def provider_contact
    org = treatment.patient.org
    contact = ""
    contact = "<b>Tel</b> #{org.phone_number}" if org.phone_number.present?
    contact += ", " if org.phone_number && org.fax_number
    contact += "<b>Fax</b> #{org.fax_number}" if org.fax_number.present?
    contact
  end

  def medicare_number
    if oasis_evaluation_or_oasis_recertification?
      self.m0063_medicare_num
    else
      treatment.patient.medicare_number
    end
  end

  def physician_name
    physician = treatment.primary_physician
    physician.full_name.upcase
  end

  def physician_contact
    physician = treatment.primary_physician
    contact = ""
    contact = "<b>Tel</b> #{physician.phone_number}" if physician.phone_number.present?
    contact += ", " if physician.phone_number && physician.fax_number
    contact += "<b>Fax</b> #{physician.fax_number}" if physician.fax_number.present?
    contact
  end

  def physician_short_info
    physician = treatment.primary_physician
    physician.full_name.upcase + " " + ("<b> NPI </b>#{physician_npi_number}") + " " + ("<b>Tel</b> #{physician.phone_number}") if physician.phone_number.present?
  end

  def date_of_birth
    if oasis_evaluation_or_oasis_recertification?
      Date.strptime(self.m0066_pat_birth_dt, "%m/%d/%Y").strftime("%m/%d/%Y")
    else
      treatment.patient.dob.strftime("%m/%d/%Y")
    end
  end

  def gender
    if oasis_evaluation_or_oasis_recertification?
      "(#{self.m0069_pat_gender == 1 ? 'Male' : 'Female'})"
    else
      "(#{treatment.patient.gender == 'M' ? 'Male' : 'Female'})"
    end
  end

  def field_staff_details
    field_staff.full_name +  " " + (field_staff.phone_number) if field_staff.phone_number
  end

  def get_icd_code_description(icd_code, type)
    if (type == 'icd10')
        ProspectivePaymentSystem::PPSGrouper.get_diagnostic_icd10_code_description(icd_code)
    else
      ProspectivePaymentSystem::PPSGrouper.get_diagnostic_icd_code_description(icd_code)
    end
  end

  def get_surgical_icd_code_description(icd_code, type)
    if (type == 'icd10')
      ProspectivePaymentSystem::PPSGrouper.get_procedure_icd10_code_description(icd_code)
    else
      ProspectivePaymentSystem::PPSGrouper.get_procedure_icd_code_description(icd_code)
    end
  end

  def physician_npi_number
    treatment.primary_physician.npi_number
  end

end