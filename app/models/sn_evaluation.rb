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

class SNEvaluation < Document

  WOUND_PRIMARY_ATTRS = ["pressure_ulcer_stage",
      "patient_turned",
      "pelvis_surface",
      "moisture",
      "pressure_gt_30_days",
      "arterial_ulcer",
      "other_wound_type",
      "diabetic_ulcer",
      "bandages_applied",
      "ambulation_encouraged",
      "surgically_created",
      "surgical_procedure",
      "surgical_procedure_date",
      "wound_accident",
      "date_of_accident",
      "accident_type",
      "total_wound_panels"]

   WOUND_DESCRIPTION_ATTRS   = ["wound_type_",
      "wound_age_",
      "wound_location_",
      "wound_tissue_present_",
      "wound_debridement_attempted_",
      "wound_debridement_date_",
      "wound_debridement_type_",
      "wound_debridement_required_",
      "wound_measurement_date_",
      "wound_length_",
      "wound_width_",
      "wound_depth_",
      "wound_appearance_of_wound_",
      "wound_exudate_",
      "wound_thickness_",
      "wound_muscle_",
      "wound_underminig_",
      "wound_undermining_location1_",
      "wound_undermining_from1_",
      "wound_undermining_to1_",
      "wound_undermining_location2_",
      "wound_undermining_from2_",
      "wound_undermining_to2_",
      "wound_tunneling_",
      "wound_tunneling_location1_",
      "wound_tunneling_from1_",
      "wound_tunneling_to1_",
      "wound_tunneling_location2_",
      "wound_tunneling_from2_",
      "wound_tunneling_to2_"
      ]

  store :data, :accessors =>
      ["patient_name",
       "mr",
       "bp",
       "hr",
       "rr",
       "md_name",
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
       "patient_complaints",
       "problems_findings",
       "skilled_interventions",
       "integumentary",
       "integumentary_stage",
       "integumentary_sizes",
       "integumentary_tubes",
       "integumentary_shunt",
       "other_integumentary",
       "eent",
       "other_eent",
       "respiratory",
       "respiratory_sputum_color",
       "respiratory_amount",
       "respiratory_lung_sound",
       "respiratory_clear_bilaterally",
       "respiratory_o2",
       "respiratory_lpm",
       "other_respiratory",
       "musculoskeletal",
       "other_musculoskeletal",
       "gastrointestinal",
       "other_gastrointestinal",
       "appetite",
       "last_bm",
       "diet",
       "tube_feeding",
       "mental",
       "mental_other1",
       "neurological",
       "other_neurological",
       "cardiovascular",
       "other_cardiovascular",
       "pedal_pulses",
       "ankle_location",
       "dorsum_location",
       "edema",
       "genitourinary",
       "other_genitourinary",
       "endocrine",
       "other_endocrine",
       "universal_precautions",
       "other_universal_precautions",
       "home_bound_status",
       "other_home_bound_status",
       "ambulates",
       "pcg",
       "medication",
       "field_staff_name",
       "visit_date",
       "approved_date",
       "time_in",
       "time_out"] + WOUND_PRIMARY_ATTRS + WOUND_DESCRIPTION_ATTRS

  def method_missing(meth, *args, &block)
    if meth.to_s.starts_with?("wound_")
      accessor_name = meth.to_s.ends_with?("=") ? meth.to_s.gsub(/=/,"") : meth.to_s
      self.class_eval {store :data, :accessors => [accessor_name]}
      self.send(meth, *args)
    else
      super
    end
  end

  def wound_values_entered?
    WOUND_PRIMARY_ATTRS.any? {|f| self.send(f).present?}
  end

  def respond_to?(method, include_private = false)
    super || method.to_s.starts_with?("wound_")
  end

  INTENSITY = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
  STAGE = ['1', '2', '3', '4']

  #validates :notes_and_comments, :presence => true

  def eent_display
    ent = []
    ent += data["eent"].select{|x| x.to_s != "false"} unless data["eent"].blank?
    ent << "<b>Other: </b>" + self.other_eent unless self.other_eent.blank?
    ent.join(', ')
  end

  def integumentary_display
    integ = []
    integ += self.integumentary.select{|x| x.to_s != "false"} unless self.integumentary.blank?
    integ << "<b>Stage: </b>" + self.integumentary_stage.to_s unless self.integumentary_stage.blank?
    integ << "<b>Sizes: </b>" + self.integumentary_sizes unless self.integumentary_sizes.blank?
    integ << "<b>Tubes: </b>" + self.integumentary_tubes unless self.integumentary_tubes.blank?
    integ << "<b>Shunt: </b>" + self.integumentary_shunt unless self.integumentary_shunt.blank?
    integ << "<b>Other: </b>" + self.other_integumentary unless self.other_integumentary.blank?
    integ.join(', ')
  end

  def respiratory_display
    respiratory = []
    respiratory  += self.respiratory.select{|x| x.to_s != "false"} unless self.respiratory.blank?
    respiratory << "<b>Sputum Color: </b>" + self.respiratory_sputum_color unless self.respiratory_sputum_color.blank?
    respiratory << "<b>Amount: </b>" + self.respiratory_amount unless self.respiratory_amount.blank?
    respiratory << "<b>Lung Sound: </b>" + self.respiratory_lung_sound unless self.respiratory_lung_sound.blank?
    respiratory << "<b>Clear bilaterally: </b>" + self.respiratory_clear_bilaterally unless self.respiratory_clear_bilaterally.blank?
    respiratory << "<b>O2: </b>" + self.respiratory_o2 unless self.respiratory_o2.blank?
    respiratory << "<b>LPM: </b>" + self.respiratory_lpm unless self.respiratory_lpm.blank?
    respiratory << "<b>Other: </b>" + self.other_respiratory unless self.other_respiratory.blank?
    respiratory.join(', ')
  end


  def musculoskeletal_display
    musculoskeletal = []
    musculoskeletal += data["musculoskeletal"].select{|x| x.to_s != "false"} unless data["musculoskeletal"].blank?
    musculoskeletal << "<b>Other: </b>" + self.other_musculoskeletal unless self.other_musculoskeletal.blank?
    musculoskeletal.join(', ')
  end

  def neurological_display
    neurological = []
    neurological += data["neurological"].select{|x| x.to_s != "false"} unless data["neurological"].blank?
    neurological << "<b>Other: </b>" + self.other_neurological unless self.other_neurological.blank?
    neurological.join(', ')
  end

  def genitourinary_display
    genitourinary = []
    genitourinary += data["genitourinary"].select{|x| x.to_s != "false"} unless data["genitourinary"].blank?
    genitourinary << "<b>Other: </b>" + self.other_genitourinary unless self.other_genitourinary.blank?
    genitourinary.join(', ')
  end

  def universal_precautions_display
    universal = []
    universal += data["universal_precautions"].select{|x| x.to_s != "false"} unless data["universal_precautions"].blank?
    universal << "<b>Other: </b>" + self.other_universal_precautions unless self.other_universal_precautions.blank?
    universal.join(', ')
  end


  def gastrointestinal_display
    gastrointestinal = []
    gastrointestinal += self.gastrointestinal.select{|x| x.to_s != "false"} unless self.gastrointestinal.blank?
    gastrointestinal << "<b>Appetite: </b>" + self.appetite unless self.appetite.blank?
    gastrointestinal << "<b>Last BM: </b>" +self.last_bm unless self.last_bm.blank?
    gastrointestinal << "<b>Diet: </b>" + self.diet unless self.diet.blank?
    gastrointestinal << "<b>Tube Feeding: </b>" + self.tube_feeding unless self.tube_feeding.blank?
    gastrointestinal << "<b>Other: </b>" + self.other_gastrointestinal unless self.other_gastrointestinal.blank?
    gastrointestinal.join(', ')
  end

  def endocrine_display
    endocrine = []
    endocrine += data["endocrine"].select{|x| x.to_s != "false"} unless data["endocrine"].blank?
    endocrine << "<b>Other: </b>" + self.other_endocrine unless self.other_endocrine.blank?
    endocrine.join(', ')
  end

  def home_bound_status_display
    home_bound_status = []
    home_bound_status += data["home_bound_status"].select{|x| x.to_s != "false"} unless data["home_bound_status"].blank?
    home_bound_status << "<b>Other: </b>"  + self.other_home_bound_status unless self.other_home_bound_status.blank?
    home_bound_status << "<b>Ambulates in ft.: </b>"  + self.ambulates unless self.ambulates.blank?

    home_bound_status.join(', ')
  end

  def mental_display
    mental = []
    mental += data["mental"].select{|x| x.to_s != "false"} unless data["mental"].blank?
    mental << "<b>Other: </b>" +  self.mental_other1 unless self.mental_other1.blank?
    mental.join(', ')
  end


  def cardiovascular_display
    cardiovascular = []
    cardiovascular += self.cardiovascular.select{|x| x.to_s != "false"} unless self.cardiovascular.blank?
    cardiovascular << "<b>Pedal pulses: </b>" + pedal_pulses unless self.pedal_pulses.blank?
    cardiovascular << "<b>Edema: </b>" + edema.select{|x| x.to_s != "false"}.join(", ") unless self.edema.blank?
    cardiovascular << "<b>Ankle Location: </b>" + self.ankle_location.select{|x| x.to_s != "false"}.join(", ") unless self.ankle_location.blank?
    cardiovascular << "<b>Dorsum Location: </b>" + self.dorsum_location.select{|x| x.to_s != "false"}.join(", ") unless self.dorsum_location.blank?
    cardiovascular << "<b>Other: </b>" + self.other_cardiovascular unless self.other_cardiovascular.blank?
    cardiovascular.join(', ')
  end


  def wound_pdf
    file_content = Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/wound/wound.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def header
    (mo_report_flag == true) ? "Skilled Nursing Evaluation & Treatment MD Order" : "Skilled Nursing Evaluation & Treatment"
  end

  def patient_name_with_mr_display
    details = []
    details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
    details << "<b> MR#:</b> "+ mr unless mr.blank?
    details.join(" ")
  end

  def medical_order_content
    problems_findings.present?  ? problems_findings : ""
  end

  def detail2_label
    "Current Pain" unless mo_report_flag
  end

  def detail2_value
    pain_section_display unless mo_report_flag
  end

  def detail3_label
    "Home Bound Status" unless mo_report_flag
  end

  def detail3_value
    home_bound_status_display unless mo_report_flag
  end

  def detail4_label
    "Patient Complaints" unless mo_report_flag
  end

  def detail4_value
    patient_complaints unless mo_report_flag
  end

  def detail5_label
    (mo_report_flag  == true) ? "Content" :  "Problems / Significant Findings"
  end

  def detail5_value
    problems_findings
  end

  def detail7_label
    "Integumentary" unless mo_report_flag
  end

  def detail7_value
    integumentary_display unless mo_report_flag
  end

  def detail8_label
    "EENT" unless mo_report_flag
  end

  def detail8_value
    eent_display unless mo_report_flag
  end

  def detail9_label
    "Respiratory" unless mo_report_flag
  end

  def detail9_value
    respiratory_display unless mo_report_flag
  end

  def detail10_label
    "Musculoskeletal" unless mo_report_flag
  end

  def detail10_value
    musculoskeletal_display unless mo_report_flag
  end

  def detail11_label
    "Gastrointestinal" unless mo_report_flag
  end

  def detail11_value
    gastrointestinal_display unless mo_report_flag
  end

  def detail12_label
    "Mental" unless mo_report_flag
  end

  def detail12_value
    mental_display unless mo_report_flag
  end

  def detail13_label
    "Neurological" unless mo_report_flag
  end

  def detail13_value
    neurological_display unless mo_report_flag
  end

  def detail14_label
    "Cardiovascular" unless mo_report_flag
  end

  def detail14_value
    cardiovascular_display unless mo_report_flag
  end

  def detail15_label
    "Genitourinary" unless mo_report_flag
  end

  def detail15_value
    genitourinary_display unless mo_report_flag
  end

  def detail16_label
    "Endocrine" unless mo_report_flag
  end

  def detail16_value
    endocrine_display unless mo_report_flag
  end

  def detail27_label
    "Universal Precautions Utilized" unless mo_report_flag
  end

  def detail27_value
    universal_precautions_display unless mo_report_flag
  end

  def detail28_label
    "Skilled Interventions" unless mo_report_flag
  end

  def detail28_value
    skilled_interventions unless mo_report_flag
  end

  def detail29_label
    "PCG" unless mo_report_flag
  end

  def detail29_value
    "<b> Patient/Family/PCG:</b> " + pcg  unless mo_report_flag
  end

  def detail30_value_medication
    medication
  end


 alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    super({ :root => "document" }.merge(options))
    default_options = {:root => "document", :methods => [:wounds]}
    self.ar_to_xml(options.merge(default_options), &block)
  end


  def wound_panel_indices
    (1..20).to_a.inject([]) do |result, i|
      if(data.has_key?("wound_type_" + i.to_s))
        result << i
      end
      result
    end
  end

  def wounds
    wounds_tags = []
    wound_panel_indices.each do |num|
      wound_tags = {}
      WOUND_DESCRIPTION_ATTRS.each do |attr|
        xml_attr = attr.gsub(/_$/,'')
        xml_val = self.send("#{attr}#{num}")
        wound_tags[xml_attr] = xml_val
      end
      wounds_tags << wound_tags
    end
    wounds_tags << {} if wounds_tags.size == 0
    wounds_tags
  end

  private

  def set_doc_is_evaluation
    self.doc_is_evaluation = true
  end

end
