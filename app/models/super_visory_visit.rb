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

class SuperVisoryVisit < Document

  validates_presence_of :supervised_user_id 

    store :data, :accessors =>
        ["patient_name",
          "mr",
          "bp",
          "hr",
          "rr",
          "frequency",
          "field_staff_name",
          "visit_date",
          "approved_date",
          "time_in",
          "time_out",
          "md_name",
         "reports_for_work_assignments",
         "work_assignments_comments",
         "identifies_self",
         "identifies_self_comments",
         "courteous_behaviour",
         "courteous_behaviour_comments",
         "cooperative_behaviour",
         "cooperative_behaviour_comments",
         "positive_attitude",
         "positive_attitude_comments",
         "competent_skills",
         "competent_skills_comments",
         "adequate_skills",
         "adequate_skills_comments",
         "client_care_plan",
         "client_care_plan_comments",
         "provided_hhc_services",
         "provided_hhc_services_comments",
         "inform_client_needs",
         "inform_client_needs_comments",
         "adheres_to_hha",
         "adheres_to_hha_comments",
         "body_mechanics",
         "body_mechanics_comments",
         "grooming_habits",
         "grooming_habits_comments",
         "complies_with_hha",
         "complies_with_hha_comments",
         "other",
         "other_comments",
         "present"
        ]

    def patient_name_with_mr_display
      details = []
      details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
      details << "<b> MR#:</b> "+ patient_mr_number unless patient_mr_number.blank?
      details.join(" ")
    end

    def field_staff__full_name
    field_staff_id == 0 ? 'Pending Staffing' : field_staff.to_s
    end

    def patient_name
      treatment.patient.full_name
    end

    def patient_mr_number
      treatment.patient.patient_reference
    end
    
    def staff_member_supervised_display
      data["name_of_staff_member"].select{|x| x.to_s != "false"}.join(', ') unless data["name_of_staff_member"].blank?
    end

    def agency_name
       User.current.default_org.to_s
    end

    def to_xml(options = {})
      super :methods => [ 
                         :agency_name,
                         :patient_name_with_mr_display,
                         :patient_name,
                         :patient_mr_number,
                         :staff_member_supervised_display,
      ] + (options[:methods] || [])
    end
end
