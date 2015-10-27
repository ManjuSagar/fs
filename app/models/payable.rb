# == Schema Information
#
# Table name: payables
#
#  id             :integer          not null, primary key
#  txn_date       :date             not null
#  payable_type   :string(2)        not null
#  source_type    :string(50)
#  source_id      :integer
#  payable_status :string(2)        not null
#  org_id         :integer          not null
#  payee_type     :string(50)       not null
#  payee_id       :integer          not null
#  payable_amount :decimal(8, 2)    not null
#  payroll_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  purpose        :string(100)
#

class Payable < ActiveRecord::Base

  include ActionView::Helpers::NumberHelper

  default_scope lambda {order("payables.id DESC")}
  attr_accessor :payroll_id

  scope :org_scope, lambda{where(['org_id =?', Org.current.id]) if Org.current}
  scope :to_be_paid, where('payroll_id is NULL')
  scope :paid_payables, lambda{where(["payable_status = ?", 'P'])}
  scope :unpaid_payables, lambda{org_scope.where(["payable_status = ?", 'U'])}
  scope :items_in_queue, lambda{org_scope.where(["payable_status = ?", 'Q'])}
  scope :not_in_queue, lambda{org_scope.where(["payable_status = ?", 'U'])}

  audited :associated_with => :org, :allow_mass_assignment => true

  belongs_to :payroll
  belongs_to :org
  belongs_to :source, :polymorphic => true
  belongs_to :payee, :polymorphic => true
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :field_staff
  belongs_to :processed_user, class_name: "User"

  validates_presence_of :visit_date, :payable_amount, :payable_type, :adjusted_rate
  validates_numericality_of :payable_amount, :adjusted_rate
  validates :purpose, :length => { :maximum => 100 }
  before_validation :set_defaults, :if => :new_record?
  before_destroy :delete_payrolls_if_required

  PAYABLE_STATUS = {:unpaid => 'U', :in_queue => 'Q', :paid => 'P'}
  PAYABLE_TYPES = [['V', 'Treatment Visit'],['D', 'Document'], ['O', 'Others']]
  PAYABLE_UNITS = {'V' => "Visit", 'H' => "Hour"}

  def patient_name
    self.treatment.patient.to_s
  end

  def visit_type
    self.purpose
  end

  def visit_date_display
    visit_date.strftime("%m/%d/%Y") if visit_date.present?
  end

  def submission_date_display
    submission_date.strftime("%m/%d/%Y") if submission_date.present?
  end

  def staffing_company
    staffing_company? ? payee.full_name : nil
  end

  def no_of_units_display
   "%g" % no_of_units if no_of_units
  end

  #Overriding to_xml in different way
  alias_method :ar_to_xml, :to_xml

  def to_xml(options = {}, &block)
    default_options = { :methods => [:patient_name, :visit_type, :field_staff_name, :staffing_company, :visit_date_display,
        :submission_date_display, :units_display, :no_of_units_display]}
    self.ar_to_xml(options.merge(default_options), &block)
  end

  include AASM
  
  aasm :column => :payable_status do
    state :unpaid, :initial => true
    state :in_queue
    state :paid

    event :mark_as_paid do
      transitions :from => :in_queue, :to => :paid, :guard => :system_driven_event?
    end

    event :process do
      transitions :from => :unpaid, :to => :in_queue
    end

    event :un_process do
      transitions :from => :in_queue, :to => :unpaid
    end
    
    event :revert_status_to_unpaid, :before => :remove_from_payroll do
      transitions :from => :paid, :to => :unpaid, :guard => lambda {|p| p.current_user_is_office_staff? }
    end
  end
   
  attr_accessor :system_driven_event

  def system_driven_event?
    self.system_driven_event == true
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, p)
    p = PAYABLE_STATUS[p.to_sym] if attr.to_sym == :payable_status
    write_attribute_without_mapping(attr, p)
  end
  
  def payable_status
    PAYABLE_STATUS.invert[read_attribute(:payable_status)]
  end

  def current_user_is_office_staff?
    User.current.office_staff?
  end

  def payee_name
    "#{payee}"
  end

  def field_staff_name
    name = if payee.is_a? StaffingCompany and source.is_a? TreatmentVisit
             source.visited_user.full_name
           else
             "#{payee}"
           end
  end

  def staff_type
    (payee.is_a? User)? "Field Staff" : "#{payee}"
  end

  def payable_amount_in_currency
    number_to_currency(payable_amount, :format => "%n")
  end

  def source_name
    (source.is_a? TreatmentVisit) ? source.requirements_code : "#{source}"
  end

  def current_status
    if source.is_a? TreatmentVisit
      status = source.visit_status
      if status == :pending_supervisor_signature || status == :pending_field_staff_signature
        return "Pending Staff"
      elsif status == :pending_staff_signature
        return "Pending Agency"
      else
        return status.to_s.titleize
      end
    end
  end

  def staffing_company?
    payee.is_a? StaffingCompany
  end

  def units_display
    PAYABLE_UNITS[unit]
  end
  
 
  private

  def remove_from_payroll
    payroll = self.payroll
    if (payroll.payables.size == 1)
      payroll.payables = []
      payroll.destroy
    else
      self.payroll = nil
    end

  end

  def set_defaults 
    assign_org
    self.visit_date = source.visit_date if (source.is_a? TreatmentVisit)
    self.adjusted_rate = payable_amount
    self.purpose = source_name if source.nil? == false 
  end
  
  def assign_org
    self.org ||= Org.current
  end

  def delete_payrolls_if_required
    if self.payroll and self.payroll.payables.size == 1
      self.payroll.destroy
    end
  end
end
