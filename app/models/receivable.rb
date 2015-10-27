# == Schema Information
#
# Table name: receivables
#
#  id                 :integer          not null, primary key
#  payer_type         :string(255)      not null
#  payer_id           :integer          not null
#  org_id             :integer          not null
#  invoice_id         :integer
#  invoice_payment_id :integer
#  receivable_status  :string(1)        not null
#  source_type        :string(255)
#  source_id          :integer
#  purpose            :string(100)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  receivable_date    :date             not null
#  receivable_amount  :decimal(8, 2)    not null
#  receivable_type    :string(1)        not null
#  treatment_id       :integer
#

class Receivable < ActiveRecord::Base
  include ReceivableRelatedMethods

  belongs_to :invoice
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :invoice_payment
  belongs_to :org
  belongs_to :payer, :polymorphic => true
  belongs_to :source, :polymorphic => true
  belongs_to :treatment_episode
  has_many  :medicare_remittance_claim_line_items

  after_initialize :set_defaults, :if => :new_record?
  before_validation :set_purpose, :if => :new_record?

  audited :associated_with => :org, :allow_mass_assignment => true

  default_scope lambda {order("revenue_code, receivable_date")}
  scope :org_scope, lambda{ where(:org_id => Org.current.id) }

  SUPPLY_TYPE = 'S'
  RECEIVABLE_TYPES = [['V', 'Treatment Visit'],[SUPPLY_TYPE, 'Supply'], ['D', 'Document'], ['O', 'Others']]
  HOME_HEALTH_SERVICE = "Home Health Services"

  validates :treatment, :presence => true
  validates :treatment_episode, :presence => true
  validates :receivable_date, :presence => true
  validates :receivable_type, :presence => true
  validates :receivable_amount, :presence => true
  validates :source, :presence => true, :if => lambda{|r| r.receivable_type == SUPPLY_TYPE}
  validates :service_units, :presence => true


  include AASM
  STATE_MAP = {:draft => 'D', :approved => 'A', :invoiced => 'I', :paid => 'P'}
  STATUS_STORE = STATE_MAP.collect{|k,v| [v.to_s, k.to_s.titleize]}.unshift(["", "---"])

  aasm :column => :receivable_status do
    state :draft
    state :approved
    state :invoiced, :initial => true
    state :paid

    event :approve do
      transitions :to => :approved, :from => :draft
    end

    event :mark_as_invoiced do
      transitions :to => :invoiced, :from => :approved, :guard => :system_driven_event?
    end

    event :mark_as_paid do
      transitions :to => :paid, :from => :invoiced, :guard => :system_driven_event?
    end

    event :revert_status_to_approved do
      transitions :from => :invoiced, :to => :approved, :guard => :system_driven_event?
    end

    event :undo do
      transitions :from => :paid, :to => :invoiced, :guard => :system_driven_event?
    end

  end

  attr_accessor :system_driven_event, :selected

  netzke_attribute :selected, :type => :boolean


  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :receivable_status
    write_attribute_without_mapping(attr, v)
  end

  def receivable_paid_amount
    medicare_remittance_claim_line_items.map(&:line_item_paid_amount).sum
  end

  def receivable_status
    STATE_MAP.invert[read_attribute(:receivable_status)]
  end

  def home_health_service?
    self.purpose == HOME_HEALTH_SERVICE
  end

  def update_hipps_code_and_amount(params)
    self.update_attributes({hcpcs_code: params[:hipps_code], receivable_amount: params[:amount]})
  end

  def update_receivable_date(date)
    self.update_attributes({receivable_date: date})
  end

  def receivable_status_change_for_paid_event
    self.system_driven_event = true
    self.mark_as_paid! if self.may_mark_as_paid?
    self.system_driven_event = false
  end

  def service_date_format
    receivable_date.strftime("%m%d%y") if receivable_date.present?
  end

 #Overriding to_xml in different way
  alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    default_options = { :methods => [ :service_date_format ]}
    self.ar_to_xml(options.merge(default_options), &block)
  end

  private

  def set_defaults
    self.org ||= Org.current
  end

  def set_purpose
    self.purpose = "#{source}" if purpose.nil? and source.present?
    if self.invoice
      self.payer = invoice.payer
      self.treatment = invoice.treatment
      self.treatment_episode = invoice.treatment_episode
    end
  end

end
