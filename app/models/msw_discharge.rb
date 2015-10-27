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

class MSWDischarge < MSWFollowup
  store :data, :accessors =>
      [ "dc_status",
        "dc_reason",
        "dc_other"
      ]

  def header
    "Medical Social Worker Discharge Treatment & Summary"
  end

  def detail11_label
    "DC Reason"
  end

  def detail11_value
    discharge_reason
  end

  def detail12_label
    "DC Status"
  end

  def detail12_value
    dc_status.is_a?(Array) ? dc_status.select{|x| x.to_s != "false"}.join(', ') : dc_status unless dc_status.blank?
  end

  def discharge_reason
    (self.dc_reason == "Other")? self.dc_other || "Other" : self.dc_reason
  end

  def to_xml(options = {})
    super :methods => [:discharge_reason,
                       :dc_status
    ]+ (options[:methods] || [])
  end

  private

  def pre_populate_patient_and_visit_info
    if treatment
      follow = treatment.documents.order("id DESC").detect{|d| d.is_a? MSWFollowup }
      self.data = follow.data if follow
    end
    super
  end


end
