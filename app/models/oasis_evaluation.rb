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

class OasisEvaluation < Document
  after_initialize :pre_populate_patient_and_visit_info, :assessment_complete_reason, :set_ethnicities, :if => :new_record?
  include OasisExtension
  include ReportHeaderInfo
  include OasisPrint
  include Wound
  before_save :reset_values_based_on_info_completed_date?

  has_paper_trail
  paper_trail_off!

  def method_missing(meth, *args, &block)
    if meth.to_s.starts_with?("wound_")
      accessor_name = meth.to_s.ends_with?("=") ? meth.to_s.gsub(/=/,"") : meth.to_s
      self.class_eval {store :data, :accessors => [accessor_name]}
      self.send(meth, *args)
    else
      super
    end
  end

  def respond_to?(method, include_private = false)
    super || method.to_s.starts_with?("wound_")
  end

  def assessment_complete_reason
    self.m0100_assmt_reason = "01"
  end

  def set_ethnicities
    if treatment
      ethnicity_map = {:m0140_ethnic_ai_an => "1", :m0140_ethnic_asian => "2", :m0140_ethnic_black => "3", :m0140_ethnic_hisp => "4",
                     :m0140_ethnic_nh_pi => "5", :m0140_ethnic_white => "6"}

      ethnicity_map.each do |k,v|
        self.send("#{k.to_s}=", true) if treatment.patient.ethnicities.any?{|et| et.id == v}
      end
    end
  end

  def check_box_list
    list  = ["m0140", "m0150", "m1000", "m1018", "m1030", "m1032", "m1033", "m1036", "m1410", "m1740"]
    get_group_elements(list)
  end

  def multiple_radio_groups_list
    list = ["m1730", "m1900", "m2040", "m2100", "m2102", "m2250"]
    get_group_elements(list)
  end

  def check_boxes
    ["m0018_physician_uk", "m0032_roc_dt_na", "m0063_medicare_na", "m0064_ssn_uk", "m0065_medicaid_na", "m0102_physn_ordrd_socroc_dt_na",
     "m1005_inp_dschg_unknown", "m1012_inp_na_icd", "m1012_inp_uk_icd", "m1016_chgreg_icd_na", "m2200_ther_need_na"]
  end

  def non_payment_codes
    list = ["m1010", "m1011", "m1012", "m1016", "m1017", "m1024", "m1025"]
    list = get_group_elements(list)
    list.flatten.reject{|x| ["m1012_inp_na_icd", "m1012_inp_uk_icd", "m1016_chgreg_icd_na", "m1011_14_day_inp_na",
                             "m1017_chgreg_icd_na"].include? x}
  end

  def payment_codes
    list = ["m1020", "m1022", "m1021", "m1023"]
    list = get_group_elements(list)
    list.flatten.reject{|x| x.end_with? "severity"}
  end

  def clinical_fields
    Wound::WOUND_PRIMARY_ATTRS + Wound::WOUND_DESCRIPTION_ATTRS + OasisPocField::FIELDS
  end

  def pressure_ulcers
    data.keys.select{|x| x.start_with? "m1308"}
  end

  alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    super({ :root => "document" }.merge(options))
    default_options = {:root => "document", :methods => xml_methods}
    self.ar_to_xml(options.merge(default_options), &block)
  end

  def report_title
    "SOC OASIS SUMMARY"
  end

end
