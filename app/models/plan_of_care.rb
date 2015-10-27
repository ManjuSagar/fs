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

class PlanOfCare < Document
  include ReportHeaderInfo
  store :data, :accessors =>
      ["patient_name",
       "mr",
       "bp",
       "hr",
       "rr",
       "frequency",
       "field_staff_name",
       "visit_date",
       "approved_date",
       "time_in",
       "time_out",
       "md_name",
       "principal_icd1",
       "principal_date1",
       "principal_oe1",
       "principal_icd2",
       "principal_date2",
       "principal_oe2",
       "principal_icd3",
       "principal_date3",
       "principal_oe3",
       "principal_icd4",
       "principal_date4",
       "principal_oe4",
       "principal_icd5",
       "principal_date5",
       "principal_oe5",
       "principal_icd6",
       "principal_date6",
       "principal_oe6",
       "principal_icd10_1",
       "principal_icd10_2",
       "principal_icd10_3",
       "principal_icd10_4",
       "principal_icd10_5",
       "principal_icd10_6",
       "pertinent_icd10_1",
       "pertinent_icd10_2",
       "pertinent_icd10_3",
       "pertinent_icd10_4",
       "pertinent_icd10_5",
       "pertinent_icd10_6",
       "surgical_icd10_1",
       "surgical_icd10_2",
       "surgical_icd10_3",
       "surgical_icd10_4",
       "surgical_icd1",
       "surgical_date1",
       "surgical_oe1",
       "surgical_icd2",
       "surgical_date2",
       "surgical_oe2",
       "surgical_icd3",
       "surgical_date3",
       "surgical_oe3",
       "surgical_icd4",
       "surgical_date4",
       "surgical_oe4",
       "pertinent_icd1",
       "pertinent_date1",
       "pertinent_oe1",
       "pertinent_icd2",
       "pertinent_date2",
       "pertinent_oe2",
       "pertinent_icd3",
       "pertinent_date3",
       "pertinent_oe3",
       "pertinent_icd4",
       "pertinent_date4",
       "pertinent_oe4",
       "pertinent_icd5",
       "pertinent_date5",
       "pertinent_oe5",
       "pertinent_icd6",
       "pertinent_date6",
       "pertinent_oe6",
       "dme",
       "nutritional_req",
       "allergies",
       "functional_limitations",
       "other_functional_limitations",
       "other_dme",
       "activities_permitted",
       "other_activities_permitted",
       "mental_status",
       "mental_status_other1",
       "mental_status_other2",
       "prognosis",
       "safety_measures",
       "orders",
       "goals",
       "miscellaneous",
       "poc_date"]


  #def agency_name
  #  User.current.default_org.to_s
  #end

  validates :poc_date, :presence => true

  after_initialize :prefill_from_oasis, :if => :new_record?

  def functional_limitations_display
    limitations = []
    limitations += data["functional_limitations"].select{|x| x.to_s != "false"} unless data["functional_limitations"].blank?
    limitations << data["other_functional_limitations"] unless data["other_functional_limitations"].blank?
    limitations.join(', ')
  end

  def dme_display
    limitations = []
    limitations += data["dme"].select{|x| x.to_s != "false"} unless data["dme"].blank?
    limitations << data["other_dme"] unless data["other_dme"].blank?
    limitations.join(', ')
  end

  def on_document_ready
    create_medical_order
  end

  def create_medical_order
    return if document_already_attached_to_MD_order?
    order = treatment.medical_orders.build
    order.treatment_episode = treatment_episode
    order.physician = treatment.primary_physician
    order.created_user = User.current
    order.order_status = :draft
    order.order_content = "Attached Plan of Care"
    order.order_type = OrderType.plan_of_care(treatment.patient.org)
    order.order_date = self.document_date
    order.attached_docs.build(document: self)
    order.save!
  end

  def activities_permitted_display
    activities = []
    activities += data["activities_permitted"].select{|x| x.to_s != "false"} unless data["activities_permitted"].blank?
    activities << data["other_activities_permitted"] unless data["other_activities_permitted"].blank?
    activities.join(', ')
  end

  def mental_status_display
    mental_status = []
    mental_status += data["mental_status"].select{|x| x.to_s != "false"} unless data["mental_status"].blank?
    mental_status << data["mental_status_other1"] unless data["mental_status_other1"].blank?
    mental_status << data["mental_status_other2"] unless data["mental_status_other2"].blank?
    mental_status.join(', ')
  end

  def patient_hi_claim_number
    treatment.patient.medicare_number
  end

  def mr_number
    treatment.patient.medicare_number
  end

  def print_ins_details_flag
   treatment.health_agency.health_agency_detail.print_insurance_address? && treatment.private_insurance? && visit_id.present?
  end

  def ins_name
    treatment.insurance_company.company_name
  end

  def ins_contact
     "Tel #{treatment.insurance_company.claim_phone_number}"
  end

  def ins_address
    ins_company = treatment.insurance_company
    address = ins_company.claim_street_address
    suite = ins_company.claim_suite_number
    city = ins_company.claim_city
    state = ins_company.claim_state
    zip_code = ins_company.claim_zip_code
    res = "#{address}, #{suite}, #{city}, #{state} #{zip_code}"
    res
  end

  def provider_number
    "4321"
  end

  def private_ins_print_flag
     treatment.print_insurance_company_contact?
  end

  def ins
    treatment.insurance_company
  end

  def provider_name
    return private_ins_print_flag ? ins.full_name.to_s.upcase : super
  end

  def provider_contact
    if private_ins_print_flag
      "<b>Phone </b>" + ins.claim_phone_number unless ins.claim_phone_number.blank?
    else
      super
    end
  end

  def provider_full_address
      return private_ins_print_flag ? ins_agency_address : super
  end

  
    def ins_agency_address
      ins_agency_address_line1 + ", " + ins_agency_address_line2
    end

    def ins_agency_address_line1
      street = []
      if private_ins_print_flag
        street << ins.claim_street_address unless ins.claim_street_address.blank?
        street << "Suite " + ins.claim_suite_number unless ins.claim_suite_number.blank?
        street.join(", ")
      else
        agency_address_line1
      end
    end

    def ins_agency_address_line2
      street = []
      if private_ins_print_flag
        street << ins.claim_city unless ins.claim_city.blank?
        street << ["#{ins.claim_state} #{ins.claim_zip_code}"].reject { |x| x.blank? }
        street.join(", ")
      else
        agency_address_line2
      end
    end

  def disclaimer
    "I certify/recertify that this patient is confined to his/her home and needs intermittent skilled nursing care, physical therapy and/or speech therapy or continues to need occupational therapy. The patient is under my care, and I have authorized the services on this plan of care and will periodically review this plan. Anyone who misrepresents, falsifies, or conceals essential information required for payment of Federal funds may be subject to fine, imprisonment, or civil penalty under applicable Federal laws."
  end

  def patient_name
    treatment.patient.full_name
  end

  def mr #temporary fix
    treatment.patient.patient_reference
  end

  def physician_contact
    physician = treatment.primary_physician
    contact = ""
    contact = "<b>Tel</b> #{physician.phone_number}" if physician.phone_number.present?
    contact += ", " if physician.phone_number && physician.fax_number
    contact += "<b>Fax</b> #{physician.fax_number}" if physician.fax_number.present?
    contact
  end

  PRINCIPAL_ICD_CODES = ["principal_icd1", "principal_icd2", "principal_icd3", "principal_icd4", "principal_icd5", "principal_icd6"]

  PRINCIPAL_ICD10_CODES = ["principal_icd10_1", "principal_icd10_2", "principal_icd10_3", "principal_icd10_4", "principal_icd10_5", "principal_icd10_6"]

  def get_principal_icd_codes
    res = PRINCIPAL_ICD_CODES.collect{|x| self.send(x)}.reject(&:blank?)
  end

  def get_primary_diagnosis_code
    get_principal_icd_codes.first
  end

   def formatted_date
     poc_date = self.poc_date
     formatted_date = poc_date.gsub('/','-')
     final_date = Date.parse(formatted_date[3..4]+"-"+formatted_date[0..1]+"-"+formatted_date[6..9])
   end

   def icd_type
     (formatted_date >= Date.parse('01-10-2015'))? 'ICD 10 CM' : 'ICD 9 CM'
   end

  def principle_icd_codes
    (formatted_date >= Date.parse('01-10-2015')? get_codes_hash(PRINCIPAL_ICD10_CODES, 'icd10') : get_codes_hash(PRINCIPAL_ICD_CODES, 'icd9'))
  end

  def pertinent_icd_codes
    pertinent_icd10_codes = ["pertinent_icd10_1", "pertinent_icd10_2", "pertinent_icd10_3", "pertinent_icd10_4", "pertinent_icd10_5",
                             "pertinent_icd10_6"]
    pertinent_codes = ["pertinent_icd1", "pertinent_icd2", "pertinent_icd3", "pertinent_icd4", "pertinent_icd5", "pertinent_icd6"]

    (formatted_date >= Date.parse('01-10-2015'))?  get_codes_hash(pertinent_icd10_codes, 'icd10') : get_codes_hash(pertinent_codes, 'icd9')
  end

  def surgical_icd_codes
    surgical_codes = ["surgical_icd1", "surgical_icd2", "surgical_icd3", "surgical_icd4"]
    surgical_codes10 = ["surgical_icd10_1", "surgical_icd10_2", "surgical_icd10_3", "surgical_icd10_4"]
    (formatted_date >= Date.parse('01-10-2015'))?  get_codes_hash(surgical_codes10, 'icd10') : get_codes_hash(surgical_codes, 'icd9')
  end

  def get_codes_hash(icd_codes, type)
    diagnostic_codes_list = []
    icd_codes.each_with_index do |icd, index|
      icd_code = self.send(icd)
      icd_oe = self.send(icd.split("_").first + "_oe#{index+1}")
      icd_date = self.send(icd.split("_").first + "_date#{index+1}")
      description = icd.start_with?("surgical")? get_surgical_icd_code_description(icd_code, type) : get_icd_code_description(icd_code, type)
      diagnostic_codes_list << {icd_code: icd_code, description: description, oe: icd_oe, icd_date:icd_date} unless [icd_code, icd_oe, icd_date].all?{|x| x.blank?}
    end
    diagnostic_codes_list
  end

  def poc_icd_diag_list
    principle_icd_codes + pertinent_icd_codes
  end

  def physician_address
    physician = treatment.primary_physician
    address = []
    address << physician.street_address unless physician.street_address.blank?
    address << "Suite #{physician.suite_number}" unless physician.suite_number.blank?
    address << physician.city unless physician.city.blank?
    address.join(", ")
  end

  def physician_city_details
    physician = treatment.primary_physician
    address = []
    address << physician.state unless patient.state.blank?
    address << physician.zip_code unless patient.zip_code.blank?
    address.join(" ")
  end

  def physician_full_address
    physician_address + ' ' + physician_city_details
  end

  def physician_signature_date
    "9/3/2011"
  end

  def date_hha_received_signed_POT
    "9/3/2011"
  end

  def medications
    medications_arr = []
    active_medications = treatment.active_medications_as_on_date(Date.strptime(poc_date, "%m/%d/%Y"))
    active_medications.each do |medication|
      medications_hash = {}
      medications_hash["name"] = medication.medication_name
      medications_hash["dosage_form"] = medication.dosage_form if medication.dosage_form.present?
      medications_hash["frequency"] = medication.frequency if medication.frequency.present?
      medications_hash["code"] = medication.medication_code if medication.medication_code.present?
      medications_hash["start_date"] = medication.start_date.strftime("%m/%d/%Y") if  medication.start_date.present?
      medications_arr << medications_hash  unless medication.medication_name.blank?
    end
    medications_arr
  end

  def medication_subreport_url
    "#{Rails.root}/app/views/reports/plan_of_care/medications_subreport.jasper"
  end

  def poc_icd_diag_list_subreport_url
    "#{Rails.root}/app/views/reports/plan_of_care/poc_icd_codes.jasper"
  end

  def surgical_codes_subreport_url
    "#{Rails.root}/app/views/reports/plan_of_care/surgical_codes.jasper"
  end

  def poc_safety_dme_list_subreport_url
    "#{Rails.root}/app/views/reports/plan_of_care/dme_supplies_safety_list.jasper"
  end

  def order_goals_misc_display_subreport_url
    "#{Rails.root}/app/views/reports/plan_of_care/order_goals_misc.jasper"
  end

  def advanced_directives_display
    "<b>Advanced Directives</b> " +treatment.patient.advanced_directives_display
  end

  def dnr_dni_display
    "<b>DNR/DNI</b> " +treatment.patient.dnr_dni_display
  end

  def adv_dir_and_dnr_dni_display
    "#{advanced_directives_display} #{dnr_dni_display}"
  end


  def poc_safety_dme_list
    list = []
    list << {name: "DME and Supplies", description: dme_display} unless dme_display.blank?
    list << {name: "Safety Measures", description: safety_measures} unless safety_measures.blank?
    list << {name: "Nutrition", description: nutritional_req} unless nutritional_req.blank?
    list << {name: "Allergies", description: allergies} unless allergies.blank?
    list << {name: "Functional Limitations", description: functional_limitations_display} unless functional_limitations_display.blank?
    list << {name: "Activities Permitted", description: activities_permitted_display} unless activities_permitted_display.blank?
    list << {name: "Mental Status", description: mental_status_display} unless mental_status_display.blank?
    list << {name: "Prognosis", description: prognosis} unless prognosis.blank?
    list
  end

  def order_goals_misc_display
    list = []
    list << {name: "Orders for Discipline and Treatments (Specify Amount/Frequency/Duration)", description: orders} unless orders.blank?
    list << {name: "Goals/Rehabilation Potential/Discharge Plans", description: goals} unless goals.blank?
    list << {name: "Miscellaneous", description: miscellaneous} unless miscellaneous.blank?
    list
  end

  def to_xml(options = {})
    super :methods => [:agency_name,
                       :icd_type,
                       :print_ins_details_flag,
                       :ins_name,
                       :ins_contact,
                       :ins_address,
                       :functional_limitations_display,
                       :dme_display,
                       :activities_permitted_display,
                       :mental_status_display,
                       :patient_hi_claim_number,
                       :start_of_care_date,
                       :certification_period_from,
                       :certification_period_to,
                       :mr_number,
                       :provider_number,
                       :patient_address,
                       :provider_address,
                       :date_of_birth,
                       :gender,
                       :physician_address,
                       :physician_signature_date,
                       :date_hha_received_signed_POT,
                       :patient_name,
                       :physician_name,
                       :provider_name,
                       :medications,
                       :patient_details,
                       :patient_contact,
                       :start_of_care_date_details,
                       :provider_contact,
                       :medication_subreport_url,
                       :physician_contact,
                       :physician_city_details,
                       :provider_city_details,
                       :provider_full_address,
                       :physician_full_address,
                       :physician_short_info,
                       :advanced_directives_display,
                       :dnr_dni_display,
                       :poc_icd_diag_list,
                       :surgical_icd_codes,
                       :poc_icd_diag_list_subreport_url,
                       :surgical_codes_subreport_url,
                       :poc_safety_dme_list,
                       :order_goals_misc_display,
                       :poc_safety_dme_list_subreport_url,
                       :order_goals_misc_display_subreport_url,
                       :adv_dir_and_dnr_dni_display,
                       :physician_npi_number,
                       :physician_display
                      ]
  end

  def is_poc?
    true
  end

  def hide_refresh_button
    [:pending_qa, :approved].include? self.status
  end

  def poc_diagnoses(treatment, treatment_episode)
    principal_icd1 = self.principal_icd1
    diagnosis = []
    if treatment and treatment_episode
      oasis  = treatment_episode.oasis_evaluation_or_recertification_or_roc_document
      if oasis
        diagnosis << {icd_number: "1", icd_value: oasis.m1020_primary_diag_icd}
        1.upto(5) do |i|
          oasis_diagnosis = oasis.send("m1022_oth_diag#{i}_icd")
          diagnosis << {icd_number: "#{i+1}", icd_value: oasis_diagnosis}
        end
        diagnosis << {icd_number: "10_1", icd_value: oasis.m1021_primary_diag_icd}
        1.upto(5) do |i|
          oasis_diagnosis = oasis.send("m1023_oth_diag#{i}_icd")
          diagnosis << {icd_number: "10_#{i+1}", icd_value: oasis_diagnosis}
        end
      end
    end
    diagnosis
  end

  private

  def prefill_from_oasis
    if treatment and treatment_episode
      oasis  = treatment_episode.oasis_evaluation_or_recertification_or_roc_document
      if oasis
        self.principal_icd1 = oasis.m1020_primary_diag_icd
        self.principal_icd2 = oasis.m1022_oth_diag1_icd
        self.principal_icd3 = oasis.m1022_oth_diag2_icd
        self.principal_icd4 = oasis.m1022_oth_diag3_icd
        self.principal_icd5 = oasis.m1022_oth_diag4_icd
        self.principal_icd6 = oasis.m1022_oth_diag5_icd
        self.surgical_icd1 = oasis.m1012_inp_prcdr1_icd
        self.surgical_icd2 = oasis.m1012_inp_prcdr2_icd
        self.surgical_icd3 = oasis.m1012_inp_prcdr3_icd
        self.surgical_icd4 = oasis.m1012_inp_prcdr4_icd
        self.principal_icd10_1 = oasis.m1021_primary_diag_icd
        self.principal_icd10_2 = oasis.m1023_oth_diag1_icd
        self.principal_icd10_3 = oasis.m1023_oth_diag2_icd
        self.principal_icd10_4 = oasis.m1023_oth_diag3_icd
        self.principal_icd10_5 = oasis.m1023_oth_diag4_icd
        self.principal_icd10_6 = oasis.m1023_oth_diag5_icd

        sync = OasisPocSync.new(oasis, self)
        self.dme = sync.dme_supplies
        self.other_dme = sync.other_dme_supplies
        self.functional_limitations = sync.functional_limitation_content
        self.other_functional_limitations = sync.other_functional_limitations_content
        self.activities_permitted = sync.activities_permitted
        self.other_activities_permitted = sync.other_activities_permitted
        self.mental_status = sync.metal_status_content
        self.mental_status_other1 = sync.other_mental_status_content
        self.prognosis = sync.prognosis_content
        self.nutritional_req = sync.nutritional_requirement_content
        self.allergies = sync.allergies
        self.prognosis = sync.prognosis_content
        self.safety_measures = sync.safety_measures_content
        self.goals = sync.goals_content
        self.miscellaneous = sync.miscellaneous_content

      end
    end
  end

=begin
  def set_allergies
    if treatment and treatment_episode
      previous_episode = treatment.previous_episode(treatment_episode)
      previous_poc  = treatment.documents.order("id DESC").detect{|x| x.is_a? PlanOfCare and (x.treatment_episode == treatment_episode or x.treatment_episode == previous_episode)}
      if previous_poc
        self.allergies = previous_poc.allergies
      end
    end
  end
=end
end
