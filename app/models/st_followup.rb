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

class STFollowup < STEvaluation
  store :data, :accessors =>
      ["treat_voice_interventions",
         "treat_voice_response",
         "treat_speach_interventions",
         "treat_speach_response",
         "treat_dysphagia_interventions",
         "treat_dysphagia_response",
         "treat_language_interventions",
         "treat_language_response",
         "aural_rehabilitation_interventions",
         "aural_rehabilitation_response",
         "treat_visual_interventions",
         "treat_visual_response",
         "treat_cognitive_interventions",
         "treat_cognitive_response",
         "other_interventions",
         "other_response",
        ]

  after_initialize :create_display_contents

  def header
    "Speech Therapy Follow Up & Treatment"
  end

  def create_display_contents
    self.class.create_display_contents(self)
  end

  def self.create_display_contents(doc)
    fields = [:treat_voice, :treat_speach, :treat_dysphagia, :treat_language, :aural_rehabilitation,
                        :treat_visual, :treat_cognitive, :other]
    fields.each{|f|
      content = []
      ["interventions", "response"].each{|fi|
         field = doc.send("#{f}_#{fi}")
         syck_class_cond = (field.present? and field.class.name != "Syck::PrivateType")
         content << ("<b>#{fi.capitalize}: </b>" + field) if syck_class_cond
         content << ("<b>Patient's Response/Outcome : </b>" + field) if  syck_class_cond
      }
      content = content.join(" ")
      define_method("#{f}_display") do
        content
      end
    }
  end

  def detail2_label
    "Treat Voice Order"
  end

  def detail2_value
    treat_voice_display
  end

  def detail4_label
    "Treat Speech"
  end

  def detail4_value
    treat_speach_display
  end

  def detail5_label
    "Treat Dysphagia"
  end

  def detail5_value
    treat_dysphagia_display
  end

  def detail6_label
    "Treat Language Disorder"
  end

  def detail6_value
    treat_language_display
  end

  def detail7_label
    "Aural Rehabilitation Training"
  end

  def detail7_value
    aural_rehabilitation_display
  end

  def detail8_label
    "Treat Visual Disorder"
  end

  def detail8_value
    treat_visual_display
  end

  def detail9_label
    "Treat Cognitive Disorder"
  end

  def detail9_value
    treat_cognitive_display
  end

  def detail10_label
    "Other"
  end

  def detail10_value
    other_display
  end

  private

  def pre_populate_patient_and_visit_info
    if treatment
      eval = treatment.documents.order("id DESC").detect{|d| d.is_a? STEvaluation }
      self.data = eval.data if eval
    end
    super
  end

end
