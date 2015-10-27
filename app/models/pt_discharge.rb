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

class PTDischarge < PTFollowup
    store :data, :accessors =>
      [ "rom_cervical_progress_goals",
        "rom_trunk_progress_goals",
        "rom_ue_progress_goals",
        "rom_le_progress_goals",
        "strength_cervical_progress_goals",
        "strength_trunk_progress_goals",
        "strength_ue_progress_goals",
        "strength_le_progress_goals",
        "balance_progress_goals",
        "transfers_progress_goals",
        "gait_progress_goals",
        "endurance_progress_goals",
        "other1_progress_goals",
        "other2_progress_goals",
        "dc_reason",
        "dc_other",
        "dc_status"

        ]

    def discharge_reason_display
      (self.dc_reason == "Other")? self.dc_other || "Other" : self.dc_reason
    end

 def detail26_label
      "DC Reason"
    end

    def detail26_value
      dc_reason
    end

    def detail27_label
       "DC Status"
    end

    def detail27_value
      dc_status.is_a?(Array) ? dc_status.select{|x| x.to_s != "false"}.join(', ') : dc_status unless dc_status.blank?
    end

    def detail28_label
      "Notes and Comments"
    end

    def detail28_value
      notes_and_comments_display
    end

    def header
      "Physical Therapy Discharge Treatment & Summary"
    end

    def tinetti_fields_entered?
      false
    end

    def to_xml(options = {})
      super :methods => [:discharge_reason
      ]
    end

     private

    def pre_populate_patient_and_visit_info
      if treatment
        follow = treatment.documents.order("id DESC").detect{|d| d.is_a? PTFollowup }
        self.data = follow.data if follow
      end
      super
    end

end
