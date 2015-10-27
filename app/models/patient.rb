# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  first_name              :string(100)      not null
#  last_name               :string(100)      not null
#  suite_number            :string(15)
#  street_address          :string(50)
#  city                    :string(50)
#  state                   :string(2)
#  zip_code                :string(10)
#  phone_number            :string(15)
#  user_type               :string(50)
#  lock_version            :integer          default(0)
#  approved                :boolean          default(FALSE), not null
#  gender                  :string(1)
#  signature_file_name     :string(255)
#  signature_content_type  :string(255)
#  signature_file_size     :integer
#  signature_updated_at    :datetime
#  middle_initials         :string(2)
#  suffix                  :string(10)
#  ethnicity               :string(20)
#  encrypted_sign_password :string(255)
#

class Patient < User
  has_one :patient_detail, :dependent => :destroy
  has_many :treatments, :class_name => "PatientTreatment", :dependent => :destroy
  has_many :treatment_requests, :dependent => :destroy
  has_many :patient_caregivers, :class_name => "PatientCaregiver", :dependent => :destroy
  has_many :caregivers, :through => :patient_caregivers
  has_many :insurance_companies, :through => :patient_insurance_companies
  has_many :patient_insurance_companies, :dependent => :destroy

  scope :org_scope, lambda { includes(:patient_detail, :treatment_requests).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}

  scope :active, lambda {org_scope.includes(:treatments, :treatment_requests).where(["patient_treatments.treatment_status in (?) or treatment_requests.request_status not in (?)", ['P', 'A', 'O', 'D'], ['R','A']])}

  scope :admitted_patients, lambda{org_scope.includes(:treatments).where(["patient_treatments.treatment_status in (?)", ['P', 'A', 'O', 'D']])}

  scope :filter_active_patients, lambda{|from_date, to_date| org_scope.joins(:patient_detail).joins(:treatments).where(["date(patient_treatments.treatment_start_date) BETWEEN ? AND ?", from_date, to_date])}

  scope :user_scope, lambda { includes(:patient_detail).where(["patient_details.org_id in (select org_users.org_id from
                      org_users where org_users.org_id in (select org_users.org_id from org_users where
                      org_users.user_id = ?) )", User.current.id]) }

  default_scope lambda {order('last_name asc, first_name asc')}

  audited :associated_with => :patient_detail, :allow_mass_assignment => true

  validates_presence_of :street_address
  before_validation :set_random_password, :set_random_email, :set_defaults, :on => :create
  before_save :revert_user_viewing_changed_attr
  before_update :sample_patient_to_real_if_required
  before_save :remove_trailing_spaces, :unless => :new_record?
  after_validation :validate_for_duplicate_email, :check_errors, :check_insurance_companies_are_present?
  #after_initialize :set_patient_reference_number_if_required
  after_update :save_patient_detail
  after_save :update_denormalized_patient_list, :if => :check_patient_reference_presnet?
  after_destroy :delete_patient_in_denormalized_patient_list, :unless => :new_record?

  netzke_attribute :dob, :type => :date
  netzke_attribute :marital_status
  netzke_attribute :ssn
  netzke_attribute :weight
  netzke_attribute :height
  netzke_attribute :medicare_number
  netzke_attribute :patient_reference

  include PatientList

  delegate :org, :org=, :dob, :dob=, :medicare_number, :medicare_number=, :gender, :gender=,
           :height, :height=, :weight, :weight=, :ssn, :ssn=, :dnr, :dnr=, :dni, :dni=, :acuity_level,
          :acuity_level=, :advanced_directive, :advanced_directive=, :marital_status, :marital_status=, :patient_reference, :patient_reference=, :to => :patient_detail
  #validates_associated :patient_detail

  has_associated_audits

  scope :my_org_patients, lambda { includes(:patient_detail).where({:patient_details => {:org_id => Org.current.id}}) if Org.current}

  CAREGIVER_FIELDS = [:caregiver_1_first_name, :caregiver_1_last_name, :caregiver_1_phone_number, :caregiver_1_relation_to_patient,
                      :caregiver_2_first_name, :caregiver_2_last_name, :caregiver_2_phone_number, :caregiver_2_relation_to_patient]
  ACUITY_TYPES = [[nil, "---"], ["1", "Low"], ["2", "Medium"], ["3", "High"], ["4", "NA"]]
  DNR = {"1" => "Yes", "2" => "No", "3" => "NA"}
  DNI = {"1" => "Yes", "2" => "No", "3" => "NA"}
  ADVANCED_DIRECTIVES = {"1" => "Yes", "2" => "No", "3" => "NA"}
  CAREGIVER_FIELDS.each{|f| attr_accessor f; netzke_attribute f}
  after_create :create_caregivers
  validate :validate_caregivers

  attr_accessor :user_viewing_changed_attr_value

  MARITAL_STATUSES = [['M', 'Married'],['S', 'Single'],['D', 'Divorced']]

  def patient_detail_with_build
    patient_detail_without_build || build_patient_detail
  end
  alias_method_chain :patient_detail, :build

  def check_patient_reference_presnet?
    patient_detail.org.present?
  end

  def staffs_present_and_staffed?
    'f'
  end

  def patient_record_type
    if treatment_requests.empty? and treatments.empty?
      2
    end
  end

  def remove_trailing_spaces
    self.first_name = first_name.strip
    self.last_name = last_name.strip
  end

  def delete_patient_in_denormalized_patient_list
    DenormalizedPatientList.destroy_with(self)
  end

  def update_denormalized_patient_list
    d = DenormalizedPatientList.where(:patient_id => self.id, :org_id => Org.current.id)
    if d.present?
      DenormalizedPatientList.update_with(self)
    else
      DenormalizedPatientList.create_with(self)
    end
  end

  def patient_status
    if (self.treatment_requests.empty?)
      "P"
    end
  end

  def dob_string
    dob.strftime("%m/%d/%Y")
  end

  def treatment_id
    t = active_treatment
    t.id if t
  end

  def episode_id
   t = active_treatment
   episode = t.current_episode if t
   episode.id if episode
  end

  def active_treatment
    t = treatments.detect{|t| not t.discharged?}
    t = last_discharged_treatment if t.nil? and active_referral.nil?
    t
  end

  def last_discharged_treatment
    treatments.reorder("id DESC").detect{|t| t.discharged? }
  end

  def active_referral
    treatment_requests.detect{|t| t.admitted? == false and t.rejected? == false}
  end

  def org_week_start_day
    Org::WEEK_DAYS_NUMBER[org.week_start_day.to_sym]
  end

  def set_defaults
    self.caregiver_1_last_name = '.' unless self.caregiver_1_last_name.present?
    self.caregiver_2_last_name = '.' unless self.caregiver_2_last_name.present?
  end

  def self.patients_list(treatment_status_arr = nil)
    active_patients = Patient.org_scope.includes(:treatments, :treatment_requests)
    unless treatment_status_arr.nil?
      active_patients = active_patients.where(["patient_treatments.treatment_status in (?) ", treatment_status_arr])
    end
    active_patients.collect{|p| [p.id, p.full_name]}
  end

  def self.report_url(params)
    obj = params[:missing_frequency] ?  MissingFrequencyReportDataSource.new : TherapyReevaluation.new
    field_staffs = if params[:missing_frequency]
                            obj.collect_missing_frequencies(params)
                          else
                            obj.display_therapy_reevaluation_info(params)
                          end
    field_staffs.empty? ? false : obj.to_pdf({methods: {field_staffs: field_staffs}})
  end

  def staffs
    staff_list =if self.active_treatment
                  active_treatment.treatment_staffs.where({system_assigned: false})
                elsif self.active_referral
                  active_referral.request_staffs.where("staff_id is not null")
                end
    discipline_and_visit_type = staff_list.where(["discipline_id is not null and visit_type_id is not null"])
    discipline = staff_list.where(["discipline_id is not null and visit_type_id is null"])
    visit_type = staff_list.where(["discipline_id is null and visit_type_id is not null"])
    discipline_and_visit_type.sort_by!{|s| [s.discipline[:sort_order], s.visit_type[:sort_order]]}
    discipline.sort_by!{|s| [s.discipline[:sort_order]]}
    sorted_staffs_list = (discipline_and_visit_type + discipline).sort_by{|s| s.discipline[:sort_order]} + visit_type.sort_by{|s| s.visit_type[:sort_order]}
    staffs_sorted_list(sorted_staffs_list) unless sorted_staffs_list.blank?
  end

  def staffs_sorted_list(list)
    staffs_list_arr = list.collect do |st|
      if st.discipline and st.visit_type
        {discipline_name: st.discipline_description, visit_type: st.visit_type_description, name: (st.staff.full_name if st.staff), phone: staff_phone_number(st)}
      elsif st.discipline.nil? and st.visit_type
        {discipline_name: nil, visit_type: st.visit_type_description, name: (st.staff.full_name if st.staff), phone: staff_phone_number(st)}
      else st.discipline and st.visit_type.nil?
        {discipline_name: st.discipline_description, visit_type: nil, name: (st.staff.full_name if st.staff), phone: staff_phone_number(st)}
      end
    end
    staffs_list_arr
  end

  def staff_phone_number(st)
    if st.staff
      "#{st.staff.phone_number}" if st.staff.phone_number
    end
  end

  def primary_physician_info
    physician_info(primary_physician)
  end


  def primary_physician
    physician = if self.active_treatment
                  self.active_treatment.primary_physician
                elsif self.active_referral
                  self.active_referral.referred_physician
                end
  end

  def can_delete?
    self.treatment_requests.empty?
  end

  def org_id
    org.present? ? org.id : nil
  end
  def physician_info(physician)
    info = []
    if physician
      info << "<b>Name : </b>" + physician.to_s unless physician.to_s.blank?
      info << "<b>NPI : </b>" + physician.npi_number unless physician.npi_number.blank?
      info << "<b>Phone : </b>" + physician.phone_number unless physician.phone_number.blank?
      info << "<b>Fax : </b>" + physician.fax_number unless physician.fax_number.blank?
      info.join(", ")
    end
  end

  def physicians
    physician_list = []
    if self.active_treatment
       tretment_physicians.each do |p|
         physician_list << get_physician_details(p)
       end
    elsif self.active_referral
      physician = self.active_referral.referred_physician
      physician_list << get_physician_details(physician)
    end
    physician_list
  end

  def get_physician_details(p)
    {name: p.to_s, address: p.physician_address, phone: p.phone_number, fax: p.fax_number,npi: p.npi_number}
  end

  def tretment_physicians
    physician_list, primary_physicians, non_primary_physicians =Array.new(3){[]}
    treatment_physicians = self.active_treatment.treatment_physicians if self.active_treatment
    treatment_physicians.each do |treat_phy|
      if treat_phy.primary?
        primary_physicians << treat_phy.physician unless treat_phy.physician.blank?
      else
        non_primary_physicians << treat_phy.physician unless treat_phy.physician.blank?
      end
     physician_list = primary_physicians + non_primary_physicians
    end
    physician_list
  end

  def primary_physician_address
    primary_physician.physician_address if primary_physician
  end

  def primary_physician_phone_number
    primary_physician.phone_number if primary_physician
  end

  def insurance_companies_display
    pri_insurance_company = []
    insurance_coy_hash = []
    ins_list = insurance_companies_list
    if self.active_treatment      
      pri_insurance_company << insurance_companies_list.detect{|i| i.insurance_company == self.active_treatment.treatment_request.insurance_company
        insurance_coy_hash << {name: i.insurance_company.company_name, insured_name: i.relation_to_insured_display , hicn_number: i.patient_insurance_number, insurance_case_manager: insurance_case_manager , case_manager_phone_number: case_manager_phone_number}
      }
      non_pri_ins_coys = insurance_companies_list - pri_insurance_company
      non_pri_ins_coys.each do |ins|
        insurance_coy_hash << {name: ins.insurance_company.company_name, insured_name: ins.relation_to_insured_display , hicn_number: ins.patient_insurance_number, insurance_case_manager: "" , case_manager_phone_number: ""}
      end

    elsif self.active_referral
      pri_insurance_company << insurance_companies_list.detect{|i| i.insurance_company == self.active_referral.insurance_company
        insurance_coy_hash << {name: i.insurance_company.company_name, insured_name: i.relation_to_insured_display , hicn_number: i.patient_insurance_number, insurance_case_manager: insurance_case_manager , case_manager_phone_number: case_manager_phone_number}
      }
      non_pri_ins_coys = insurance_companies_list - pri_insurance_company
      non_pri_ins_coys.each do |ins|
        insurance_coy_hash << {name: ins.insurance_company.company_name, insured_name: ins.relation_to_insured_display , hicn_number: ins.patient_insurance_number, insurance_case_manager: "" , case_manager_phone_number: ""}
      end
    end
    insurance_coy_hash
  end

  def primary_insurance_company
    active_treatment = self.active_treatment
    active_referral = self.active_referral
    primary_insurance_company =  if active_treatment
                                   if active_treatment.treatment_request
                                      active_treatment.treatment_request.insurance_company if active_treatment.treatment_request.insurance_company
                                   end
                                 elsif active_referral
                                   active_referral.insurance_company if active_referral.insurance_company
                                 end
  end

  def insurance_companies_list
    insurance_company = primary_insurance_company
    ins_company = self.patient_insurance_companies.detect{|i| i.insurance_company == insurance_company }
    ins_company = ins_company ? [ins_company] : []
    ins_list_without_primary = self.patient_insurance_companies - ins_company    
    ins_company + ins_list_without_primary
  end

  def primary_insurance_company_name
  	primary_insurance_company.company_name if primary_insurance_company
  end

  def insurance_companies_sub_report_url
    "#{Rails.root}/app/views/reports/face_sheet/insurance_list.jasper"
  end

  def caregivers_list
    caregivers = []
    patient_caregivers.each do |caregiver|
      cargivers_hash = {}
      cargivers_hash["name"] = caregiver.to_s if caregiver.first_name.present?
      cargivers_hash["relation_to_patient"] = caregiver.relation_to_patient if caregiver.relation_to_patient.present?
      cargivers_hash["phone_number"] = caregiver.phone_number if caregiver.phone_number.present?
      caregivers << cargivers_hash
    end
    caregivers
  end

  def caregivers_sub_report_url
    "#{Rails.root}/app/views/reports/face_sheet/caregivers_list.jasper"
  end

  def gender_description
   gender = (self.gender == "M") ? "Male" : "Female"
  end

  def ins_case_manager
    case_manager = if self.active_treatment
                     self.active_treatment.treatment_request.insurance_case_manager if self.active_treatment.treatment_request.insurance_case_manager
                   elsif self.active_referral
                     case_manager = self.active_referral.insurance_case_manager if self.active_referral.insurance_case_manager
                   end
  end

  def insurance_case_manager
    ins_case_manager.name if ins_case_manager
  end

  def case_manager_phone_number
    ins_case_manager.phone_number if ins_case_manager
  end

  def age
    today = Date.current
    age = today.year - self.dob.year
    age -= 1 if self.dob.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    age
  end

  def agency_name
    self.org.to_s
  end

  def agency_phone_number
    self.org.phone_number
  end

  def agency_fax_number
    self.org.fax_number
  end

  def agency_address
    agency_address1 + " " + agency_address2
  end

  def agency_address1
    org = self.org
    address = []
    address << org.street_address unless org.street_address.blank?
    address << "Suite " + org.suite_number unless org.suite_number.blank?
    address.join(", ")
  end

  def agency_address2
    org = self.org
    address = []
    address << org.city unless org.city.blank?
    address << ["#{org.state} #{org.zip_code}"].reject{|x| x.blank?}
    address.join(", ")
  end

  def printed_date
     Time.current.strftime("%m/%d/%y %H:%M:%S%p")
  end

  def org_id
    self.org.id
  end

  def referral_date
    request_date  = if self.active_treatment
                      self.active_treatment.treatment_request.request_date
                    elsif self.active_referral
                      self.active_referral.request_date
                    end
    request_date.strftime("%m/%d/%Y")
  end

  def soc_date
    self.active_treatment.treatment_start_date.strftime("%m/%d/%Y") if active_treatment
  end


  def secondary_insurance
    ""
  end

  def secondary_insured_name
   ""
  end

  def seondary_insurance_hicn
   ""
  end

  def patient_special_instructions
    if self.active_treatment and self.active_treatment.treatment_request.special_instructions
      treatment_request = self.active_treatment.treatment_request
      special_instructions_display(treatment_request)
    elsif self.active_referral and self.active_referral.special_instructions
      special_instructions_display(self.active_referral)
    end
  end

  def special_instructions_display(treatment_request)
    instructions = treatment_request.special_instructions
    treatment_request.si_mandatory_flag? ? "Mandatory: #{instructions}" : "Suggested: #{instructions}"
  end

  def patient_known_allergies
    if self.active_treatment
      poc = self.active_treatment.documents.where('document_type' => 'PlanOfCare').last
      poc ? poc.allergies : nil
    end
  end

  def dnr_dni_display
    "#{DNR[self.dnr]}/#{DNR[self.dni]}"
  end

  def acuity_level_display
    level = ACUITY_TYPES.detect{|x| x[0]==self.acuity_level}[1]
    self.send("acuity_level_#{level.downcase}")
  end

  def patient_acuity_level
    level = ACUITY_TYPES.detect{|x| x[0]==self.acuity_level}[1]
  end

  def patient_street_address
    address = []
    address << street_address unless street_address.blank?
    address << " #{suite_number}" unless suite_number.blank?
    address << city unless city.blank?
    address.join(', ')
  end

  def patient_state_details
    address = []
    address << state unless state.blank?
    address << zip_code unless zip_code.blank?
    address.join(" ")
  end

  def patient_address
    patient_street_address + ' ' + patient_state_details
  end


  def advanced_directives_display
    ADVANCED_DIRECTIVES[self.advanced_directive]
  end

  def patient_known_languages
    languages = []
    self.languages.each do |lang|
      languages << lang.language_description unless lang.blank?
    end
    languages.join(", ")
  end

  def acuity_level_low
   %{<b>Low:</b> Patients who can safely forego care or a scheduled visit without a
     high probability of harm or deleterious effects; this category may include
     homemaker patients, routine supervisory visits, evaluation visits, patients
     with frequencies of one (1) or two (2) times a week, if health status
     permits, or if a competent family member/caregiver is present. In case of
     an emergency, these patients must be seen or contacted via telephone
     within 72 hours, or based on the requirements of the patient\'s condition.}
  end

  def acuity_level_medium
    %{<b>Medium:</b> Patients with recent exacerbation of disease process; patients
      requiring moderate level of skilled care that should be provided that day;
      patients with essential untrained family/caregivers not prepared to provide
      needed care. In case of an emergency, these patients must be seen
      within 48 hours, or based on the requirements of the patient\'s condition.}
  end

  def acuity_level_high
    %{<b>High:</b> Patients who cannot safely forego care and require home health
      intervention regardless of other conditions. Patients in this category may
      include: highly unstable patients with a high probability of inpatient
      admission if home health is not provided; IV therapy patients; highly
      skilled wound care patients with no family/caregiver or other outside
      support; patients in need of critical supplies or medications. In case of an
      emergency, these patients must be seen within 24 hours, or based on the
      requirements of the patient\'s condition.}
  end

  def acuity_level_na
    nil
  end

  def physicians_sub_report_url
    "#{Rails.root}/app/views/reports/face_sheet/physicians.jasper"
  end

  def field_staff_sub_report_url
    "#{Rails.root}/app/views/reports/face_sheet/fs_list.jasper"
  end


  def to_xml(options = {})
    super :methods => [:full_name,
                       :patient_reference,
                       :dob_string,
                       :phone_number_2,
                       :ssn,
                       :gender_description,
                       :agency_name,
                       :agency_address,
                       :agency_phone_number,
                       :agency_fax_number,
                       :printed_date,
                       :soc_date,
                       :referral_date,
                       :staffs,
                       :hicn_number,
                       :secondary_insurance,
                       :secondary_insured_name,
                       :seondary_insurance_hicn,
                       :primary_physician_address,
                       :primary_physician_info,
                       :patient_special_instructions,
                       :patient_known_allergies,
                       :patient_known_languages,
                       :physicians,
                       :dnr_dni_display,
                       :acuity_level_display,
                       :advanced_directives_display,
                       :physicians_sub_report_url,
                       :field_staff_sub_report_url,
                       :insurance_companies_display,
                       :insurance_companies_sub_report_url,
                       :insurance_case_manager,
                       :case_manager_phone_number,
                       :caregivers_list,
                       :caregivers_sub_report_url

    ] + (options[:methods] || [])
  end

  def set_random_password
    self.password = self.password_confirmation = Time.current.to_f
  end

  def set_random_email
    random_string = Array.new(6){rand(36).to_s(36)}.join
    self.email = "#{first_name}#{last_name}#{random_string}@fasternotes.com"
  end

  def agency_email
    self.org.email
  end

  def full_name_with_out_mr_number
    "#{last_name}, #{first_name}"
  end

  def full_name_with_mr_number
    "#{last_name}, #{first_name} <b>MR</b> #{patient_reference}"
  end

  def full_name_with_mr_num_first_name_first
    "#{first_name} #{last_name} (#{patient_reference})"
  end

  def self.patient_list_store
    org_scope.collect{|p| [p.id, p.full_name]}.uniq
  end
  
  def patient_reference
    return self.patient_detail.patient_reference if self.patient_detail.patient_reference.present?
    reference = PatientReferenceNumber.ref_record
    sequence = reference ? reference.sequence + 1 : 1
    self.patient_reference = patient_detail.get_sys_gen_seq_num(sequence)
  end


  def p_eligibility_flag
    'f'
  end

  def p_staffing_flag
    'f'
  end

  def p_referral_flag
    'f'
  end

  def p_oasis_flag
    'f'
  end

  def p_poc_flag
    'f'
  end

  def p_dc_flag
    'f'
  end

  def p_fc_flag
    'f'
  end

  def p_rap_flag
    'f'
  end

  def p_doc_flag
    'f'
  end

  def p_mo_flag
    'f'
  end

  private

  def set_patient_reference_number_if_required
    return if self.patient_reference.present?
    self.patient_reference = get_mr_number
  end

  def check_insurance_companies_are_present?
    errors.add(:base, "Insurance Companies can't be blank") if insurance_companies.empty?
  end

  def save_patient_detail
    patient_detail.save! if patient_detail.changed?
  end

  def validate_for_duplicate_email
    if self.errors[:email]
      if errors["email"] == ["has already been taken"]
        self.valid?
      end
    end
  end

  def check_errors
    unless patient_detail.valid?
      patient_detail.errors.each do |k, v|
        self.errors.add(k, v)
      end
    end
  end

  def validate_caregivers
    caregiver_1_fields = CAREGIVER_FIELDS.select{|f| f.to_s.index("_1")} - [:caregiver_1_last_name]
    if caregiver_1_fields.any?{|f| self.send(f).blank? == false}
      caregiver_1_fields.select{|f| self.send(f).blank?}.each{|f| self.errors.add(f, "can't be blank")}
    end
    caregiver_2_fields = CAREGIVER_FIELDS.select{|f| f.to_s.index("_2")} - [:caregiver_2_last_name]
    if caregiver_2_fields.any?{|f| self.send(f).blank? == false}
      caregiver_2_fields.select{|f| self.send(f).blank?}.each{|f| self.errors.add(f, "can't be blank")}
    end
  end

  def create_caregivers
    caregiver_1_fields = CAREGIVER_FIELDS.select{|f| f.to_s.index("_1")}
    if caregiver_1_fields.any?{|f| self.send(f).blank? == false and f != :caregiver_1_last_name}
      c = self.patient_caregivers.build
      caregiver_1_fields.each{|f|
        fld_name = f.to_s.gsub(/caregiver_1_/,"")
        c.send("#{fld_name}=", self.send(f))
      }
      c.save!
    end

    caregiver_2_fields = CAREGIVER_FIELDS.select{|f| f.to_s.index("_2")}
    if caregiver_2_fields.any?{|f| self.send(f).blank? == false and f != :caregiver_2_last_name}
      c = self.patient_caregivers.build
      caregiver_2_fields.each{|f|
        fld_name = f.to_s.gsub(/caregiver_2_/,"")
        c.send("#{fld_name}=", self.send(f))
      }
      c.save!
    end
  end

  def revert_user_viewing_changed_attr
    self.current_sign_in_at = self.user_viewing_changed_attr_value if self.user_viewing_changed_attr_value
  end

  def sample_patient_to_real_if_required
    self.draft_status = false
    nil
  end
end
