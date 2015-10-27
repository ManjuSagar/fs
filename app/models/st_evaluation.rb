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

class STEvaluation < Document
  store :data, :accessors =>
      [ "patient_name",
        "mr",
        "hr",
        "rr",
        "md_name",
        "bp",
        "field_staff_name",
        "visit_date",
        "approved_date",
        "time_in",
        "time_out",
        "eval_only_with_instruction_goals",
        "treat_voice_goals",
        "treat_speach_goals",
        "treat_dysphagia_goals",
        "treat_language_goals",
        "aural_rehabilitation_goals",
        "treat_visual_goals",
        "treat_cognitive_goals",
        "other_goals",
        "pain_location1",
        "intensity1",
        "frequency1",
        "description1",
        "aggravating_factors1",
        "pain_location2",
        "intensity2",
        "frequency2",
        "description2",
        "aggravating_factors2",
        "pain_location3",
        "intensity3",
        "frequency3",
        "description3",
        "aggravating_factors3",
        "pain_location4",
        "intensity4",
        "frequency4",
        "description4",
        "aggravating_factors4",
        "pain_location5",
        "intensity5",
        "frequency5",
        "description5",
        "aggravating_factors5",
        "pain_location6",
        "intensity6",
        "frequency6",
        "description6",
        "aggravating_factors6",
        "home_bound_status",
        "other_home_bound_status",
        "ambulates",
        "speech_intelligilibility",
        "voice_quality",
        "swallowing",
        "laryngectomized",
        "non_verbal_comm",
        "verbal_expression",
        "graphic_formulation",
        "auditory_comp",
        "visual_comp",
        "reading_comp",
        "arithmetic_proc",
        "attention_span",
        "memory",
        "thought_organization",
        "problem_solving",
        "orientation",
        "sequencing",
        "scheduling",
        "narrative_response"]


   #validates :notes_and_comments, :presence => true

  after_initialize :create_display_contents

  def create_display_contents
    self.class.create_display_contents(self)
  end

  def self.create_display_contents(doc)
    fields = [:eval_only_with_instruction, :treat_voice, :treat_speach, :treat_dysphagia, :treat_language,
              :aural_rehabilitation, :treat_visual, :treat_cognitive, :other]
    fields.each{|f|
      define_method("#{f}_display") do
        ("<b>Goals : </b>" + doc.send("#{f}_goals")) unless doc.send("#{f}_goals").blank?
      end
    }
  end

  def medical_order_content
    fields = [:eval_only_with_instruction, :treat_voice, :treat_speach, :treat_dysphagia, :treat_language,
              :aural_rehabilitation, :treat_visual, :treat_cognitive, :other]
    fields.reject{|f|
      self.send("#{f}_goals").blank?
    }.collect{|f|
      c = ["#{f.upcase} :"]
      c << ("Goals : " + self.send("#{f}_goals")) unless self.send("#{f}_goals").blank?
      c.join("\n")
    }.join("\n\n")
  end

  def home_bound_status_display
    home_bound_status = []
    home_bound_status += data["home_bound_status"].select{|x| x.to_s != "false"} unless data["home_bound_status"].blank?
    home_bound_status << "<b>Other: </b>"  + self.other_home_bound_status unless self.other_home_bound_status.blank?
    home_bound_status << "<b>Ambulates in ft.: </b>"  + self.ambulates unless self.ambulates.blank?

    home_bound_status.join(', ')
  end

  def speech_voice_display
    status = []
    status << "<b>Speech Intelligilibility:</b> "+intelligilibility_display unless intelligilibility_display.blank?
    status << "<b>Voice Quality:</b> "+voice_quality_display unless voice_quality_display.blank?
    status << "<b>Laryngectomized:</b> "+laryngectomized_display unless laryngectomized_display.blank?
    status << "<b>Swalloing:</b> "+swallowing_display unless swallowing_display.blank?
    status << "<b>Non-verbal Comm:</b> "+non_verbal_comm_display unless non_verbal_comm_display.blank?
    status << "<b>Verbal Expression:</b> "+verbal_expression_display unless verbal_expression_display.blank?
    status << "<b>Graphic Formulation:</b> "+graphic_formulation_display unless graphic_formulation_display.blank?
    status << "<b>Auditory Comp:</b> "+auditory_comp_display unless auditory_comp_display.blank?
    status << "<b>Visual Comp:</b> "+visual_comp_display unless visual_comp_display.blank?
    status << "<b>Reading Comp:</b> "+reading_comp_display unless reading_comp_display.blank?
    status << "<b>Arithmetic Proc:</b> "+arithmetic_proc_display unless arithmetic_proc_display.blank?
    status.join(" ")
  end

  def cognitive_skills_display

    content = []
    content << "<b>Attention Span:</b> "+ data["attention_span"].to_s  unless data["attention_span"].nil?
    content << "<b>Memory:</b> "+ data["memory"].to_s  unless data["memory"].nil?
    content << "<b>Thought:</b> "+ data["thought_organization"].to_s  unless data["thought_organization"].nil?
    content << "<b>Problem-Solving:</b> "+ data["problem_solving"].to_s  unless data["problem_solving"].nil?
    content << "<b>Orientation:</b> "+ data["orientation"].to_s  unless data["orientation"].nil?
    content << "<b>Sequencing:</b> "+ data["sequencing"].to_s  unless data["sequencing"].nil?
    content << "<b>Scheduling:</b> "+ data["scheduling"].to_s  unless data["scheduling"].nil?
    content.join(" ")
  end

  def get_slider_string(value)
    status_numbers = {20 => 'Functional', 40 => 'Mild', 60 => 'Moderate', 80 => 'Severe',
                      100 => 'Extreme'}
    status_numbers[value]
  end

  def intelligilibility_display
    get_slider_string(self.speech_intelligilibility)
  end

  def voice_quality_display
    get_slider_string(self.voice_quality)
  end

  def laryngectomized_display
    get_slider_string(self.laryngectomized)
  end

  def non_verbal_comm_display
    get_slider_string(self.non_verbal_comm)
  end

  def verbal_expression_display
    get_slider_string(self.verbal_expression)
  end

  def graphic_formulation_display
    get_slider_string(self.graphic_formulation)
  end

  def auditory_comp_display
    get_slider_string(self.auditory_comp)
  end

  def visual_comp_display
    get_slider_string(self.visual_comp)
  end

  def reading_comp_display
    get_slider_string(self.reading_comp)
  end

  def arithmetic_proc_display
    get_slider_string(self.arithmetic_proc)
  end

  def attention_span_display
    get_slider_string(self.attention_span)
  end

  def memory_display
    get_slider_string(self.memory)
  end

  def thought_organization_display
    get_slider_string(self.thought_organization)
  end

  def problem_solving_display
    get_slider_string(self.problem_solving)
  end

  def orientation_display
    get_slider_string(self.orientation)
  end

  def scheduling_display
    get_slider_string(self.scheduling)
  end

  def sequencing_display
    get_slider_string(self.sequencing)
  end

  def swallowing_display
    get_slider_string(self.swallowing)
  end

  def header
    (mo_report_flag == true) ? "Speech Therapy Evaluation & Treatment MD Order" : "Speech Therapy Evaluation & Treatment"
  end

  def patient_name_with_mr_display
    details = []
    details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
    details << "<b> MR#:</b> "+ mr unless mr.blank?
    details.join(" ")
  end

  def detail2_label
    "Current Pain"
  end

  def detail2_value
    pain_section_display
  end

  def detail3_label
    "Home Bound Status" unless mo_report_flag
  end

  def detail3_value
    home_bound_status_display unless mo_report_flag
  end

  def detail4_label
    "Eval Only With Instructions"
  end

  def detail4_value
    eval_only_with_instruction_display
  end

  def detail5_label
    "Treat Voice Disorder"
  end

  def detail5_value
    treat_voice_display
  end

  def detail6_label
    "Treat Speech"
  end

  def detail6_value
    treat_speach_display
  end

  def detail7_label
    "Treat Dysphagia"
  end

  def detail7_value
    treat_dysphagia_display
  end

  def detail8_label
    "Treat Language Disorder"
  end

  def detail8_value
     treat_language_display
  end

  def detail9_label
    "Aural Rehabilitation Training"
  end

  def detail9_value
    aural_rehabilitation_display
  end

  def detail10_label
    "Treat Visual Disorder"
  end

  def detail10_value
    treat_visual_display
  end

  def detail11_label
    "Treat Cognitive"
  end

  def detail11_value
    treat_cognitive_display
  end

  def detail12_label
    "Other"
  end

  def detail12_value
    other_display
  end

  def detail13_label
    "Speech Voice"
  end

  def detail13_value
    speech_voice_display
  end

  def detail14_label
    "Cognitive Skills"
  end

  def detail14_value
    cognitive_skills_display
  end

  def detail28_label
    "Narrative/Interventions With Patient/PCG Response:"
  end

  def detail28_value
    narrative_response
  end

  alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    super({ :root => "document" }.merge(options))
    default_options = {:root => "document", :methods => []}
    self.ar_to_xml(options.merge(default_options), &block)
  end

  private

  def set_doc_is_evaluation
    self.doc_is_evaluation = true
  end

end
