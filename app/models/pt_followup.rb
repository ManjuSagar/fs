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

class PTFollowup < PTEvaluation
  store :data, :accessors =>
      [ "rom_cervical_interventions",
        "rom_trunk_interventions",
        "rom_ue_interventions",
        "rom_le_interventions",
        "strength_cervical_interventions",
        "strength_trunk_interventions",
        "strength_ue_interventions",
        "strength_le_interventions",
        "balance_interventions",
        "transfers_interventions",
        "gait_interventions",
        "endurance_interventions",
        "other1_interventions",
        "other2_interventions",
        "treatment_summary"]

  def detail26_label
    "Treatment Summary"
  end

  def detail26_value
    treatment_summary
  end

  def header
    "Physical Therapy Revisit Note"
  end

  private

  def pre_populate_patient_and_visit_info
    if treatment
      eval = treatment.documents.order("id DESC").detect{|d| d.is_a? PTEvaluation }
      self.data = eval.data if eval
    end
    super
  end

end
