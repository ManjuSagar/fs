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

require 'jasper-rails'
class Document < ActiveRecord::Base
  include JasperRails
  include SignDocument
  include UsersHelper
  include VitalsDisplay
  include ReportHeaderInfo
  belongs_to :document_definition
  belongs_to :document_form_template
  belongs_to :physician
  belongs_to :treatment_episode
  belongs_to :treatment, :class_name => "PatientTreatment"
  belongs_to :treatment_visit, :foreign_key => :visit_id
  belongs_to :created_user, :class_name => "User"
  belongs_to :field_staff
  belongs_to :supervised_user, :class_name => "FieldStaff"
  belongs_to :signed_user, :class_name => "FieldStaff"
  has_many :document_notes, :dependent => :destroy
  has_many :medical_order_document_attachments, :class_name => "MedicalOrderDocumentAttachment", :dependent => :destroy
  belongs_to :agency_approved_user, :class_name => "User"
  has_many :receivables, :as => :source, :dependent => :destroy
  has_many :all_documents, :as => :documentable, :dependent => :delete_all
  has_many :oasis_exports, :foreign_key => :document_id, :dependent => :destroy, :order => "exported_date_time DESC"
  after_save :update_denormalized_patient_list_if_required?

  scope :org_scope, lambda { |org = Org.current| includes(:treatment_episode => {:treatment => {:patient => :patient_detail}}).where({:patient_details => {:org_id => org.id}}) if org}
  scope :oasis, lambda {org_scope.where(["document_type in (?)", OASIS_DOCUMENTS])}
  scope :special_documents, lambda {org_scope.where(["document_type in (?)", SPECIAL_DOCUMENTS])}

  self.inheritance_column = :document_type

  audited :associated_with => :treatment, :allow_mass_assignment => true

  before_create :lock_document_form_template, :set_treatment_info, :set_created_user, :set_initial_flags_value
  after_initialize :set_defaults, :if => :new_record?
  after_initialize :set_doc_is_evaluation, :set_report_fields_default_values
  before_validation :set_field_staff_and_supervised_user
  after_initialize :pre_populate_patient_and_visit_info, :if => :new_record?
  before_create :create_all_document, :set_field_staff_and_supervised_user_to_docs
  after_save :update_all_documents_if_required, :unless => :new_record?
  after_destroy :update_all_documents_if_required, :unless => :new_record?
  after_destroy :update_denormalized_patient_list_if_required?, :unless => :new_record?
  after_save :sign_the_document_if_required

  validates :field_staff, :presence => true, :if => :field_staff_not_there?
  validates :treatment_episode, :presence => true, :if => :treatment_episode_not_there?
  validates :document_date, :presence => true, :if => :visit_not_present?
  validates :supervised_user, :presence => true, :if => :field_staff_is_dependent?
  validates :physician, :presence => true
  validate :frequency_string_format

  netzke_attribute :document_class_name
  netzke_attribute :document_name

  attr_accessor :mo_report_flag, :skip_callbacks, :fs_change_from_visit_create, :doc_is_evaluation, :draft_save

  OASIS_DOCUMENTS = ["OasisEvaluation", "OasisResumptionOfCare", "OasisTransferredPatientWithDischarge",
                     "OasisTransferredPatientWithoutDischarge","OasisDeathAtHome", "OasisDischargeFromAgency",
                     "OasisOtherFollowup", "OasisRecertification"]

  SPECIAL_DOCUMENTS = OASIS_DOCUMENTS + ["PlanOfCare"]

  GROUPING_POINTS_2015 = {'1' => {'C' => ['4+ C', '2-3 B', '0-1 A'], 'F' => ['16+ H', '15 G', '0-14 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '2' => {'C' => ['8+ C', '2-7 B', '0-1 A'], 'F' => ['14+ H', '4-13 G', '0-3 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '3' => {'C' => ['2+ C', '1 B', '0 A'], 'F' => ['11+ H', '10 G', '0-9 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '4' => {'C' => ['13+ C', '6-12 B', '0-5 A'], 'F' => ['8+ H', '1-7 G', '0 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '5' => {'C' => ['17+ C', '4-16 B', '0-3 A'], 'F' => ['6+ H', '3-5 G', '0-2 F'], 'S' => ['N/A','N/A','N/A','N/A','20 K']}
                         }
  GROUPING_POINTS_2014 = {'1' => {'C' => ['9+ C', '5-8 B', '0-4 A'], 'F' => ['7+ H', '6 G', '0-5 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '2' => {'C' => ['15+ C', '7-14 B', '0-6 A'], 'F' => ['8+ H', '7 G', '0-6 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '3' => {'C' => ['6+ C', '3-5 B', '0-2 A'], 'F' => ['10+ H', '9 G', '0-8 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '4' => {'C' => ['17+ C', '9-16 B', '0-8 A'], 'F' => ['9+ H', '8 G', '0-7 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '5' => {'C' => ['15+ C', '8-14 B', '0-7 A'], 'F' => ['8+ H', '7 G', '0-6 F'], 'S' => ['N/A','N/A','N/A','N/A','20 K']}
                         }
  store :data, :accessors =>
      [
        "physician_name",
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
        "valid",
        "subm_hipps_code",
        "subm_hipps_version",
        "field_signature_not_required",
        "treatment_authorization_code",
        "previous_unlock_reason",
        "frequency"
      ]

  netzke_attribute :valid, type: :boolean
  netzke_attribute :draft_save, type: :boolean
  STATE_MACHINE_MAP = {'1' => "NewOasisDocWorkflow", '2' => "KeyFieldCorrectionWorkflow",
                       '3' => "NonKeyFieldCorrectionWorkflow", '4' => "DocRejectedWorkflow",
                       '5' => "ClinicalCorrectionWorkflow", '6' => "RegularDocWorkFlow"}

  STATE_MAP = {:draft => 'D', :pending_qa => "QA", :approved => 'A',
               :exported => 'E', :clinical_adjustment => "CA",  :key_fields_adjustment => "KA",
               :non_key_fields_adjustment => "NA", :export_rejected => "ER" }

  NON_KEY_FIELD = '3'
  INACTIVATION = '2'
  REJECTED = '4'
  CLINICAL_FIELD = '5'

  def update_denormalized_patient_list_if_required?
    patient = self.treatment.patient
    d = DenormalizedPatientList.where(:patient_id => patient.id, :org_id => Org.current.id).first
    if d.present?
      DenormalizedPatientList.update_with(self.treatment.patient)
    else
      DenormalizedPatientList.create_with(self.treatment.patient)
    end
  end

  def add_reject_export_document_event_to_notes
    create_document_note("Export Rejected")
  end

  def set_signed_user
    self.signed_user = User.current
  end

  def is_visit_document?
    self.visit_id?
  end

  def set_agency_approved_user
    self.agency_approved_user = User.current
  end

  def add_non_key_fields_adjustment_document_event_to_notes
    create_document_note("Unlock Document - Non Key fields Adjustment")
  end

  def add_key_fields_adjustment_document_event_to_notes
    create_document_note("Unlock Document - Key Fields Adjustment")
  end

  def add_clinical_adjustment_document_event_to_notes
    create_document_note("Unlock Document - Clinical Adjusted")
  end

  def add_sign_document_event_to_notes
    create_document_note("Signed")
  end

  def add_approved_document_event_to_notes
    create_document_note("Approved the Document")
  end

  def add_edit_document_event_to_notes
    create_document_note("Edited")
  end

  def add_corrrection_request_document_event_to_notes
    create_document_note("Requested Correction")
  end

  def add_exported_document_event_to_notes
    create_document_note("Exported")
  end

  def create_document_note(msg)
    document_notes.create({notes: msg, event_changed: true})
  end

  def comment_added
    self.request_correction! if self.may_request_correction?
    nil
  end

  def current_user_is_field_staff?
    User.current == field_staff
  end

  def current_user_is_office_staff
    User.current.is_a? OrgStaff
  end

  def document_exported
    self.reload
    self.export! if self.may_export?
    nil
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if (v.present? and attr.to_sym == :status)
    write_attribute_without_mapping(attr, v)
  end

  attr_accessor :system_driven_event

  def system_driven_event?
    self.system_driven_event == true
  end

  def set_unlock_reason(reason)
    begin
      self.class.paper_trail_on!
      self.previous_unlock_reason = self.unlock_reason if self.unlock_reason != REJECTED
      self.unlock_reason = reason
      self.state_machine_id = reason
      change_status_to_adjustment
      if non_key_field_correction?
        self.correction_num = correction_num.nil? ? 1 : (correction_num + 1)
      elsif key_field_correction?
        self.correction_num = 0
      end
      set_original_values
      self.save(:validation => false)
      set_record_type
    ensure
      self.class.paper_trail_off!
    end
  end

  def change_status_to_adjustment
    if key_field_correction?
      add_key_fields_adjustment_document_event_to_notes
    elsif non_key_field_correction?
      add_non_key_fields_adjustment_document_event_to_notes
    elsif rejected_correction?
      add_reject_export_document_event_to_notes
    elsif clinical_field_correction?
      add_clinical_adjustment_document_event_to_notes
    end
    self.fs_sign_required = true
    self.supervisor_sign_required = supervisor_present?
    self.status = :draft
  end

  def set_record_type
    export_record = latest_exported_record
    if export_record
      if rejected_correction?
        export_record.reject!
      elsif key_field_correction?
        create_oasis_export(nil, OasisExport::INACTIVE_CHAR)
      end
    end
  end

  def can_not_edit_clinical_fields?
    if self.draft? and state_machine_id == '1'
      false
    else
      not clinical_field_correction?
    end
  end

  def init_draft?
    self.draft? and state_machine_id == '1'
  end

  def clinical_field_correction?
    self.state_machine_id == CLINICAL_FIELD
  end

  def key_field_correction?
    self.state_machine_id == INACTIVATION
  end

  def xnon_key_field_correction?
    self.state_machine_id == NON_KEY_FIELD
  end

  def rejected_correction?
    self.state_machine_id == REJECTED
  end

  def non_key_field_correction?
    res = self.unlock_reason == NON_KEY_FIELD
    res = (res or self.previous_unlock_reason == NON_KEY_FIELD) if rejected_correction?
    res
  end

  def soc_date_key_field?
    (self.is_a? OasisEvaluation) ? non_key_field_correction? : false
  end

  def roc_date_key_field?
    (self.is_a? OasisResumptionOfCare) ? non_key_field_correction? : false
  end

  def info_completed_date_key_field?
    ["OasisRecertification", "OasisFollowUp"].include?(self.class.name) ? non_key_field_correction? : false
  end

  def dc_trnas_dth_date_key_field?
    ["OasisTransferredPatientWithDischarge", "OasisTransferredPatientWithoutDischarge","OasisDeathAtHome", "OasisDischargeFromAgency"].include?(self.class.name) ? non_key_field_correction? : false
  end

  def field_signature_not_required?
    if (created_user == field_staff)
      false
    else
      field_signature_not_required == true
    end
  end

  def field_staff_signature_not_required?
    self.fs_sign_required == false and self.supervisor_sign_required == false
  end

  def field_signature_required?
    (not field_signature_not_required?)
  end
  
  def valid_document?
     valid == true
  end

  def is_super_visory_doc?
    self.document_type == 'SuperVisoryVisit'
  end

  def not_private_ins_doc?
    treatment.medicare?
  end

  def private_ins_document?
    treatment.private_insurance?
  end

  def not_valid_document?
    (not valid_document?)
  end

  def sign_the_document_if_required
    if(sign_password and signature_date)
      if current_user_is_visited_fs?
        self.fs_sign_date = signature_date
        self.sign! if may_sign?
      elsif current_user_is_supervised_user?
        self.supervised_user_sign_date = signature_date
        self.sign! if may_sign?
      end
    end
  end

  def field_staff_is_dependent?
    return false unless field_staff
    field_staff.independent_fs? == false
  end

  def change_visit_status
    return nil unless treatment_visit
    treatment_visit.document_is_signed
  end

  def field_staff_not_there?
    return false if treatment_visit
    field_staff_id.nil?
  end

  def treatment_episode_not_there?
    return false if treatment_visit
    treatment_episode_id.nil?
  end

  def on_document_ready
    # Expected to be overridden by sub classes
  end

  def field_staff_signature_required?
    fs_sign_required
  end

  def field_staff_signed
    fs_sign_required
  end

  def supervisor_signature_required?
    supervisor_sign_required
  end

  def supervisor_signed
    supervisor_sign_required
  end

  def visited_staff_is_a_staffing_company
    return false unless treatment_visit
    treatment_visit.visited_staff_is_a_staffing_company
  end

  def valid_doc_and_current_user_is_office_staff_and_hipps_code_required_doc?
    valid_document? and current_user_is_office_staff? and hipps_code_required_doc?
  end

  def oasis_eval_document?
    ["OasisEvaluation", "OasisRecertification", "OasisResumptionOfCare"].include?(self.class.name)
  end

  def only_field_staff_signature_required?
    fs_sign_required == true and supervisor_sign_required == false
  end

  def field_staff_and_supervisor_signature_required?
    health_agency_co_sign_optional? ? (fs_sign_required == true and supervisor_sign_required == true) : false
  end

  def health_agency_co_sign_optional?
    treatment.co_signature_optional?
  end

  def only_supervisor_signature_required?
    supervisor_sign_required == true && fs_sign_required == false
  end

  def current_user_is_supervised_user?
    User.current == supervised_user
  end

  def visit_not_present?
    treatment_visit.nil?
  end

  def supervisor_not_present?
    not supervisor_present?
  end

  def supervisor_present?
    supervised_user.present?
  end


  def field_staff_signature
    if treatment_visit.present?
      ((not field_staff_signature_required?) and fs_sign_date and treatment_visit.visited_staff_signature) ? treatment_visit.visited_staff_signature_path : nil
    else
      ((not field_staff_signature_required?) and field_staff.present? and fs_sign_date and field_staff.signature?)? field_staff.signature.path : nil
    end
  end

  def visited_staff_name
    if treatment_visit.present?
      treatment_visit.visited_staff_full_name
    else
      field_staff.present? ? field_staff.full_name : nil
    end
  end

  def current_user_is_clinical_staff?
    User.current.field_staff? and User.current.clinical_staff.present?
  end

  def supervised_user_name
    if treatment_visit.present?
      (is_super_visory_doc?) ? supervised_user.full_name : treatment_visit.supervised_user_full_name
    else
      supervised_user.present? ? supervised_user.full_name : nil
    end
  end

  def supervised_user_signature
    if treatment_visit.present? and (not is_super_visory_doc?)
    ((not supervisor_signature_required?) and treatment_visit.supervised_user.present? and self.supervised_user_sign_date and treatment_visit.supervised_user.signature?) ? treatment_visit.supervised_user.signature.path : nil 
    else
      ((not supervisor_signature_required?) and supervised_user.present? and supervised_user_sign_date and supervised_user.signature?)? supervised_user.signature.path : nil
    end
  end

  def get_correction_for_form
    unlock_reason.present? ? correction_num.to_s : false
  end

  def editable?
    res = false
    res = self.may_edit_document_by_default?
    res == true
  end

  def deletable?
    res = false
    res = self.may_delete_document?
    res == true
  end

  def status
    STATE_MAP.invert[read_attribute(:status)]
  end

  def document_class_name
    document_form_template.document_class_name
  end

  def document_name
    document_definition and document_definition.document_name
  end

  def patient
    treatment.patient
  end

  def medical_order_content
    ""
  end

  def systolic_bp
    treatment_visit.systolic_bp if treatment_visit
  end

  def diastolic_bp
    treatment_visit.diastolic_bp if treatment_visit
  end

  def bp_read_location
    treatment_visit.bp_read_location if treatment_visit
  end

  def bp_read_position
    treatment_visit.bp_read_position if treatment_visit
  end

   def heart_rate
    treatment_visit.heart_rate if treatment_visit
  end

   def respiration_rate
    treatment_visit.respiration_rate if treatment_visit
  end

  def temperature_in_fht
    treatment_visit.temperature_in_fht if treatment_visit
  end

  def blood_sugar
    treatment_visit.blood_sugar if treatment_visit
  end

  def sugar_read_period
    treatment_visit.sugar_read_period_display if treatment_visit
  end

   def weight_gain_loss_in_lbs
    treatment_visit.weight_in_lbs if treatment_visit
  end

  def oxygen_saturation
    treatment_visit.oxygen_saturation if treatment_visit
  end

  def pain
    treatment_visit.pain if treatment_visit
  end

  def pain_section_display
    pain_section_attrs = ["pain_location", "intensity", "frequency", "description","aggravating_factors"]
    contents = []
    6.times.each do |i|
      location = self.send("#{pain_section_attrs[0]}#{i+1}")
      intensity = self.send("#{pain_section_attrs[1]}#{i+1}")
      frequency = self.send("#{pain_section_attrs[2]}#{i+1}")
      description = self.send("#{pain_section_attrs[3]}#{i+1}")
      factor = self.send("#{pain_section_attrs[4]}#{i+1}")
      content = "#{i+1}. "  if (location.present? || intensity.present? || frequency.present? || description.present? || factor.present? )
      content += "<b>Location:</b>"  + " #{location} " unless location.nil?
      content += "<b>Intensity (0 - 10):</b>" + " #{intensity} " unless intensity.nil?
      content += "<b>Frequency:</b>"  +  " #{frequency} " unless frequency.nil?
      content += "<b>Description:</b>"  + " #{description} " unless description.nil?
      content += "<b>Aggravating factors:</b>" + " #{factor} " unless factor.nil?
      contents << content unless content.nil?
    end
      contents.join("<br>")
  end

  def frequency_display
    frequency
  end

  def fs_signed_date_display
    fs_sign_date.strftime("%m/%d/%Y") if fs_sign_date.present?
  end

  def supervised_user_signed_date_display
      supervised_user_sign_date.strftime("%m/%d/%Y") if supervised_user_sign_date.present?
  end

  def show_physician
    physician = treatment.primary_physician
    (mo_report_flag == true) ? (physician.full_name if physician) : nil
  end

  def therapist_name_display
    "<b>Field Staff: </b> " + visited_staff_name unless visited_staff_name.blank?
  end

  def supervised_user_name_display
    "<b>supervised Staff: </b> " + supervised_user_name unless supervised_user_name.blank?
  end

  def date_time_display
    display = []
    visit = treatment_visit
    if visit
      display << "<b> Date:</b> "+ visit.visit_date.strftime("%m/%d/%Y")
      display << "<b> In: </b> "+ formatted_time_display(visit.visit_start_time)
      display << "<b> Out: </b> "+ formatted_time_display(visit.visit_end_time)
    end
    display.join(" ")
  end

  def formatted_time_display(time)
    time.strftime("%H:%M")
  end

  def visit_frequency
    frequency
  end

  def medical_order_to_xml
    [:vitals_display, :fs_signed_date_display, :detail2_label, :detail2_value, :detail3_label, :detail3_value,
     :detail4_label, :detail4_value, :detail5_label, :detail5_value, :detail6_label, :detail6_value, :detail7_label,
     :detail7_value, :detail8_label, :detail8_value, :detail9_label, :detail9_value, :detail10_label, :detail10_value,
     :detail11_label, :detail11_value, :detail12_label, :detail12_value, :detail13_label, :detail13_value, :detail14_label,
     :detail14_value, :detail15_label, :detail15_value, :detail28_label, :detail28_value, :detail29_label, :detail29_value,
     :detail30_value_medication, :show_physician, :header, :patient_name_with_mr_display, :date_time_display, :field_staff_signature, :field_staff_signed,
     :supervisor_signed, :visited_staff_name, :visit_frequency,  :systolic_bp, :diastolic_bp, :bp_read_location, :bp_read_position, :heart_rate,
     :respiration_rate, :temperature_in_fht, :blood_sugar, :sugar_read_period, :weight_gain_loss_in_lbs, :oxygen_saturation,
     :agency_name, :frequency_display, :supervised_user_signature, :supervised_user_name,
     :supervised_user_signed_date_display, :supervisor_signed, :agency_name_for_visit_document
    ]
  end

  def document_report_xml_fields
    fields = [
              :pain_section_display,
              :pain,
              :functional_limitations_order,
              :equipments_order,
              :msc_order,
              :education_order,
              :interventions_order,
              :modalities_order,
              :edu_presented_order,
              :ps_ambulation_display,
              :ps_coordination_display,
              :ps_endurance_display,
              :ps_gross_display,
              :ps_strength_display,
              :functional_status_display,
              :physical_status_display,
              :misc_findings_display,
              :detail16_label,
              :detail16_value,
              :detail17_label,
              :detail17_value,
              :detail18_label,
              :detail18_value,
              :detail19_label,
              :detail19_value,
              :detail20_label,
              :detail20_value,
              :detail21_label,
              :detail21_value,
              :detail22_label,
              :detail22_value,
              :detail23_label,
              :detail23_value,
              :detail24_label,
              :detail24_value,
              :detail25_label,
              :detail25_value,
              :detail26_label,
              :detail26_value,
              :detail27_label,
              :detail27_value,
              :therapist_name_display,
              :supervised_user_name_display
    ]
    (mo_report_flag == true) ? medical_order_to_xml : (medical_order_to_xml + fields)
  end

  def to_xml(options = {})
    options[:methods] = (options[:methods] || []) +  document_report_xml_fields
    super options
  end

  def oasis_document?
    self.class.included_modules.include?(OasisExtension)
  end

  def non_oasis_document?
    not oasis_document?
  end

  def to_pdf
    report_file_name = document_form_template.report_file_name
    file_content =  Jasper::Rails.render_pdf("#{Rails.root.to_s}/app/views/reports/#{report_file_name}/#{report_file_name}.jasper", self, {}, {})
    file = File.open(tempfile, "w")
    file.binmode
    file.write(file_content)
    file.close
    File.absolute_path(file)
  end

  def combined_reports
    pdfs = []
    pdfs << self.to_pdf
    pdfs << self.tinetti_pdf if self.is_a? PTEvaluation and self.tinetti_fields_entered?
    pdfs << self.wound_pdf if self.is_a? SNEvaluation and self.wound_values_entered?
    combined_pdf_file = "#{tempfile}.pdf"
    require 'pdf_merger'
    PdfMerger.new.merge(pdfs, combined_pdf_file)
    combined_pdf_file
  end

  def text_in_bold(text)
    "<style isBold='true'>#{text}</style>"
  end

  def set_sign_date(date)
    if current_user_is_visited_fs?
      self.fs_sign_date = date
    elsif current_user_is_supervised_user?
      self.supervised_user_sign_date = date
    elsif current_user_is_office_staff?
      self.os_sign_date = date
    end
    self.save
  end


  def current_user_is_visited_fs?
    User.current == field_staff
  end

  def pending_signature?
    pending_staff_signature? || pending_field_staff_signature? || pending_supervisor_signature?
  end

  def generate_hipps_code
    return unless hipps_code_required_doc?
    return if treatment.private_insurance?
    episode = self.treatment_episode
    score = calculate_hipps_code
    if score.present?
      self.subm_hipps_code = score.hipps_code
      self.subm_hipps_version = score.hipps_code_version
      self.treatment_authorization_code = score.treatment_authorization_code
      self.save!
    else
      raise "HIPPS code is not found for this OASIS Document."
    end
  end

  def inform_episode_doc_completed
    rap_invoice = treatment_episode.invoices.where(:invoice_type => '322').first
    return if rap_invoice.present? and treatment_episode.rap_generated_document != self.id
    return unless hipps_code_required_doc?
    episode = self.treatment_episode.reload
    episode.document_is_completed(self)
  end

  def hipps_code_required_doc?
    (oasis_evaluation? or oasis_recertification? or oasis_resumption_of_care?)
  end

  def set_field_staff_and_supervised_user_to_docs
    SyncInfoVisitAndDocument.document_created(self)
  end


  def create_oasis_export_if_required
    if oasis_document? and !ready_for_export_present?
      return if clinical_field_correction?
      record_type, corr_number = if (oasis_exports.empty? or (key_field_correction?) )
                      [OasisExport::ORIGINAL_CHAR, nil]
                    elsif non_key_field_correction?
                     [OasisExport::CORRECTION_CHAR, correction_num]
                    elsif rejected_correction?
                      if (correction_num.nil? or correction_num == 0)
                        [OasisExport::ORIGINAL_CHAR, nil]
                      else
                        [OasisExport::CORRECTION_CHAR, correction_num]
                      end
                    end

      create_oasis_export(corr_number, record_type)
    end
  end

  def create_oasis_export(corr_number, record_type)
    rec = oasis_exports.build({:correction_num => corr_number, :record_type => record_type, insurance_company_id: treatment.insurance_company.id})
    rec.save!
    rec.system_driven_event = true
    rec.mark_as_ready_for_export! if rec.may_mark_as_ready_for_export?
    rec.system_driven_event = false
    nil
  end

  def ready_for_export_present?
    ready_for_export.present?
  end

  def ready_for_export
    oasis_exports.where("export_status = ? AND record_type <> ?", OasisExport::READY_FOR_EXPORT, OasisExport::INACTIVE_CHAR).first
  end

  def mark_episode_ready_to_bill
    return unless treatment.medicare?
    if hipps_code_required_doc?
      treatment_episode.system_driven_event = true
      treatment_episode.mark_as_ready_for_billing! if treatment_episode.may_mark_as_ready_for_billing?
      treatment_episode.system_driven_event = false
    end
  end

  def evaluation_document?
    self.doc_is_evaluation == true
  end

  def do_as_eval(str)
    eval(str, binding)
  end

  def self.netzke_combo_options_for(column, options = {})
    procedure_code = procedure_code?(column)
    ProspectivePaymentSystem::PPSGrouper.icd_code_list({procedure_code: procedure_code, diagnostic_code: (not procedure_code), column: column}.merge(options))
  end

  def self.netzke_combo_options_for_census_report(params)
    value = params[:query]
    array = []
    array += ProspectivePaymentSystem::Icd10DiagnosticCode.where("lower(icd_code) like '%#{value}%' or lower(short_description) like '%#{value}%' or lower(long_description) like '%#{value}%'").limit(25).collect{|x| [x.icd_code, x.send(:to_s)]}
    array += ProspectivePaymentSystem::Icd9DiagnosticCode.where("lower(icd_code) like '%#{value}%' or lower(short_description) like '%#{value}%' or lower(long_description) like '%#{value}%'").limit(25).collect{|x| [x.icd_code, x.send(:to_s)]}
    array
  end

  def self.procedure_code?(column)
    surgical_fields = ["surgical_icd1", "surgical_icd2", "surgical_icd3", "surgical_icd4", "surgical_icd10_1","surgical_icd10_2",
                       "surgical_icd10_3", "surgical_icd10_4"]
    (surgical_fields.include?(column) or column.to_s.start_with?("m1012"))
  end

  def self.check_fields_value(params)
    fields = params[:fields]
    values = params[:values]
    suffixes = params[:suffixes]
    panel_numbers = params[:panel_numbers]
    doc_type = params[:doc_type]
    episode_id = params[:episode_id]
    episode = TreatmentEpisode.find(episode_id) if episode_id
    errors = []
    return errors unless fields
    fields.each_with_index do |field, index|
      next if values[index].blank?
      code = field[0..4].to_sym
      if [:m0030, :m0032, :m0090, :m0903, :m0906].include?(code)
        res = field_is_with_in_episode_range?(field, values[index], episode, doc_type)
        if(res.empty? == false)
          res << panel_numbers[index] if panel_numbers
          errors << res
        end
      elsif valid_icd_code(field, values[index]).empty?
        err = get_error_message_for_field(field, suffixes[index],values[index])
        err << panel_numbers[index] if panel_numbers
        errors << err
      end
    end
    errors
  end

  def self.field_is_with_in_episode_range?(field, value, episode, doc_type)
    res = []
    #TODO: Document info completed validation removed, Since document date and info completed date should be same.
=begin
    code = field[0..4].to_sym
    value = Date.parse(value)
    if field.start_with?("m0090") and ['04'].include?(doc_type)
      #previous_episode = episode.treatment.previous_episode(episode)
      #if (previous_episode.present? and ((value < (previous_episode.end_date - 4)) or value > previous_episode.end_date))
       # res = ["M0090", "Date Assessment Completed must be with in #{previous_episode.end_date - 4} and #{previous_episode.end_date}"]
      #end
    else
      result = (value < episode.start_date or value > episode.end_date)
      if result
        case code
          when :m0090
            res = [code.to_s.upcase, "Date Assessment Completed must be with in certification period"]
          when :m0032
            res = [code.to_s.upcase, "Resumption of Care Date must be with in certification period"]
          when :m0903
            res = [code.to_s.upcase, "Date of Last(Most Recent) Home visit must be with in certification period"]
          when :m0906
            res = [code.to_s.upcase, "Discharge/Transfer/Death Date must be with in certification period"]
        end
      end
    end
=end
    res
  end

  def self.get_error_message_for_field(field, suffix, val)
    procedure_code_columns = [:m1012]
    diagnostic_code_columns = [:m1010, :m1011, :m1016, :m1017, :m1020, :m1022, :m1024, :m1021, :m1025]
    if diagnostic_code_columns.any?{|code| field.starts_with?(code.to_s)}
      code_type = diagnostic_code_columns.detect{|code| field.starts_with?(code.to_s)}
      field_in_upcase = code_type.to_s.upcase + " " + suffix
		value = val[0].upcase	
      case code_type
        when :m1010, :m1016, :m1024 #v and e codes not allowed
          [field_in_upcase, "ICD9 Diagnostic code is invalid."]
        when :m1011, :m1017, :m1025          
          if value == 'V' || value == 'W' || value == 'X' || value == 'Y' ||value == 'Z' 
            [field_in_upcase, "ICD-10 Diagnostic V, W, X, Y, Z codes are not allowed."]
          else
            [field_in_upcase, "ICD-10 Diagnostic code is invalid."]
          end
        when :m1020 #v codes allowed
          [field_in_upcase, "ICD9 Diagnostic code is invalid."]
        when :m1022 #v and e codes are allowed
          [field_in_upcase, "ICD9 Diagnostic code is invalid."]
        when :m1021
          if value == 'V' || value == 'W' || value == 'X' || value == 'Y' 
            [field_in_upcase, "ICD-10 Diagnostic V, W, X, Y codes are not allowed."]
          else
            [field_in_upcase, "ICD-10 Diagnostic code is invalid."]
          end           
      end
    elsif procedure_code_columns.any?{|code| field.starts_with?(code.to_s)}
      code_type = procedure_code_columns.detect{|code| field.starts_with?(code.to_s)}
      [code_type.to_s.upcase + " " + suffix, "ICD9 Procedure code is invalid."]
    end
  end

  def self.valid_icd_code(field, value)
    procedure_code_columns = [:m1012]
    diagnostic_code_columns = [:m1010, :m1011, :m1016, :m1017, :m1020, :m1022, :m1024, :m1021, :m1025]
    if diagnostic_code_columns.any?{|code| field.starts_with?(code.to_s)}
      code_type = diagnostic_code_columns.detect{|code| field.starts_with?(code.to_s)}
      case code_type
        when :m1011, :m1017, :m1025 #v w x y z not allowed
          ProspectivePaymentSystem::PPSGrouper.diagnostic_code_present?({icd_code: value, v_code: false, w_code: false, x_code: false, y_code: false, z_code: false})
        when :m1010, :m1016, :m1024 #v and e codes not allowed
          ProspectivePaymentSystem::PPSGrouper.diagnostic_code_present?({icd_code: value, e_code: false, v_code: false})
        when :m1020 #v codes allowed
          ProspectivePaymentSystem::PPSGrouper.diagnostic_code_present?({icd_code: value, e_code: false, v_code: true})
        when :m1022 #v and e codes are allowed
          ProspectivePaymentSystem::PPSGrouper.diagnostic_code_present?({icd_code: value, e_code: true, v_code: true})
        when :m1021
          ProspectivePaymentSystem::PPSGrouper.diagnostic_code_present?({icd_code: value, v_code: false, w_code: false, x_code: false, y_code: false})
       end
    elsif procedure_code_columns.any?{|code| field.starts_with?(code.to_s)}
      ProspectivePaymentSystem::PPSGrouper.procedure_code_present?({icd_code: value})
    else
      []
    end
  end

  def self.assessment_reason_list
    [["01", "Start of Care - further visits planned"],
     ["03", "Resumption of Care(after inpatient stay)"],
     ["04", "Recertification (follow-up) reassessment"],
     ["05", "Other follow-up"],
     ["06", "Transferred to an inpatient facility - patient not discharged from agency"],
     ["07", "Transferred to an inpatient facility - patient discharged from agency"],
     ["08", "Death at home"],
     ["09", "Discharge from agency"]]
  end

  def oasis_recertification?
    self.is_a? OasisRecertification
  end

  def completed?
    (self.approved? or self.exported?)
  end

  def oasis_recertification_and_valid?
    oasis_recertification? and valid_document? and completed?
  end

  def oasis_resumption_of_car_and_valid?
    oasis_resumption_of_care? and valid_document? and completed?
  end

  def oasis_evaluation?
    self.document_type == "OasisEvaluation"
  end

  def oasis_evaluation_and_valid?
    oasis_evaluation? and valid_document? and completed?
  end

  def oasis_transfer_without_dc_and_valid?
    oasis_transfer_without_dc? and valid_document? and completed?
  end

  def oasis_transfer_without_dc?
    self.is_a? OasisTransferredPatientWithoutDischarge
  end

  def oasis_resumption_of_care?
    self.is_a? OasisResumptionOfCare
  end

  def oasis_rc?
    self.is_a? OasisRecertification
  end

  def check_icd9_fields(doc)
    arr = []
    arr << doc.m1020_primary_diag_icd if doc.m1020_primary_diag_icd.present?
    arr << doc.m1022_oth_diag1_icd if doc.m1022_oth_diag1_icd.present?
    arr << doc.m1022_oth_diag2_icd if doc.m1022_oth_diag2_icd.present?
    arr << doc.m1022_oth_diag3_icd if doc.m1022_oth_diag3_icd.present?
    arr << doc.m1022_oth_diag4_icd if doc.m1022_oth_diag4_icd.present?
    arr << doc.m1022_oth_diag5_icd if doc.m1022_oth_diag5_icd.present?
    arr
  end

  def check_icd10_fields(doc)
    arr = []
    arr << doc.m1021_primary_diag_icd if doc.m1021_primary_diag_icd.present?
    arr << doc.m1023_oth_diag1_icd if doc.m1023_oth_diag1_icd.present?
    arr << doc.m1023_oth_diag2_icd if doc.m1023_oth_diag2_icd.present?
    arr << doc.m1023_oth_diag3_icd if doc.m1023_oth_diag3_icd.present?
    arr << doc.m1023_oth_diag4_icd if doc.m1023_oth_diag4_icd.present?
    arr << doc.m1023_oth_diag5_icd if doc.m1023_oth_diag5_icd.present?
    arr
  end

  def valid_roc_doc
    oasis_resumption_of_care? and valid_document?
  end

  def oasis_resumption_of_care_and_valid?
    oasis_resumption_of_care? and valid_document? and completed?
  end

  def document_already_attached_to_MD_order?
    md_orders = treatment_episode.medical_orders
    md_orders = md_orders.includes(:attached_docs).where({:medical_order_attached_docs => {:document_id => self.id}})
    not md_orders.empty?
  end

  def agency_name
    document_definition.org.to_s
  end

  def agency_name_for_visit_document
    if treatment.print_insurance_company_contact? and is_visit_document?
      treatment.insurance_company.to_s
    else
      document_definition.org.to_s
    end
  end

  def hide_agency_info_button
    if current_user_is_office_staff?
      [:pending_qa, :approved, :exported].include? self.status
    else
      true
    end
  end

  def agency_info
    org = treatment.patient.org
    cms_cert_number = org.health_agency_detail.cms_cert_number
    branch_id = (org.branch_id.present? ? org.branch_id : "P")
    branch_state = org.state unless ['N', 'P'].include?(branch_id)
    {cms_cert_number: cms_cert_number, branch_state: branch_state, branch_id: branch_id }
  end

  def calculate_hipps_code(doc = nil)
    document = doc.present? ? doc : self
    return nil if ( (document.m2200_ther_need_nbr and not document.m2200_ther_need_nbr.match(/^(\d)+$/)) || document.m2200_ther_need_na == '1' || document.m0090_info_completed_dt == '' || document.m0090_info_completed_dt == nil || document.m0110_episode_timing == 'NA' ||
        document.m0110_episode_timing == nil || document.m2200_ther_need_nbr == nil || document.m2200_ther_need_nbr == '')
   if document.m0100_assmt_reason
     export_oasis_record = OasisExporterFor210And211.new(document).generate_xml
     ProspectivePaymentSystem::PPSGrouper.generate_hipps_code(export_oasis_record)
   else
     raise "It is not OASIS Document."
   end
  end

  def latest_exported_record
    return if self.oasis_exports.where("export_status not in (?) AND record_type <> ?", [OasisExport::REJECTED, OasisExport::EXPORTED], OasisExport::INACTIVE_CHAR).count > 0
    self.oasis_exports.where(["export_status = ?", OasisExport::EXPORTED]).first
  end

  def exported_date
    latest_exported_record.exported_date_display
  end

  def display_clinical_fields?
    res = false
    health_agency = treatment.health_agency
    if health_agency
      res = health_agency.health_agency_detail.clinical_fields_required_in_oasis == true
    end
    res
  end

  def archive_notes
    document_notes.update_all(:archived => true) if document_notes.present?
  end

  def get_pending_status
    sm_map = {'4' => "Export Rejected", '3' => "Non-Key Field Correction", '2' => "Key Field Correction", '5' => "Clinical Field Correction" }
    notes = document_notes.active_notes.event_changed_notes
    note = notes.last
    if (self.oasis_document? and self.exported?)
      export_record = latest_exported_record
      export_record.present? ? "Exported(#{export_record.exported_date_display})" : "Exported"
    elsif self.approved?
      status.to_s.titleize
    elsif self.pending_qa?
      "Pending QA"
    elsif self.draft?
      if (supervisor_present? && only_supervisor_signature_required? && (not is_super_visory_doc?))
        "Pending Co-Signature"
      else
        if (note and note.notes == "Requested Correction")
          "Correction Requested"
        elsif (note and note.notes == "Edited")
          "Draft"
        elsif note.nil?
          if ['1', '6'].include?(state_machine_id)
            status.to_s.titleize
          else
            sm_map[state_machine_id]
          end
        else
          sm_map[state_machine_id]
        end
      end
    end
  end

  def is_not_correction_request?
    res = ((self.draft? and !(self.supervised_user.present? and (self.fs_sign_required == false) and self.supervisor_signature_required?))|| self.field_signature_not_required?)
    res = (res or self.exported?) if self.oasis_document?
    res
  end

  def note_form_is_required?
    ((User.current.field_staff? && self.draft?) or ((User.current.office_staff? or User.current.clinical_staff?) and (!self.exported?)))
  end

  def workflow
    return @workflow if defined? @workflow
    @workflow = STATE_MACHINE_MAP[self.state_machine_id].constantize.new self
  end

  def method_missing sym, *args
    if workflow.respond_to? sym
      workflow.send sym, *args
    else
      super
    end
  end

  def set_as_fs_signed
    self.fs_sign_required = false
    nil
  end

  def set_as_fs_not_signed
    is_super_visory_doc? ? self.fs_sign_required = false : self.fs_sign_required = true
    self.fs_sign_date = nil
    self.supervisor_sign_required = true if supervised_user.present?
    self.supervised_user_sign_date = nil if supervised_user.present?
  end

  def set_as_supervisor_signed
    self.supervisor_sign_required = false
    nil
  end

  def create_receivables
    true
  end

  def draft_save_required?
    ((self.draft? or self.pending_qa?) and current_user_is_office_staff?)
  end

  def events_for_current_state
    events = aasm_permissible_events_for_current_state.collect{|e| workflow.class.aasm_events.values.detect{|ev| ev.name == e }}
    events.select!{|ev| (ev.options[:hidden].nil? or ev.options[:hidden] == false) }
    events
  end

  private

  def set_field_staff_and_supervised_user
    self.field_staff = User.where(["id = (?) and user_type in ('FieldStaff', 'LiteFieldStaff')", field_staff_id]).first if field_staff_id
    self.supervised_user = FieldStaff.find(supervised_user_id) if supervised_user_id
    self.treatment_episode = TreatmentEpisode.find(treatment_episode_id) if treatment_episode_id
    self.status = :draft if new_record?
  end

  def pre_populate_patient_and_visit_info
    if visit_id
      v = TreatmentVisit.find(visit_id)
      self.treatment = v.treatment
      self.patient_name = v.patient_name
      self.mr = v.mr
      self.md_name = v.primary_physician_name
      self.field_staff_name = v.visited_user.full_name if v.visited_user.present?
      self.visit_date = v.visit_start_time.to_date
      self.approved_date = v.visit_start_time.to_date
      self.time_in = v.visit_start_time.strftime("%H:%M")
      self.treatment_episode = v.treatment_episode
      self.field_staff = v.visited_user
      self.supervised_user = v.supervised_user
      self.time_out = v.visit_end_time.strftime("%H:%M")
      self.physician_name = v.primary_physician_name
    elsif treatment_id
      t = PatientTreatment.find(treatment_id)
      self.patient_name = t.patient_name
      self.mr = t.patient_reference
      self.md_name = t.primary_physician_name
      self.physician_name = t.primary_physician_name
      self.correction_num = 0
    end
    self.state_machine_id = '6'
    self.status = :draft
  end


  def frequency_string_valid?(value)
    return false if value.nil?
    value.upcase.match(/^(\d+|QD|BID|TID)(W|WK|WEEK|D|DY|DAY|M|MON|MT|MONTH|X)(\d+)$/).nil? == false
  end

  def frequency_string_format
    if frequency.present?
      frequencies = frequency.split(',').collect{|f| f.split(' ')}.flatten
      frequencies.each do |f|
        unless frequency_string_valid?(f)
          self.errors.add(:base, "Frequency #{f} is invalid.")
        end
      end
    end
  end

  def set_created_user
    self.created_user = User.current
  end

  def set_initial_flags_value
    self.fs_sign_required = (self.field_staff.present?) ? (is_super_visory_doc? ? false : true) : false
    self.supervisor_sign_required = (supervisor_present? ? true : false)
    nil
  end

  def lock_document_form_template
    self.document_form_template = document_definition.document_form_template
  end

  def set_defaults
    self.valid = self.non_oasis_document? ? true : false
    if visit_id
      v = TreatmentVisit.find(visit_id)
      self.treatment_episode = v.treatment_episode
      self.treatment = v.treatment_episode.treatment
      self.field_staff = v.visited_user
      self.supervised_user = v.supervised_user
    end
  end

  def set_treatment_info
    if visit_id
      v = TreatmentVisit.find(visit_id)
      self.treatment_episode = v.treatment_episode
      self.treatment = v.treatment_episode.treatment
    end
  end

  def set_doc_is_evaluation
    self.doc_is_evaluation = false
  end

  def set_report_fields_default_values
    self.class.report_fields_default_values
  end

  def self.report_fields_default_values
    35.times.each{|i|
      if (self.method_defined?("detail#{i}_label".to_sym) == false && self.method_defined?("detail#{i}_value".to_sym) == false)
        define_method("detail#{i}_label") do
          nil
        end
        define_method("detail#{i}_value") do
          nil
        end
      end
    }
  end

  def create_all_document
    category = document_definition.document_name.split(" ").first
    staff = field_staff.full_name if field_staff
    description = if document_definition.document_name.end_with? "C1"
                    document_definition.document_name.split(" ")[-2]
                  else
                    document_definition.document_name.split(" ").last
                  end
    document = self.all_documents.build(treatment_episode: treatment_episode, category: category, staff: staff, description: description,
                             status: get_pending_status)
    document.document_date = document_date
  end

  def update_all_documents_if_required
	return nil if skip_callbacks
    category = document_definition.document_name.split(" ").first
    staff = field_staff.full_name if field_staff
    description = if document_definition.document_name.end_with? "C1"
                     document_definition.document_name.split(" ")[-2]
                  else
                    document_definition.document_name.split(" ").last
                  end
    doc_status = get_pending_status

    self.all_documents.each{|d|
       d.update_attributes(category: category, staff: staff, description: description, status: doc_status) if (category != d.category or
           staff != d.staff or description != d.description or doc_status != d.status)
      d.update_column(:document_date, document_date)
    }
  end

end
