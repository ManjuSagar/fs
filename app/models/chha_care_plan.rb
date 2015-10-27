# == Schema Information
#
# Table name: documents
#
#  id                        :integer          not null, primary key
#  document_definition_id    :integer          not null
#  document_type             :string(255)      not null
#  document_form_template_id :integer          not null
#  document_date             :date
#  data                      :text
#  status                    :string(2)        not null
#  treatment_id              :integer          not null
#  treatment_episode_id      :integer
#  physician_id              :integer
#  visit_id                  :integer
#  lock_version              :integer          default(0)
#  created_user_id           :integer
#  fs_sign_required          :boolean
#  supervisor_sign_required  :boolean
#  os_sign_required          :boolean
#  agency_approved_user_id   :integer
#  field_staff_id            :integer
#  supervised_user_id        :integer
#  fs_sign_date              :date
#  supervised_user_sign_date :date
#  os_sign_date              :date
#

  class ChhaCarePlan < Document
    FREQUENCY_ATTRS = {
        "Check Temperature" => ["temp_prn", "temp_qvisit", "temp_weekly"],
        "Check Pulse" => ["pulse_rate_prn", "pulse_rate_qvisit", "pulse_rate_weekly" ],
        "Check Respiration" => ["respiratory_prn","respiratory_qvisit", "respiratory_weekly" ],
        "Check Blood Pressure" => ["blood_pressure_prn","blood_pressure_qvisit", "blood_pressure_weekly"],
        "Toileting Activities" => ["toileting_activities_prn", "toileting_activities_qvisit", "toileting_activities_weekly"],
        "Bathing: Shower (please use a shower chair)" => ["shower_prn", "shower_qvisit", "shower_weekly"],
        "Bathing: Tub" => ["tub_bath_prn", "tub_bath_qvisit", "tub_bath_weekly"],
        "Bathing: Bed Partial" => ["bed_bath_partial_prn", "bed_bath_partial_qvisit", "bed_bath_partial_weekly"],
        "Bathing: Bed Complete" => ["bed_bath_complete_prn", "bed_bath_complete_qvisit", "bed_bath_complete_weekly"],
        "Bathing: Bed Sponge" => ["bed_bath_sponge_prn", "bed_bath_sponge_qvisit", "bed_bath_sponge_weekly"],
        "Appling Deodorant" => ["deodorant_prn", "deodorant_qvisit", "deodorant_weekly"],
        "Dressing and Undressing" => ["dressing_prn", "dressing_qvisit", "dressing_weekly"],
        "Denture Care" => ["denture_care_prn", "denture_care_qvisit", "denture_care_weekly"],
        "Brushing Teeth" => ["oral_care_prn", "oral_care_qvisit", "oral_care_weekly"],
        "Brushing/Combing Hair" => ["hair_prn", "hair_qvisit", "hair_weekly"],
        "Shaving" => ["shave_prn", "shave_qvisit", "shave_weekly"],
        "Appling Makeup" => ["makeup_prn", "makeup_qvisit", "makeup_weekly"],
        "Nail Hygiene" => ["nail_prn", "nail_qvisit", "nail_weekly"],
        "Foot Care" => ["foot_care_prn", "foot_care_qvisit", "foot_care_weekly"],
        "Skin Care" => ["skin_care_prn", "skin_care_qvisit", "skin_care_weekly"],
        "Back Rub" => ["back_rub_prn", "back_rub_qvisit", "back_rub_weekly"],
        "Grocery Shopping" => ["grocery_prn", "grocery_qvisit", "grocery_weekly"],
        "Meal Preparation" => ["meal_preparation_prn", "meal_preparation_qvisit", "meal_preparation_weekly"],
        "Feeding" => ["ast_feeding_prn", "ast_feeding_qvisit", "ast_feeding_weekly"],
        "Self-Administaration of Medications" => ["self_medications_prn", "self_medications_qvisit", "self_medications_weekly"],
        "Changing Bed Linens" => ["cha_bed_linen_prn", "cha_bed_linen_qvisit", "cha_bed_linen_weekly"],
        "Laundry" => ["laundry_prn", "laundry_qvisit", "laundry_weekly"],
        "Cleaning Living Areas" => ["cln_liv_area_prn", "cln_liv_area_qvisit", "cln_liv_area_weekly"],
        "Amb. Assist" => ["amb_assist_prn", "amb_assist_qvisit", "amb_assist_weekly"],
        "Transfers" => ["transfers_prn", "transfers_qvisit", "transfers_weekly"],
        "ROM" => ["rom_prn", "rom_qvisit", "rom_weekly"],
        "PT/OT Ordered Exercises" => ["excercise_prn", "excercise_qvisit", "excercise_weekly"],
        "Positioning: Turn Each Hour" => ["positioning_prn", "positioning_qvisit", "positioning_weekly"],
        "Infection Control" => ["infection_control_prn", "infection_control_qvisit", "infection_control_weekly"],
        "Clear Pathways" => ["clr_path_prn", "clr_path_qvisit", "clr_path_weekly"]
    }

    OTHER_TEXTS = ["othr_text1_prn", "othr_text1_qvisit", "othr_text1_weekly", "other1_text",
                   "othr_text2_prn", "othr_text2_qvisit", "othr_text2_weekly", "other2_text",
                   "othr_text3_prn", "othr_text3_qvisit", "othr_text3_weekly", "other3_text",
                   "othr_text4_prn", "othr_text4_qvisit", "othr_text4_weekly", "other4_text",
                   "othr_text5_prn", "othr_text5_qvisit", "othr_text5_weekly", "other5_text"]
  store :data, :accessors =>
      ["patient_name",
       "mr",
       "bp",
       "hr",
       "rr",
       "md_name",
       "field_staff_name",
       "visit_date",
       "approved_date",
       "time_in",
       "time_out",
       "temp",
       "position",
       "amb_assist",
       "rom",
       "infection_control"
       ] + FREQUENCY_ATTRS.values.flatten + OTHER_TEXTS

    after_save :activate_chha_discipline

  def current_org_vitals_reference_ranges_for_vital(vital, unit)
    org = Org.current
    org_vital = org.vitals_reference_ranges.select{|v| v.vital_sign == vital}.first
    max_val = org_vital.maximum_value
    min_val = org_vital.minimum_value
    vital_range_string =  if min_val.present? and max_val.present?
                            "< #{min_val.to_s} or > #{max_val.to_s} #{unit}"
                          elsif min_val.present? and max_val.nil?
                            "<" + min_val.to_s + unit
                          elsif min_val.nil? and max_val.present?
                            ">" + max_val.to_s + unit
                          else
                             " "
                          end
    vital_range_string
  end

  def vital_sign_temperature
    current_org_vitals_reference_ranges_for_vital("temperature_in_fht", "F")
  end

  def vital_sign_pulse
    current_org_vitals_reference_ranges_for_vital("heart_rate", " per minute")
  end

  def vital_sign_respiration_rate
    current_org_vitals_reference_ranges_for_vital("respiration_rate", " per minute")
  end

  def vital_sign_systolic_bp
    current_org_vitals_reference_ranges_for_vital("systolic_bp", " mmHG")
  end

  def vital_sign_diastolic_bp
    current_org_vitals_reference_ranges_for_vital("diastolic_bp", " mmHG")
  end

  def weekly_label
    "Time(s) Weekly"
  end

  def qvisit_label
    "At Each Visit"
  end

  def prn_label
    "As Needed"
  end

  def performs
    perform_tags_arr = []
    conditional_fields_arr = ["temp", "amb_assist", "rom", "position", "infection_control"]
    assists = FREQUENCY_ATTRS.keys
    FREQUENCY_ATTRS.values.each_with_index do |attrs, index|
      frequencies = []
      frequencies << prn_label if self.send(attrs[0])
      frequencies << qvisit_label if self.send(attrs[1])
      frequencies << self.send(attrs[2]) + " " + weekly_label if self.send(attrs[2])

      unless frequencies.empty?
        perform_tag = {}
        perform_tag["frequency"] = frequencies.join(", ")
        perform_tag["assist"] = assists[index]
        conditional_attr = conditional_fields_arr.detect{|a| attrs[0].start_with?(a)}
        if (conditional_attr.present? and self.send(conditional_attr))
          value = self.send(conditional_attr)
          value = (value.is_a? String)? [value] : value
          value.select!{|v| ((not v.nil?) and v != false)}
          perform_tag["assist"] += ": #{value.join(', ')}" unless value.empty?
        end
        perform_tags_arr << perform_tag
      end
    end
    OTHER_TEXTS.each_with_index{|field, i|
      next unless (i % 4 == 0)
      if self.send(OTHER_TEXTS[i + 3])
        perform_tag = {}
        other_frequencies = []
        other_frequencies << prn_label if self.send(field)
        other_frequencies << qvisit_label if self.send(OTHER_TEXTS[i + 1])
        other_frequencies << self.send(OTHER_TEXTS[i + 2]) + " " + weekly_label if self.send(OTHER_TEXTS[i + 2])
        perform_tag["frequency"] = other_frequencies.join(", ")
        perform_tag["assist"] = self.send(OTHER_TEXTS[i + 3])
        perform_tags_arr << perform_tag
      end
    }
    perform_tags_arr
  end

  def activate_chha_discipline
    chha = treatment.treatment_disciplines.detect{|disc| disc.discipline.discipline_code == "CHHA"}
    if chha
      chha.system_driven_event = true
      chha.activate! if chha.may_activate?
      chha.system_driven_event = false
    end
    nil
  end

  def agency_name
    agency_name_for_visit_document
  end

  def to_xml(options = {})
    super :methods => [:performs,
                       :agency_name,
                       :vital_sign_temperature,
                       :vital_sign_pulse,
                       :vital_sign_respiration_rate,
                       :vital_sign_systolic_bp,
                       :vital_sign_diastolic_bp,
                      ] + (options[:methods] || [])
  end


    def assist_enabled? field_prefix
      ['prn', 'qvisit', 'weekly'].each {|suffix|
        return true if self.send(:"#{field_prefix}_#{suffix}").nil? == false
      }
      false
    end

    private

    def set_doc_is_evaluation
      self.doc_is_evaluation = true
    end

  end
