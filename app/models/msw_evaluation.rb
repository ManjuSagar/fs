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

class MSWEvaluation < Document

  store :data, :accessors =>
      ["patient_name",
       "mr",
       "bp",
       "hr",
       "rr",
       "md_name",
       "patient_lives",
       "other_patient_lives",
       "quality_of_care",
       "env_conditions",
       "reasons_for_referral",
       "other_reasons_for_referral",
       "emotional_status",
       "other_emotional_status",
       "mental_status",
       "other1_mental_status",
       "other2_mental_status",
       "home_bound_status",
       "other_home_bound_status",
       "ambulates",
       "employment",
       "employment_amount",
       "pt_social_security",
       "pt_social_security_amount",
       "spouse_social_security",
       "spouse_social_security_amount",
       "pt_ssi",
       "pt_ssi_amount",
       "spouse_ssi",
       "spouse_ssi_amount",
       "pensions",
       "pensions_amount",
       "other_income",
       "other_income_amount",
       "food_stamps",
       "food_stamps_amount",
       "total_income",
       "savings_account",
       "savings_account_amount",
       "owns_home",
       "owns_home_amount",
       "owns_other",
       "owns_other_amount",
       "va_assistance",
       "va_assistance_amount",
       "spouse_assets_ssi",
       "spouse_assets_ssi_amount",
       "other_assets",
       "other_assets_amount",
       "total_assets",
       "interventions",
       "other_interventions",
       "goals",
       "other_goals",
       "identified_problems",
       "further_problems",
       "identified_strengths",
       "intervention_details",
       "plan_of_care",
       "visit_goal_details",
       "field_staff_name",
       "visit_date",
       "approved_date",
       "time_in",
       "time_out"]


  #validates :notes_and_comments, :presence => true

  def header
    (mo_report_flag == true) ? "MSW Evaluation & Treatment MD Order" : "MSW Evaluation & Treatment"
  end

  def patient_name_with_mr_display
    details = []
    details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
    details << "<b> MR#:</b> "+ mr unless mr.blank?
    details.join(" ")
  end

  def living_situation_display
    living_situations = []
    living_situations += data["reasons_for_referral"].select{|x| x.to_s != "false"} unless data["reasons_for_referral"].blank?
    living_situations << data["other_patient_lives"] unless data["other_patient_lives"].blank?
    living_situations << data["quality_of_care"] unless data["quality_of_care"].blank?
    living_situations << data["env_conditions"] unless data["env_conditions"].blank?
    living_situations.join(', ')
  end

  def reasons_for_referral_display
    reasons = []
    reasons += data["patient_lives"].select{|x| x.to_s != "false"} unless data["patient_lives"].blank?
    reasons << data["other_reasons_for_referral"] unless data["other_reasons_for_referral"].blank?
    reasons.join(', ')
  end

  def home_bound_status_display
    home_bound_status = []
    home_bound_status += data["home_bound_status"].select{|x| x.to_s != "false"} unless data["home_bound_status"].blank?
    home_bound_status << "<b>Other: </b>"  + self.other_home_bound_status unless self.other_home_bound_status.blank?
    home_bound_status << "<b>Ambulates in ft.: </b>"  + self.ambulates unless self.ambulates.blank?

    home_bound_status.join(', ')
  end

  def emotional_status_display
    emotions = []
    emotions += data["emotional_status"].select{|x| x.to_s != "false"} unless data["emotional_status"].blank?
    emotions << data["other_emotional_status"] unless data["other_emotional_status"].blank?
    emotions.join(', ')
  end

  def interventions_display
    interventions = []
    interventions += data["interventions"].select{|x| x.to_s != "false"} unless data["interventions"].blank?
    interventions << data["other_interventions"] unless data["other_interventions"].blank?
    interventions.join(', ')
  end

  def goals_display
    goals = []
    goals += data["goals"].select{|x| x.to_s != "false"} unless data["goals"].blank?
    goals << data["other_goals"] unless data["other_goals"].blank?
    goals.join(', ')
  end

  def mental_status_display
    mental_status = []
    mental_status += data["mental_status"].select{|x| x.to_s != "false"} unless data["mental_status"].blank?
    mental_status << data["other1_mental_status"] unless data["other1_mental_status"].blank?
    mental_status << data["other2_mental_status"] unless data["other2_mental_status"].blank?
    mental_status.join(', ')
  end

  def identified_problems_display
    problems = []
    problems += data["identified_problems"].select{|x| x.to_s != "false"} unless data["identified_problems"].blank?
    problems << data["further_problems"] unless data["further_problems"].blank?
    problems.join(', ')
  end


  def to_xml(options = {})
    options[ :methods] = [:living_situation_display,
                       :reasons_for_referral_display,
                       :emotional_status_display,
                       :interventions_display,
                       :goals_display,
                       :mental_status_display,
                       :agency_name,
                       :identified_problems_display,
                       :home_bound_status_display
    ] + (options[:methods] || [])
    super
  end

  def agency_name
    agency_name_for_visit_document
  end

  private

  def set_doc_is_evaluation
    self.doc_is_evaluation = true
  end
end

