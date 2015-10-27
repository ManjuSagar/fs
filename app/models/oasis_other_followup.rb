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

class OasisOtherFollowup < Document
  after_initialize :pre_populate_patient_and_visit_info, :assessment_complete_reason, :set_soc_roc_pressure_ulcer_values, :if => :new_record?
  include OasisExtension
  before_save :reset_values_based_on_info_completed_date?

  has_paper_trail
  paper_trail_off!

  def assessment_complete_reason
    self.m0100_assmt_reason = "05"
  end

end
