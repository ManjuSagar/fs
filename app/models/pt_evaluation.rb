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

class PTEvaluation < Document

  TINETTI_ATTRIBUTES = ["sitting_balance",
                        "arises",
                        "attempts_to_arise",
                        "immediate_standing_balance",
                        "standing_balance",
                        "nudged",
                        "eyes_closed",
                        "turning_360_degrees",
                        "turning_360_degrees_b",
                        "sitting_down",
                        "initiation_of_gait",
                        "right_swing_foot",
                        "right_swing_foot_b",
                        "left_swing_foot",
                        "left_swing_foot_b",
                        "step_symmetry",
                        "step_continuity",
                        "path",
                        "trunk",
                        "walking_stance",
                        "balance_score",
                        "gait_score",
                        "total",
                        "rater"]
  store :data, :accessors =>
      ["patient_name",
       "mr",
       "bp",
       "hr",
       "rr",
       "md_name",
       "rom_cervical_details",
       "rom_cervical_goals",
       "rom_cervical_orders",
       "rom_trunk_details",
       "rom_trunk_goals",
       "rom_trunk_orders",
       "rom_ue_details",
       "rom_ue_goals",
       "rom_ue_orders",
       "rom_le_details",
       "rom_le_goals",
       "rom_le_orders",
       "strength_cervical_details",
       "strength_cervical_goals",
       "strength_cervical_orders",
       "strength_trunk_details",
       "strength_trunk_goals",
       "strength_trunk_orders",
       "strength_ue_details",
       "strength_ue_goals",
       "strength_ue_orders",
       "strength_le_details",
       "strength_le_goals",
       "strength_le_orders",
       "balance_details",
       "balance_goals",
       "balance_orders",
       "transfers_details",
       "transfers_goals",
       "transfers_orders",
       "gait_details",
       "gait_goals",
       "gait_orders",
       "endurance_details",
       "endurance_goals",
       "endurance_orders",
       "other1_details",
       "other1_goals",
       "other1_orders",
       "other2_details",
       "other2_goals",
       "other2_orders",
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
       "ambulation",
       "coordination",
       "endurance",
       "gross",
       "strength",
       "roll",
       "supine_sit",
       "sit_supine",
       "toilet",
       "sit_stand",
       "car",
       "shower",
       "functional_limitations",
       "other_functional_limitations",
       "equipments",
       "msc",
       "msc_other1",
       "msc_other2",
       "misc_msc",
       "home_bound_status",
       "other_home_bound_status",
       "ambulates",
       "poc",
       "rehab",
       "interventions",
       "modalities",
       "modalities_other1",
       "modalities_other2",
       "education",
       "edu_other1",
       "edu_other2",
       "edu_presented",
       "verbalized",
       "not_verbalized",
       "notes_and_comments",
       "field_staff_name",
       "visit_date",
       "approved_date",
       "time_in",
       "time_out",
       ] + TINETTI_ATTRIBUTES
    after_initialize :create_display_contents

    def create_display_contents
      self.class.create_display_contents(self)
    end

    def self.create_display_contents(doc)
      fields = [:rom_cervical, :rom_trunk, :rom_ue, :rom_le, :strength_cervical, :strength_trunk, :strength_ue,
                :strength_le, :balance, :transfers, :gait, :endurance, :other1, :other2]
      fields.each{|f|
        content = []
        ["details", "goals", "orders"].each{|fi|
          field = doc.send("#{f}_#{fi}")
          content << ("<b>#{fi.capitalize} : </b>" + field) if (field.present? and field.class.name != "Syck::PrivateType")
        }
        content = content.join(" ")
        define_method("#{f}_display") do
          content
        end
      }
    end


  validates :notes_and_comments, :presence => true, :if => :is_same_class?

  def is_same_class?
    self.class.name == "PTEvaluation"
  end

  def tinetti_fields_entered?
    TINETTI_ATTRIBUTES.any?{|f| self.send(f).present? }
  end

  def functional_limitations_order
    limitations = []
    limitations += data["functional_limitations"].select{|x| x.to_s != "false"} unless data["functional_limitations"].blank?
    limitations << data["other_functional_limitations"] unless data["other_functional_limitations"].blank?
    limitations.join(', ')
  end

  def equipments_order
    data["equipments"].select{|x| x.to_s != "false"}.join(', ') unless data["equipments"].blank?
  end

  def msc_order
    msc = []
    msc += data["msc"].select{|x| x.to_s != "false"} unless data["msc"].blank?
    msc << data["msc_other1"] unless data["msc_other1"].blank?
    msc << data["msc_other2"] unless data["msc_other2"].blank?
    msc.join(', ')
  end

  def home_bound_status_display
    home_bound_status = []
    home_bound_status += data["home_bound_status"].select{|x| x.to_s != "false"} unless data["home_bound_status"].blank?
    home_bound_status << "<b>Other: </b>"  + self.other_home_bound_status unless self.other_home_bound_status.blank?
    home_bound_status << "<b>Ambulates in ft.: </b>"  + self.ambulates unless self.ambulates.blank?

    home_bound_status.join(', ')
  end

  def education_order
    education = []
    arr = []
    education += data["education"].select{|x| x.to_s != "false"} unless data["education"].blank?
    education << data["edu_other1"] unless data["edu_other1"].blank?
    education << data["edu_other2"] unless data["edu_other2"].blank?
    arr << education.join(', ')
    arr << "<b>Education Presented to:</b> " + edu_presented_order unless edu_presented_order.blank?
    arr.join(" ")
  end

  def functional_status_display
    content = []
    content << "<b>Bed mobility:Roll/scoot:</b> "+ data["roll"]  unless data["roll"].blank?
    content << "<b>Bed mobility: Supine-sit:</b> "+ data["supine_sit"]  unless data["supine_sit"].blank?
    content << "<b>Bed mobility: Sit-supine:</b> " +  data["sit_supine"] unless data["sit_supine"].blank?
    content << "<b>Transfer :Toilet:</b> " +  data["toilet"] unless data["toilet"].blank?
    content << "<b>Transfer: Sit-Stand :</b> " +  data["sit_stand"] unless data["sit_stand"].blank?
    content << "<b>Transfer: Car:</b> " +  data["car"] unless data["car"].blank?
    content << "<b>Transfer: Shower:</b> " +  data["shower"] unless data["shower"].blank?
    content.join(" ")
  end

  def misc_findings_display
    misc = []
    misc << "<b>Prior Level Of Function:</b> " + data[:misc_msc] unless data[:misc_msc].blank?
    misc << "<b>Rehab potential:</b> "+ data[:rehab] unless data[:rehab].blank?
    misc << "<b> POC Established With:</b> " + poc_order unless poc_order.blank?
    misc.join(" ")
  end


  def physical_status_display
    status = []
    status << "<b>Ambulation</b> "+ps_ambulation_display unless ps_ambulation_display.blank?
    status << "<b>Coordination:</b> "+ ps_coordination_display  unless ps_coordination_display.blank?
    status << "<b>Endurance:</b> " + ps_endurance_display unless ps_endurance_display.blank?
    status << "<b>Gross Motor:</b> " + ps_gross_display unless ps_gross_display.blank?
    status << "<b>Strength:</b> " + ps_strength_display unless ps_strength_display.blank?
    status.join(" ")
  end

  def interventions_order
    data["interventions"].select{|x| x.to_s != "false"}.join(', ') unless data["interventions"].blank?
  end

  def modalities_order
    modalities = []
    modalities += data["modalities"].select{|x| x.to_s != "false"} unless data["modalities"].blank?
    modalities << data["modalities_other1"] unless data["modalities_other1"].blank?
    modalities << data["modalities_other2"] unless data["modalities_other2"].blank?
    modalities.join(', ')
  end

  def edu_presented_order
    data["edu_presented"].select{|x| x.to_s != "false"}.join(', ') unless data["edu_presented"].blank?
  end

  def poc_order
    data["poc"].select{|x| x.to_s != "false"}.join(', ') unless data["poc"].blank?
  end

  def get_physical_status_string(value)
    status_numbers = {14.28 => 'Poor', 28.6 => 'Between poor & fair', 42.84 => 'Fair', 57.1 => 'Between fair & good',
                      71.4 => 'Good', 85.7 => 'Between good & normal', 99.96 => 'Normal'}
    status_numbers[value]
  end

  def ps_ambulation_display
    get_physical_status_string(self.ambulation)
  end

  def ps_coordination_display
    get_physical_status_string(self.coordination)
  end

  def ps_endurance_display
    get_physical_status_string(self.endurance)
  end

  def ps_gross_display
    get_physical_status_string(self.gross)
  end

  def ps_strength_display
    get_physical_status_string(self.strength)
  end

  def patient_name_with_mr_display
    details = []
    details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
    details << "<b> MR#:</b> "+ mr unless mr.blank?
    details.join(" ")
  end

  def medical_order_content
    fields = [:rom_cervical, :rom_trunk, :rom_ue, :rom_le, :strength_cervical, :strength_trunk, :strength_ue,
              :strength_le, :balance, :transfers, :gait, :endurance, :other1, :other2]
    fields.reject{|f|
      self.send("#{f}_details").blank? and self.send("#{f}_goals").blank? and self.send("#{f}_orders").blank?
    }.collect{|f|
      c = ["#{f.upcase} :"]
      c << ("Details : " + self.send("#{f}_details")) unless self.send("#{f}_details").blank?
      c << ("Goals : " + self.send("#{f}_goals")) unless self.send("#{f}_goals").blank?
      c << ("Orders : " + self.send("#{f}_orders")) unless self.send("#{f}_orders").blank?
      c.join("\n")
    }.join("\n\n")
  end


  def tinetti_pdf
    file_content = Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/tinetti/tinetti.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
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
    "ROM-Cervical"
  end

  def detail4_value
    rom_cervical_display
  end

  def detail5_label
    "ROM-Trunk"
  end

  def detail5_value
    rom_trunk_display
  end

  def detail6_label
    "ROM-UE"
  end

  def detail6_value
    rom_ue_display
  end

  def detail7_label
    "ROM-LE"
  end

  def detail7_value
    rom_le_display
  end

  def detail8_label
    "Strength-Cervical"
  end

  def detail8_value
    strength_cervical_display
  end

  def detail9_label
    "Strength-Trunk"
  end

  def detail9_value
    strength_trunk_display
  end

  def detail10_label
    "Strength-UE"
  end

  def detail10_value
    strength_ue_display
  end

  def detail11_label
    "Strength-LE"
  end

  def detail11_value
    strength_le_display
  end

  def detail12_label
    "Balance"
  end

  def detail12_value

  end

  def detail13_label
    "Transfers"
  end

  def detail13_value
    transfers_display
  end

  def detail14_label
    "Gait"
  end

  def detail14_value
    gait_display
  end

  def detail15_label
    "Endurance"
  end

  def detail15_value
    endurance_display
  end


  def detail16_label
    "Other"
  end

  def detail16_value
    other1_display
  end

  def detail17_label
    "Other"
  end

  def detail17_value
    other2_display
  end

  def detail18_label
    "Physical Status"
  end

  def detail18_value
    physical_status_display
  end

  def detail19_label
    "Functional Status"
  end

  def detail19_value
    functional_status_display
  end

  def detail20_label
    "Functional Limitations"
  end

  def detail20_value
    functional_limitations_order
  end

  def detail21_label
    "Equipment in the Home"
  end

  def detail21_value
    equipments_order
  end

  def detail22_label
    "Mental/Social/Cognition"
  end

  def detail22_value
    msc_order
  end

  def detail23_label
    "MISC. Findings"
  end

  def detail23_value
    misc_findings_display
  end

  def detail24_label
    "Interventions"
  end

  def detail24_value
    interventions_order
  end

  def detail25_label
    "Modalities"
  end

  def detail25_value
    modalities_order
  end

  def detail26_label
    "Education"
  end

  def detail26_value
    education_order
  end

  def detail28_label
    "Notes and Comments"
  end

  def detail28_value
    notes_and_comments_display
  end

  def notes_and_comments_display
    notes_and_comments
  end

  def detail29_label
    "Patient/Family/PCG"
  end

  def detail29_value
    data["verbalized"] unless data["verbalized"].blank?
  end

  def header
    (mo_report_flag == true)? "Physical Therapy Evaluation & Treatment MD Order" : "Physical Therapy Evaluation & Treatment"
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
