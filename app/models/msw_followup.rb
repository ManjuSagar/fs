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

class MSWFollowup < MSWEvaluation
  store :data, :accessors =>
      ["living_situation_follow_up",
       "changed_living_situations",
       "follow_up_plan",
       "progress_towards_goals",
      ]

  def header
    "Medical Social Worker Follow Up & Treatment"
  end

  def detail2_label
    "Living Situation"
  end

  def detail2_value
    living_follow_up_display
  end

  def detail3_label
    "Home Bound Status" unless mo_report_flag
  end

  def detail3_value
    home_bound_status_display unless mo_report_flag
  end

  def detail4_label
    "Psychosocial Assessment"
  end

  def detail4_value
    "<b>Mental Status Display: </b>" + mental_status_display unless mental_status_display.blank?
  end

  def detail5_value
    "<b>Emotional Status: </b>" + emotional_status_display unless emotional_status_display.blank?
  end

  def detail6_label
    "Interventions"
  end

  def detail6_value
    "<b>Planned Interventions:</b>" + interventions_display unless interventions_display.blank?
  end

  def detail7_value
    "<b>Intervention Details:</b>" + intervention_details unless intervention_details.blank?
  end

  def detail8_label
   "Goals"
  end

  def detail8_value
    goals_display
  end

  def detail9_label
    "Visit Goal Details"
  end

  def detail9_value
    visit_goal_details
  end

  def detail10_label
    "Progress Towards Goals"
  end

  def detail10_value
    progress_towards_goals
  end

  def detail11_label
    "Follow-up Plan"
  end

  def detail11_value
    follow_up_plan_display
  end

  def patient_name_with_mr_display
    details = []
    details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
    details << "<b> MR#:</b> "+ mr unless mr.blank?
    details.join(" ")
  end

  alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    super({ :root => "document" }.merge(options))
    default_options = {:root => "document", :methods => [:living_follow_up_display,
                                                         :follow_up_plan_display,
                                                         :header,
                                                         :patient_name_with_mr_display,
                                                         :date_time_display
    ] }
    self.ar_to_xml(options.merge(default_options), &block)
  end

  def living_follow_up_display
    living_situations = []
    living_situations += data["living_situation_follow_up"].select{|x| x.to_s != "false"} unless data["living_situation_follow_up"].blank?
    living_situations << data["changed_living_situations"] unless data["changed_living_situations"].blank?
    living_situations.join(', ')
  end

  def follow_up_plan_display
    follow_ups = []
    follow_ups += data["follow_up_plan"].select{|x| x.to_s != "false"} unless data["follow_up_plan"].blank?
    follow_ups.join(', ')
  end

  private

  def pre_populate_patient_and_visit_info
    if treatment
      eval = treatment.documents.order("id DESC").detect{|d| d.is_a? MSWEvaluation }
      self.data = eval.data if eval
    end
    super
  end



end
