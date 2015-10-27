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

class OTFollowup < OTEvaluation
  # To change this template use File | Settings | File Templates.

  store :data, :accessors =>
      [ "rom_rue_interventions",
        "rom_lue_interventions",
        "strength_rue_interventions",
        "strength_lue_interventions",
        "coordination_rue_interventions",
        "coordination_lue_interventions",
        "sensation_lue_interventions",
        "sensation_rue_interventions",
        "vision_interventions",
        "balance_interventions",
        "endurance_interventions",
        "other1_interventions",
        "other2_interventions",
        "other2_interventions",
        "other3_interventions",
        "treatment_summary"]

  def header
    "Occupational Therapy Revisit Note"
  end

  def detail28_label
    "Treatment Summary"
  end

  def detail28_value
    treatment_summary
  end
  private

  def pre_populate_patient_and_visit_info
    if treatment
      eval = treatment.documents.order("id DESC").detect{|d| d.is_a? OTEvaluation }
      self.data = eval.data if eval
    end
    super
  end

end
