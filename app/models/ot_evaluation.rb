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

class OTEvaluation < Document
  store :data, :accessors =>
      ["patient_name",
       "mr",
       "bp",
       "hr",
       "rr",
       "md_name",
       "rom_rue_details",
       "rom_rue_goals",
       "rom_rue_orders",
       "rom_lue_details",
       "rom_lue_goals",
       "rom_lue_orders",
       "strength_rue_details",
       "strength_rue_goals",
       "strength_rue_orders",
       "strength_lue_details",
       "strength_lue_goals",
       "strength_lue_orders",
       "coordination_rue_details",
       "coordination_rue_goals",
       "coordination_rue_orders",
       "coordination_lue_details",
       "coordination_lue_goals",
       "coordination_lue_orders",
       "sensation_rue_details",
       "sensation_rue_goals",
       "sensation_rue_orders",
       "sensation_lue_details",
       "sensation_lue_goals",
       "sensation_lue_orders",
       "vision_details",
       "vision_goals",
       "vision_orders",
       "balance_details",
       "balance_goals",
       "balance_orders",
       "endurance_details",
       "endurance_goals",
       "endurance_orders",
       "other1_details",
       "other1_goals",
       "other1_orders",
       "other2_details",
       "other2_goals",
       "other2_orders",
       "other3_details",
       "other3_goals",
       "other3_orders",
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
       "grasp",
       "fine_motor",
       "gross_motor",
       "sharp",
       "proprioception",
       "stereognosis",
       "Feeding",
       "grooming",
       "ub_dressing",
       "lb_dressing",
       "bathing",
       "toileting",
       "toilet_transfer",
       "bathing_transfer",
       "meal_preparation",
       "household_chores",
       "other_caption",
       "other",
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
       "other_interventions",
       "education",
       "edu_presented",
       "verbalized",
       "not_verbalized",
       "notes_and_comments",
       "field_staff_name",
       "visit_date",
       "approved_date",
       "time_in",
       "time_out"]

  after_initialize :create_display_contents

  def create_display_contents
    self.class.create_display_contents(self)
  end

  def self.create_display_contents(doc)
    fields = [:rom_rue, :rom_lue, :strength_rue, :strength_lue, :coordination_rue, :coordination_lue,
                :sensation_rue, :sensation_lue, :vision, :balance, :endurance, :other1, :other2, :other3]
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

  def medical_order_content
    fields = [:rom_rue, :rom_lue, :strength_rue, :strength_lue, :coordination_rue, :coordination_lue,
              :sensation_rue, :sensation_lue, :vision, :balance, :endurance, :other1, :other2, :other3]
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

  def functional_limitations_display
    limitations = []
    limitations += data["functional_limitations"].select{|x| x.to_s != "false"} unless data["functional_limitations"].blank?
    limitations << data["other_functional_limitations"] unless data["other_functional_limitations"].blank?
    limitations.join(', ')
  end

  def equipments_display
    data["equipments"].select{|x| x.to_s != "false"}.join(', ') unless data["equipments"].blank?
  end

  def msc_display
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

  def education_display
    education = []
    arr = []
    education += data["education"].select{|x| x.to_s != "false"} unless data["education"].blank?
    arr << education
    arr << "<b>Education Presented to:</b> " + edu_presented_order unless edu_presented_order.blank?
    arr.join(" ")
  end

  def edu_presented_order
    data["edu_presented"].select{|x| x.to_s != "false"}.join(', ') unless data["edu_presented"].blank?
  end



  def interventions_display
    data["interventions"].select{|x| x.to_s != "false"}.join(', ') unless data["interventions"].blank?
  end

  def edu_presented_display
    data["edu_presented"].select{|x| x.to_s != "false"}.join(', ')  unless data["edu_presented"].blank?
  end

  def poc_display
    data["poc"].select{|x| x.to_s != "false"}.join(', ') unless data["poc"].blank?
  end

  def ue_function_display
    status = []
    status << "<b>Grasp and pinch:</b> "+ue_grasp_display unless ue_grasp_display.blank?
    status << "<b>Stereognosis:</b> "+ue_stereognosis_display unless ue_stereognosis_display.blank?
    status << "<b>Gross motor coordination:</b> "+ue_gross_motor_display unless ue_gross_motor_display.blank?
    status << "<b>Sharp/dull sensation:</b> "+ue_sharp_display unless ue_sharp_display.blank?
    status << "<b>Proprioception:</b> "+ue_proprioception_display unless ue_proprioception_display.blank?
    status << "<b>Fine motor coordination:</b> "+ue_fine_motor_display unless ue_fine_motor_display.blank?
    status.join(" ")
  end

  def functional_status_display
    content = []
    content << "<b>Feeding:</b> "+ data["feeding"]  unless data["feeding"].blank?
    content << "<b>Grooming/hygiene:</b> "+ data["grooming"]  unless data["grooming"].blank?
    content << "<b>UB dressing:</b> "+ data["ub_dressing"]  unless data["ub_dressing"].blank?
    content << "<b>LB dressing:</b> "+ data["lb_dressing"]  unless data["lb_dressing"].blank?
    content << "<b>Bathing:</b> "+ data["bathing"]  unless data["bathing"].blank?
    content << "<b>Toileting:</b> "+ data["toileting"]  unless data["toileting"].blank?
    content << "<b>Toilet transfer:</b> "+ data["toilet_transfer"]  unless data["toilet_transfer"].blank?
    content << "<b>Bathing transfer:</b> "+ data["bathing_transfer"]  unless data["bathing_transfer"].blank?
    content << "<b>Meal preparation:</b> "+ data["meal_preparation"]  unless data["meal_preparation"].blank?
    content << "<b>Household chores:</b> "+ data["household_chores"]  unless data["household_chores"].blank?
    content << "<b>other_caption:</b> " + data["other_caption"] unless data["other_caption"].blank?
    content.join(" ")
  end

  def misc_findings_display
    misc = []
    misc << "<b>Prior Level Of Function:</b> " + data[:misc_msc] unless data[:misc_msc].blank?
    misc << "<b>Rehab potential:</b> "+ data[:rehab] unless data[:rehab].blank?
    misc << "<b> POC Established With:</b> " + poc_order unless poc_order.blank?
    misc.join(" ")
  end

  def poc_order
    data["poc"].select{|x| x.to_s != "false"}.join(', ') unless data["poc"].blank?
  end

  def get_ue_function_string(value)
    status_numbers = {14.28 => 'Poor', 28.6 => 'Between poor & fair', 42.84 => 'Fair', 57.1 => 'Between fair & good',
                      71.4 => 'Good', 85.7 => 'Between good & normal', 99.96 => 'Normal'}
    status_numbers[value]
  end

  def ue_grasp_display
    get_ue_function_string(self.grasp)
  end

  def ue_fine_motor_display
    get_ue_function_string(self.fine_motor)
  end

  def ue_gross_motor_display
    get_ue_function_string(self.gross_motor)
  end

  def ue_sharp_display
    get_ue_function_string(self.sharp)
  end

  def ue_proprioception_display
    get_ue_function_string(self.proprioception)
  end

  def ue_stereognosis_display
    get_ue_function_string(self.stereognosis)
  end

  def patient_name_with_mr_display
    debug_log patient_name
    details = []
    details << "<b>Patient Name: </b> " + patient_name unless patient_name.blank?
    details << "<b> MR#:</b> "+ mr unless mr.blank?
    details.join(" ")
  end

  def header
    (mo_report_flag == true)? "Occupational Therapy Evaluation & Treatment MD Order" :  "Occupational Therapy Evaluation & Treatment"
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
    "ROM-RUE"
  end

  def detail4_value
    rom_rue_display
  end

  def detail5_label
    "ROM-LUE"
  end

  def detail5_value
    rom_lue_display
  end

  def detail6_label
    "Strength-RUE"
  end

  def detail6_value
   strength_rue_display
  end

  def detail7_label
    "Strength-LUE(0-5)"
  end

  def detail7_value
    strength_lue_display
  end

  def detail8_label
    "Coordination-RUE"
  end

  def detail8_value
    coordination_rue_display
  end

  def detail9_label
    "Coordination-LUE"
  end

  def detail9_value
    coordination_lue_display
  end

  def detail10_label
    "Sensation-RUE"
  end

  def detail10_value
    sensation_rue_display
  end

  def detail11_label
    "Sensation-LUE"
  end

  def detail11_value
    sensation_lue_display
  end

  def detail12_label
    "Vision/perception"
  end

  def detail12_value
    vision_display
  end

  def detail13_label
    "Balance-sit/stand"
  end

  def detail13_value
    balance_display
  end

  def detail14_label
    "Endurance"
  end

  def detail14_value
    endurance_display
  end

  def detail15_label
    "Other"
  end

  def detail15_value
    other1_display
  end

  def detail16_label
    "Other"
  end

  def detail16_value
    other2_display
  end

  def detail17_label
    "Other"
  end

  def detail17_value
    other3_display
  end

  def detail18_label
    "UE Function"
  end

  def detail18_value
    ue_function_display
  end

  def detail19_label
    "Functional Status: ADL"
  end

  def detail19_value
    functional_status_display
  end

  def detail20_label
    "Functional Limitations"
  end

  def detail20_value
    functional_limitations_display
  end

  def detail21_label
    "Equipment in the Patient's Home"
  end

  def detail21_value
    equipments_display
  end

  def detail22_label
    "Mental/Social/Cognition"
  end

  def detail22_value
    msc_display
  end

  def detail23_label
    "Misc. Findings"
  end

  def detail23_value
    misc_findings_display
  end

  def detail24_label
    "Interventions/Teachings"
  end

  def detail24_value
    interventions_display
  end

  def detail25_label
    "Education"
  end

  def detail25_value
    education_display
  end

  def detail28_label
    "Notes and Comments"
  end

  def detail28_value
    notes_and_comments
  end

  def notes_and_comments_display
    notes_and_comments
  end

  def detail29_label
    "PCG"
  end

  def detail29_value
    "<b> Patient/Family/PCG:</b> " + data["verbalized"] unless data["verbalized"].blank?
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
