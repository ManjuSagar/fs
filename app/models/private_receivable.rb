class PrivateReceivable < ActiveRecord::Base
  self.table_name = 'receivables'
  include AASM
  include ReceivableRelatedMethods

  belongs_to :private_insurance_invoice, :foreign_key => :invoice_id
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :invoice_payment
  belongs_to :invoice_package
  belongs_to :org
  belongs_to :payer, :polymorphic => true
  belongs_to :source, :polymorphic => true
  belongs_to :treatment_episode

  after_initialize :set_defaults, :if => :new_record?
  before_validation :set_purpose, :if => :new_record?
  before_save :update_due_date, :if => :is_private_ins_receivable?

  audited :associated_with => :org, :allow_mass_assignment => true

  scope :org_scope, lambda{ where(:org_id => Org.current.id) }

  scope :private_ins_scope, lambda{|status = 'D'| org_scope.where(["receivable_status = (?) and payer_id in (select id from insurance_companies where billing_flow = 'V')", status])}
  scope :pending_billing_scope, lambda{private_ins_scope.includes(:treatment => :patient).order("due_date, users.last_name, users.first_name, purpose").joins("join treatment_visits on treatment_visits.id = source_id").where("treatment_visits.visit_status = 'C'")}
  scope :group_by_payer, lambda{|claims, status| private_ins_scope(status).where(["id in (?)", claims])}
  scope :sent_receivables, lambda{|ids, status| org_scope.where(["id in (?) and receivable_status in (?)", ids, status]) }

  validates :treatment, :presence => true
  validates :treatment_episode, :presence => true
  validates :receivable_date, :presence => true
  validates :receivable_type, :presence => true
  validates :receivable_amount, :presence => true
  validates :service_units, :presence => true

  STATE_MAP = {:draft => 'D', :sent => 'S', :received => 'R'}
  RECEIVABLE_UNITS = {'V' => "Visit", 'H' => "Hour"}
  aasm :column => :receivable_status do
    state :draft, :initial => true
    state :sent
    state :received

    event :mark_as_sent do
      transitions :to => :sent, :from => :draft, :guard => :system_driven_event?
    end

    event :undo,  before: :remove_from_invoice do
      transitions :to => :draft, :from => :sent, :guard => :check_receivable_is_in_sent?
      transitions :to => :sent, :from => :received, :guard => :check_receivable_is_in_received?
    end

    event :mark_as_received do
      transitions :to => :received, :from => :sent
    end
  end
  attr_accessor :system_driven_event, :selected

  netzke_attribute :selected, :type => :boolean

  def system_driven_event?
    self.system_driven_event == true
  end

  def check_receivable_is_in_sent?
    self.sent?
  end

  def check_receivable_is_in_received?
    self.received?
  end

  def sent_date_display
    sent_date = self.private_insurance_invoice.sent_date
    sent_date.strftime('%m/%d/%Y') if sent_date.present?
  end

  def due_date_display
    self.due_date.strftime('%m/%d/%Y') if self.due_date
  end

  def payment_due_date_display
    self.payment_due_date.strftime('%m/%d/%Y') if self.payment_due_date
  end

  def remove_from_invoice
    return if self.received?
    invoice = self.private_insurance_invoice
    if (invoice.private_receivables.size == 1)
      invoice.private_receivables = []
      invoice.destroy
    else
      self.private_insurance_invoice = nil
    end

    self.received_amount = 0
    self.reference_number = nil
    package = InvoicePackage.org_scope.where(insurance_company_id: payer.id, id: self.invoice_package_id).last
    package.destroy if package.present? and package.private_receivables.size == 1
    self.invoice_package = nil
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :receivable_status
    write_attribute_without_mapping(attr, v)
  end

  def receivable_status_change_for_sent_event
    self.system_driven_event = true
    self.mark_as_sent! if self.may_mark_as_sent?
    self.system_driven_event = false
  end

  def payer_name
    payer.full_name if payer.present?
  end

  def patient_name
    treatment.to_s
  end

  def field_staff
    if source.is_a? TreatmentVisit
      source.visited_user.full_name
    else
      ' '
    end
  end

  def invoice_no
    self.invoice_package.package_number if self.invoice_package.present?
  end

  def total_amount
    visit_type_rate * no_of_units if visit_type_rate
  end

  def invoice_number
    self.private_insurance_invoice.invoice_number
  end

  def balance_amount
    if total_amount
      received_amount.present? ? (total_amount - received_amount) : total_amount
    else
      0
    end
  end

  def is_private_ins_receivable?
    payer.is_a? InsuranceCompany and payer.private_insurance?
  end

  def update_due_date
    due_days = payer.claim_submission_due_days
    self.due_date = due_days.present? ? receivable_date + due_days : receivable_date
  end

  def visit_status_display
    source.visit_status.to_s.titleize
  end

  def unit
    treatment.insurance_bill_type
  end

  def units_display
    RECEIVABLE_UNITS[unit]
  end

  def no_of_units
    source.ins_no_of_units
  end

  def receivable_status
    STATE_MAP.invert[read_attribute(:receivable_status)]
  end

  private

  def set_defaults
    self.org ||= Org.current
  end

  def set_purpose
    self.purpose = "#{source}" if purpose.nil? and source.present?
    if self.private_insurance_invoice
      self.payer = private_insurance_invoice.payer
      self.treatment = private_insurance_invoice.treatment
      self.treatment_episode = private_insurance_invoice.treatment_episode
    end
  end

end