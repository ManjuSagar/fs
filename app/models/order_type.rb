# == Schema Information
#
# Table name: order_types
#
#  id               :integer          not null, primary key
#  type_description :string(50)       not null
#  lock_version     :integer          default(0)
#  type_code        :string(255)      not null
#

class OrderType < ActiveRecord::Base

  validates :type_description, :presence => true, :length => {:maximum => 50}
  belongs_to :org

  scope :org_scope, lambda{where(["org_id = ?", Org.current]).order("order_types.type_description") if Org.current}
  scope :active_scope, lambda{|org, date| where(["org_id = #{org.id} AND ((type_status = 'A' AND disabled_date is null) OR '#{date.strftime("%Y-%m-%d")}' <= disabled_date)"])}

  audited :associated_with => :org, :allow_mass_assignment => true

  include AASM
  STATE_MAP = {:active => 'A', :disabled => 'D'}
  STATUS_STORE = STATE_MAP.collect{|k,v| [v.to_s, k.to_s.titleize]}.last(5).unshift(["", "---"])
  aasm :column => :type_status do
    state :active, :initial => true
    state :disabled

    event :disable do
      transitions :to => :disabled, :from => :active, :guard =>  lambda{|r| r.system_required == false}
    end

    event :activate do
      transitions :to => :active, :from => :disabled, :guard =>  lambda{|r| r.system_required == false}
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :type_status
    write_attribute_without_mapping(attr, v)
  end

  def type_status
    STATE_MAP.invert[read_attribute(:type_status)]
  end

  def self.eval(org_id = Org.current.id)
    find_by_type_code_and_org_id("EVAL", org_id)
  end

  def self.plan_of_care(org_id = Org.current.id)
    find_by_type_code_and_org_id("PLAN_OF_CARE", org_id)
  end

  def self.hold(org_id = Org.current.id)
    find_by_type_code_and_org_id("HOLD_DISP", org_id)
  end

  def self.unhold(org_id = Org.current.id)
    find_by_type_code_and_org_id("UNHOLD_DISP", org_id)
  end

  def self.discharge(org_id = Org.current.id)
    find_by_type_code_and_org_id("DISCHARGE_DISP", org_id)
  end

  def self.other(org_id = Org.current.id)
    find_by_type_code_and_org_id("OTHER", org_id)
  end

  def self.face_to_face(org_id = Org.current.id)
    find_by_type_code_and_org_id("FACE_TO_FACE", org_id)
  end

  def order_type_store
    OrderType.org_scope.collect{|o| [o.id, o.type_description]}.unshift(["", "---"])
  end


end
