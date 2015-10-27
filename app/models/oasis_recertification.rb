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

class OasisRecertification < OasisOtherFollowup
  after_initialize :pre_populate_patient_and_visit_info, :assessment_complete_reason, :set_soc_roc_pressure_ulcer_values, :if => :new_record?
  include OasisExtension
  include ReportHeaderInfo
  include OasisPrint
  before_save :reset_values_based_on_info_completed_date?

  def assessment_complete_reason
    self.m0100_assmt_reason = "04"
  end

  def check_box_list
    list  = ["m0150", "m1030"]
    get_group_elements(list)
  end

  def multiple_radio_groups_list
   []
  end

  def check_boxes
    ["m0018_physician_uk", "m0032_roc_dt_na", "m0063_medicare_na", "m0064_ssn_uk", "m0065_medicaid_na", "m2200_ther_need_na"]
  end

  def non_payment_codes
    list = ["m1024", "m1025"]
    list = get_group_elements(list).flatten
  end

  def payment_codes
    list = ["m1020", "m1022", "m1021", "m1023"]
    list = get_group_elements(list)
    list.flatten.reject{|x| x.end_with? "severity"}
  end

  def pressure_ulcers
    data.keys.select{|x| x.start_with? "m1308"}.reject{|x| x.end_with? "soc_roc"}
  end

  def clinical_fields
    []
  end

  def report_title
    "RC OASIS SUMMARY"
  end

  alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    super({ :root => "document" }.merge(options))
    default_options = {:root => "document", :methods => xml_methods}
    self.ar_to_xml(options.merge(default_options), &block)
  end


end
