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

class CHHAFollowup < ChhaCarePlan

   ASST_WITH_ATTRS = {
    "Check Temperature" => "temp_done",
    "Back Rub" => "back_rub_done",
    "Check Pulse" => "pulse_rate_done",
    "Grocery Shopping" => "grocery_done",
    "Check Respiration" => "respiratory_done",
    "Meal Preparation" => "meal_preparation_done",
    "Check Blood Pressure" => "blood_pressure_done",
    "Feeding" => "ast_feeding_done",
    "Toileting Activities" => "toileting_activities_done",
    "Self-Administaration of Medications" => "self_medications_done",
    "Bathing: Shower (please use a shower chair)" => "shower_done",
    "Changing Bed Linens" => "cha_bed_linen_done",
    "Bathing: Tub" => "tub_bath_done",
    "Laundry" => "laundry_done",
    "Bathing: Bed Partial" => "bed_bath_partial_done",
    "Cleaning Living Areas" =>  "cln_liv_area_done",
    "Bathing: Bed Complete" => "bed_bath_complete_done",
    "Amb. Assist" => "amb_assist_done",
    "Bathing: Bed Sponge" => "bed_bath_sponge_done",
    "Transfers" => "transfers_done",
    "Appling Deodorant" => "deodorant_done",
    "ROM" => "rom_done",
    "Dressing and Undressing" => "dressing_done",
    "PT/OT Ordered Exercises" => "excercise_done",
    "Denture Care" => "denture_care_done",
    "Positioning: Turn Each Hour" => "positioning_done",
    "Brushing Teeth" => "oral_care_done",
    "Infection Control" => "infection_control_done",
    "Brushing/Combing Hair" => "hair_done",
    "Clear Pathways" => "clr_path_done",
    "Shaving" => "shave_done",
    "Appling Makeup" => "makeup_done",
    "Nail Hygiene" => "nail_done",
    "Foot Care" => "foot_care_done",
    "Skin Care" => "skin_care_done"
   }

   OTHER_TEXTS = ["othr_text1_done", "other1_text", "othr_text2_done", "other2_text", "othr_text3_done", "other3_text",
                  "othr_text4_done", "other4_text", "othr_text5_done", "other5_text"]
    store :data, :accessors =>
        ["temp",
         "blood_pressure",
         "rom",
         "position",
         "infection_control",
         "amb_assist",
         "notes_and_comments",
         "notes_and_comments_value",
         "notes_and_comments_label"
        ] + ASST_WITH_ATTRS.values + OTHER_TEXTS

   after_initialize :set_other_texts

    def notes_and_comments_label
      "Notes and Comments"
    end

    def notes_and_comments_value
      notes_and_comments
    end

    def performs
      perform_tags_arr = []
      conditional_fields_arr = ["temp", "amb_assist", "rom", "position", "infection_control"]
      assists = ASST_WITH_ATTRS.keys
      ASST_WITH_ATTRS.values.each_with_index do |attr, index|
        done_assists = []
        done_assists << attr if self.send(attr)

        unless done_assists.empty?
          done_tag = {}
          done_tag["done"] = done_assists.join(", ")
          done_tag["assist"] = assists[index]
          conditional_attr = conditional_fields_arr.detect{|a| attr.start_with?(a)}
          if (conditional_attr.present? and self.send(conditional_attr))
            value = self.send(conditional_attr)
            value = (value.is_a? String)? [value] : value
            value.select!{|v| ((not v.nil?) and v != false)}
            done_tag["assist"] += ": #{value.join(', ')}" unless value.empty?
          end
          perform_tags_arr << done_tag
        end
      end
      OTHER_TEXTS.each_with_index{|field, i|
        next if (i % 2 == 1)
        if (self.send(OTHER_TEXTS[i + 1]) and self.send(field))
          done_tag = {}
          done_tag["done"] = self.send(field)
          done_tag["assist"] = self.send(OTHER_TEXTS[i+1])
          perform_tags_arr << done_tag
        end
      }
      perform_tags_arr
    end

   def systolic_bp_display
     systolic_bp.present? ? systolic_bp : " "
   end

   def diastolic_bp_display
     diastolic_bp.present? ? diastolic_bp : " "
   end
   def temperature_in_fht_display
     temperature_in_fht.present? ? temperature_in_fht : " "
   end
   def heart_rate_display
     heart_rate.present? ? heart_rate : " "
   end
   def respiration_rate_display
     respiration_rate.present? ? respiration_rate : " "
   end

   def assist_subreport_url
     "#{Rails.root}/app/views/reports/chha_followup/assist_subreport.jasper"
   end


    def to_xml(options = {})
      super :methods => [:temperature_in_fht,
                         :heart_rate,
                         :respiration_rate,
                         :systolic_bp_display,
                         :diastolic_bp,
                         :diastolic_bp_display,
                         :heart_rate_display,
                         :respiration_rate_display,
                         :temperature_in_fht_display,
                         :notes_and_comments_value,
                         :notes_and_comments_label,
                         :assist_subreport_url
      ]  + (options[:methods] || [])
    end

    private

    def pre_populate_patient_and_visit_info
      if treatment.present?
        eval = treatment.documents.where("document_type = ?", "ChhaCarePlan").order("id DESC").first
        self.data = eval.data if eval
      end
      super
    end

    def set_other_texts
      if treatment.present?
        eval = treatment.documents.where("document_type = ?", "ChhaCarePlan").order("id DESC").first
        if eval
          5.times.each{|i|
            text = eval.send("other#{i+1}_text")
            if text.present?
              prn = eval.send("othr_text#{i+1}_prn")
              qvisit = eval.send("othr_text#{i+1}_qvisit")
              weekly = eval.send("othr_text#{i+1}_weekly")
              if (prn.nil? and qvisit.nil? and weekly.nil?)
                self.send("other#{i+1}_text=", nil)
                self.send("othr_text#{i+1}_done=", nil)
              else
                self.send("other#{i+1}_text=", text)
                self.send("othr_text#{i+1}_done=", nil)
              end
            else
              self.send("other#{i+1}_text=", nil)
              self.send("othr_text#{i+1}_done=", nil)
            end
          }
        end
      end
    end

end
