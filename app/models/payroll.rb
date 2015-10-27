# == Schema Information
#
# Table name: payrolls
#
#  id                  :integer          not null, primary key
#  payroll_date        :date             not null
#  org_id              :integer          not null
#  payee_type          :string(50)       not null
#  payee_id            :integer          not null
#  payroll_amount      :decimal(8, 2)    not null
#  payroll_status      :string(2)        not null
#  paid_date           :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  payroll_reference   :string(20)       not null
#  payroll_description :string(255)
#
require 'jasper-rails'
class Payroll < ActiveRecord::Base
  include JasperRails
  include ActionView::Helpers::NumberHelper
  include PayrollReportDataSource

  audited :associated_with => :org, :allow_mass_assignment => true

  before_destroy :revert_payables_state
  
  def revert_payables_state
    self.payables.each {|payable|
      payable.system_driven_event = true        
      payable.revert_status_to_unpaid! if payable.may_revert_status_to_unpaid?
      payable.system_driven_event = false 
    }
    true
  end 
  
  default_scope lambda {order("payroll_date DESC")}
  belongs_to :org
  has_many :payables, :dependent => :nullify
  belongs_to :payee, :polymorphic => true
  belongs_to :office_staff, :class_name => "User"

  validates_presence_of :payroll_date, :payroll_amount
  before_create :assign_org, :generate_reference
  before_create :assign_org
  after_create :set_payable_as_paid
  
  scope :org_scope, lambda { where(['org_id =?', Org.current.id]) if Org.current }
  scope :fs_scope, lambda { includes(:org).where(["payee_id = ? AND payee_type = ? AND orgs.id IN (SELECT org_id FROM org_users
              WHERE user_id = ? AND user_status = ?)", User.current.id, 'User', User.current.id, "A"])}

  attr_accessor :actual_payroll_ids, :report_context, :payroll_individual_print
  
  
  def health_agency
    org.org_name
  end
 
  def generate_reference
    begin
      self.payroll_reference = PayrollReferenceNumber.next_sequence(self)
    rescue Exception => e
      debug_log e.inspect
      raise e
    end
  end

  def payroll_amount_in_currency
    number_to_currency(payroll_amount, :format => "%n")
  end
  
  def self.create_payrolls
    payroll_ids = []
    payee_ids.each {|id|
	    selected_payables = payable_recs.select {|r| r.payee_id == id }
	    next if selected_payables.empty?
      if selected_payables.first.staffing_company?
        field_staff_ids = selected_payables.map(&:field_staff_id).uniq
        field_staff_ids.each {|fs_id|
          fs_payables = selected_payables.select{|p| p.field_staff_id == fs_id}
          payroll = create_payroll(fs_payables)
          payroll_ids << payroll.id
        }
      else
        payroll = create_payroll(selected_payables)
        payroll_ids << payroll.id
      end
    }
    payroll_ids
  end

  def self.payable_recs
    Payable.items_in_queue
  end

  def self.payee_ids
    payable_recs.map(&:payee_id).uniq
  end

  def self.create_payroll(payables)
    pay_amount = payables.map(&:adjusted_rate).sum
    p = Org.current.payrolls.build(:payroll_date => Time.current, :payee => payables.first.payee,
                                   :payroll_amount => pay_amount, :office_staff => User.current)
    p.payables << payables
    p.save!
    p
  end

  def payee_name
    "#{payee}"
  end

  def set_payable_as_paid
    self.payables.each {|payable|
      payable.system_driven_event = true        
      payable.mark_as_paid! if payable.may_mark_as_paid?
      payable.system_driven_event = false 
    }
    true
  end

  attr_accessor :filter_payables_by

  def filtered_payables
    payables.find_by_payee_id(filter_payables_by.id)
  end

  def payee_field_staff_name
    payable = payables.first
    (payable and payable.field_staff)? payable.field_staff.full_name : nil
  end

  def staff_type
    (payee.is_a? User)? "Field Staff" : "#{payee}"
  end

  def number_of_visits
    payables.size
  end

  def title
    payable = payables.first
    (payable and payable.field_staff)? payable.field_staff.license_type.license_type_description : nil
  end

  def org_name
    staffing_company? ? payee.to_s : Org.current.to_s
  end

  def actual_payrolls
    actual_payrolls_arr = []
    payrolls = fs_payrolls + sc_payrolls
      payrolls.each do |payroll|
        actual_payrolls_arr << {"field_staff" => payroll.payee_field_staff_name, "title" => payroll.title, "number_of_visits" => payroll.number_of_visits,
                                "org_name" => payroll.org_name, "payroll_amount" => payroll.payroll_amount}
      end    
    actual_payrolls_arr
  end

   private

  def assign_org
    self.org = Org.current
  end
end
