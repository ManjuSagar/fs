# == Schema Information
#
# Table name: document_definitions
#
#  id                        :integer          not null, primary key
#  document_code             :string(20)       not null
#  document_name             :string(100)      not null
#  document_form_template_id :integer          not null
#  tied_to_visit_flag        :boolean          default(FALSE)
#  defn_status               :string(2)        not null
#  system_supplied_flag      :boolean          default(FALSE)
#  org_id                    :integer          not null
#  active_flag               :boolean          default(FALSE)
#  payable_rate              :decimal(8, 2)
#  lock_version              :integer          default(0)
#

class DocumentDefinition < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :document_form_template
  belongs_to :org
  has_many :visit_type_document_definitions, :dependent => :destroy
  has_many :visit_types, :through => :visit_type_document_definitions

  scope :org_scope, lambda {|org = Org.current| where(:org_id => org.id ).order("document_name") if Org.current}
  scope :discipline_doc_defns_scope, lambda {|org| org_scope(org).includes(:document_form_template).where("document_form_templates.oasis=false")}
  scope :oasis_c1_scope, lambda {|org| org_scope(org).includes(:document_form_template).where("document_form_templates.oasis=true and document_form_templates.document_type='C1'")}

  scope :org_document_definitions, lambda {|org_id| where(:org_id => org_id).order("document_name")}
  default_scope lambda{ includes(:document_form_template).order("document_name") }

  netzke_attribute :document_class_name

  audited :associated_with => :org, :allow_mass_assignment => true

  validates :document_code, :presence => true, :length => {:maximum => 20}
  validates :document_name, :presence => true, :length => {:maximum => 100}
  validates :document_form_template, :presence => true

  OASIS_DOCS_CODES = ["SOC_OASIS", "OASIS_ROC", "OASIS_RR", "OASIS_OF", "OASIS_TIFPND", "OASIS_TIFPD", "OASIS_DAH", "OASIS_DFA", "PLAN_OF_CARE_485"]
  OASIS_DOCS_C1_CODES = ["SOC_OASIS_C1", "OASIS_ROC_C1", "OASIS_RR_C1", "OASIS_OF_C1", "OASIS_TIFPND_C1", "OASIS_TIFPD_C1",
                         "OASIS_DAH_C1", "OASIS_DFA_C1"]

  def formatted_payable_rate
    number_to_currency(payable_rate, :format => "%n")
  end

  def document_class_name
    document_form_template.document_class_name
  end

  def to_s
    self.document_name
  end

  before_create :set_status, :set_org

  private
  
  def set_status
    self.defn_status = "A"
  end

  def set_org
    self.org ||= Org.current
  end
end
