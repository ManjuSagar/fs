# == Schema Information
#
# Table name: attachment_types
#
#  id                     :integer          not null, primary key
#  attachment_code        :string(50)       not null
#  attachment_description :string(100)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class AttachmentType < ActiveRecord::Base

  validates :attachment_code, :presence => true, :length => {:maximum => 50}
  validates :attachment_description, :presence => true, :length => {:maximum => 100}
  belongs_to :org

  audited :associated_with => :org, :allow_mass_assignment => true

  scope :org_scope, lambda{where(["org_id = ?", Org.current]).order("attachment_types.attachment_description") if Org.current}
  scope :active_scope, lambda{|date| org_scope.where(["(type_status = 'A' AND disabled_date is null) OR '#{date.strftime("%Y-%m-%d")}' <= disabled_date"])}

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

  def self.route_sheet(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("ROUTE_SHEET", org_id)
  end

  def self.referral(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("REFERRAL", org_id)
  end

  def self.signature(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("SIGNATURE", org_id)
  end

  def self.map(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("MAP", org_id)
  end

  def self.medical_order(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("MEDICAL_ORDER", org_id)
  end

  def self.document(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("DOCUMENT", org_id)
  end

  def self.others(org_id = Org.current.id)
    find_by_attachment_code_and_org_id("OTHERS", org_id)
  end

  def to_s
    attachment_description
  end
end
