# == Schema Information
#
# Table name: invoice_payments
#
#  id                       :integer          not null, primary key
#  invoice_id               :integer          not null
#  org_id                   :integer          not null
#  payment_date             :date             not null
#  payer_type               :string(255)      not null
#  payer_id                 :integer          not null
#  payment_amount           :decimal(8, 2)    not null
#  payment_status           :string(1)        not null
#  payment_description      :text
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  payment_reference_number :string(255)      not null
#

class InvoicePayment < ActiveRecord::Base

  belongs_to :invoice
  has_many :receivables
  belongs_to :org
  belongs_to :payer, :polymorphic => true

  default_scope lambda {order("id DESC")}
  scope :org_scope, lambda{where(:org_id => Org.current) if Org.current}

  after_initialize :set_defaults, :if => :new_record?
  after_create :set_invoice_and_receivable_status
  before_destroy :revert_invoice_status_if_required

  audited :associated_with => :org, :allow_mass_assignment => true

  include AASM
  STATE_MAP = {:draft => 'D', :completed => 'C'}
  aasm :column => :payment_status do
    state :draft, :initial => true
    state :completed

    event :process do
      transitions :to => :completed, :from => :draft
    end

    event :undo do
      transitions :to => :draft, :from => :completed
    end
  end

  attr_accessor :system_driven_event, :payment_for

  netzke_attribute :payment_for

  def system_driven_event?
    self.system_driven_event == true
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr.to_sym == :payment_status
    write_attribute_without_mapping(attr, v)
  end

  def payment_status
    STATE_MAP.invert[read_attribute(:payment_status)]
  end

  def payer_name
    payer.full_name if payer.present?
  end

  def next_payment_reference_number(invoice_id)
    last_number = InvoicePayment.unscoped.where(["invoice_id = ?", invoice_id]).count
    invoice_number = Invoice.find(invoice_id).invoice_number
    "#{invoice_number}-" + "#{last_number + 1}".rjust(4, '0')
  end

  private

  def revert_invoice_status_if_required
    receivables.each{|r|
      r.system_driven_event = true
      r.undo! if r.may_undo?
      r.system_driven_event = false
    }
    self.receivables = []
    if self.invoice.invoice_payments.size == 1
      invoice.system_driven_event = true
      invoice.undo! if invoice.may_undo?
      invoice.system_driven_event = false
    end
    nil
  end

  def set_defaults
    self.org = Org.current
  end

  def set_invoice_and_receivable_status
    receivables.each{|r| r.receivable_status_change_for_paid_event }
    invoice.invoice_status_change_for_pay_event
  end

end
