module OasisPrint
  def group_of_icd(field)
    data.keys.select{|x| x.include? field }
  end

  def get_check_box_values(group)
    values = []
    group.each do |key|
      rec = OasisFieldSpec.find_by_field_name(key.upcase) unless self.send(key).blank?
      if rec.present?
        display_value = if (key == "m0150_cpay_other" and self.send("m0150_other_cpay").present?)
                           "#{rec.display_value} - #{self.send("m0150_other_cpay").capitalize}"
                        else
                            rec.display_value
                        end
        values << display_value
      end
    end
    formatted_values = values.join(",") unless values.blank?
    values.blank? ? {} : {field_name: group.first.split("_").first.upcase, value: formatted_values}
  end

  def get_pressure_ulcers
    values = []
    pressure_ulcers.each do |key|
      values << "#{display_value(key)} #{self.send(key)}" unless self.send(key).blank?
    end
    formatted_values = values.join(",") unless values.blank?
    values.blank? ? {} : {field_name: pressure_ulcers.first.split("_").first.upcase, value: formatted_values}
  end

  def required_fields
    names = data.keys.select{|x| x.start_with? "m0040"}
    original_fields = data.keys.select{|x| x.end_with? "original"}
    keys = data.keys - (check_box_list.flatten + check_boxes + icd_codes_list + names + multiple_radio_groups_list.flatten + pressure_ulcers)
    keys = keys.reject{|x| ["patient_name", "mr", "treatment_episode_id", "field_staff_id", "valid", "supervised_user_id", "m0020_pat_id", "doc_date",
                            "physician_name", "m0030_start_care_dt", "m0050_pat_st", "m0060_pat_zip", "m0066_pat_birth_dt", "m0069_pat_gender",
                            "subm_hipps_code", "subm_hipps_version", "field_signature_not_required", "treatment_authorization_code",
                            clinical_fields, "extended_oasis", original_fields, "previous_unlock_reason"].flatten.include? x}
  end

  def get_group_elements(list)
    list_of_elements = []
    list.each {|x| list_of_elements << group_elements(x)}
    list_of_elements
  end

  def group_elements(field)
    data.keys.select{|x| x.start_with? field}
  end

  def icd_codes_list
    data.keys.select {|x| (x.include? "icd" or x.include? "severity")}.reject{|x| ["m1012_inp_na_icd", "m1012_inp_uk_icd", "m1016_chgreg_icd_na"].include? x}
  end

  def oasis_soc_list
    fields_list = []
    keys = required_fields

    keys.each do |key|
      fields_list << {field_name: key.split("_").first.upcase, value: self.send(key)} if self.send(key).present?
    end

    check_boxes.each do |key|
      fields_list << {field_name: key.split("_").first.upcase, value: OasisFieldSpec.find_by_field_name(key.upcase).display_value} if self.send(key).present?
    end

    check_box_list.each do |group|
         check_box_values = get_check_box_values(group)
      fields_list << check_box_values unless check_box_values.blank?
    end

    multiple_radio_groups_list.each do |group|
      radio_group_values = get_multi_radio_group_values(group)
      fields_list << radio_group_values unless radio_group_values.blank?
    end

    fields_list << get_pressure_ulcers unless get_pressure_ulcers.blank?

    fields_list.sort_by{|x| x[:field_name]}
  end

  def icd_codes_display
    icd_codes = []

    non_payment_codes.each do |code|
      icd_type = get_icd_code_type(code)
      description = (code.start_with? "m1012") ? get_surgical_icd_code_description(self.send(code), icd_type) : get_icd_code_description(self.send(code), icd_type)
      icd_codes << {field: code.split("_").first.upcase, display_value: display_value(code), code: self.send(code), description: description, :"severity" => "" } unless self.send(code).blank?
    end

    payment_codes.each  do |code|
      icd_type = get_icd_code_type(code)
      severity = "#{code.split('_icd').first}_severity"
      icd_codes << {field: code.split("_").first.upcase, display_value: display_value(code), code: self.send(code), description: get_icd_code_description(self.send(code), icd_type), :"severity" => self.send(severity)} unless self.send(code).blank?
    end
    icd_codes.sort_by{|x| [x[:field], x[:display_value]]}
  end

  def get_icd_code_type(code)
    (OasisExtension::ICD10_FIELDS_SET.include? code) ? "icd10" : "icd9"
  end

  def get_multi_radio_group_values(group)
    values = []
    group.each do |key|
      values << "#{display_value(key)} #{self.send(key)}" unless self.send(key).blank?
    end
    formatted_values = values.join(",") unless values.blank?
    values.blank? ? {} : {field_name: group.first.split("_").first.upcase, value: formatted_values}
  end

  def display_value(key)
    display_value = OasisFieldSpec.find_by_field_name(key.upcase).display_value
    display_value = display_value.nil? ? "#{display_value}" :"#{display_value}."
  end

  def field_sub_report_url
    "#{Rails.root}/app/views/reports/oasis_generic_template/fields.jasper"
  end

  def icd_codes_sub_report_url
    "#{Rails.root}/app/views/reports/oasis_generic_template/icd_codes.jasper"
  end

  def xml_methods
    [:provider_name, :provider_contact, :provider_full_address, :start_of_care_date_details, :patient_details,
     :patient_contact, :patient_address, :field_staff_details, :field_sub_report_url, :icd_codes_sub_report_url,
     :icd_codes_display, :oasis_soc_list, :physician_short_info, :report_title]
  end

  def insurance_company_flag?
    return false if treatment.medicare? or !is_visit_document?
    treatment.patient.org.health_agency_detail.print_insurance_address?
  end

  def provider_name
    if insurance_company_flag?
      treatment.insurance_company.to_s.upcase
    else
      super
    end
  end

  def provider_address
    if insurance_company_flag?
      ins = treatment.insurance_company
      addr = []
      addr << ins.claim_street_address unless ins.claim_street_address.blank?
      addr << " Suite #{ins.claim_suite_number}" unless ins.claim_suite_number.blank?
      addr.join(", ")
    else
      super
    end
  end

  def provider_city_details
    if insurance_company_flag?
      addr = []
      ins = treatment.insurance_company
      addr << ins.claim_city unless ins.claim_city.blank?
      addr << state_description(ins.claim_state) unless ins.claim_state.blank?
      addr << ins.claim_zip_code unless ins.claim_zip_code.blank?
      addr.join(", ")
    else
      super
    end
  end

  def provider_contact
    if insurance_company_flag?
      ins = treatment.insurance_company
      "<b>Tel</b> #{ins.claim_phone_number}" unless ins.claim_phone_number.blank?
    else
      super
    end
  end

end