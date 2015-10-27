# == Schema Information
#
# Table name: org_users
#
#  id           :integer          not null, primary key
#  org_id       :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default(0)
#  user_status  :string(1)        not null
#  verify_token :string(6)
#  role_type    :string(1)
#

class OrgUser < ActiveRecord::Base
  belongs_to :org
  belongs_to :user
  has_and_belongs_to_many :visit_types, :join_table => "org_field_staff_visit_types", :foreign_key => :org_user_id
  has_and_belongs_to_many :languages, :join_table => "user_languages", :foreign_key => :user_id

  audited :associated_with => :org, :allow_mass_assignment => true

  default_scope where(:user_status => 'A')
  scope :field_staffs, lambda {joins(:user).where({:user_status => STATE_MAP.values, :org_id => Org.current.id,
                              :users => {:user_type => ["FieldStaff", "LiteFieldStaff"]}}).order("users.last_name, users.first_name").readonly(false) if Org.current }

  scope :org_staffs, lambda {|org = Org.current| joins(:user).where({org_id: org.id, :users => {user_type: 'OrgStaff'}})}
  scope :pending_approval, lambda{field_staffs.where(:user_status => 'P').readonly(false) if Org.current}

  ADMIN = 'A'
  REGULAR = 'R'
  ROLE_TYPES = [['A', 'Admin'],['R', 'Regular']]
  ROLE_TYPE_HASH = Hash[*ROLE_TYPES.flatten]

  after_create :set_user_email, :request_profile_access!, :if => :may_request_profile_access?
  before_create :assign_role_type_if_required
  after_create :initiate_visit_types

  attr_accessor :activation_token
  attr_accessor :user_email
  attr_accessor :fs_assigning_to_ha

  netzke_attribute :user_email

  validates :user, :presence => true
  validates :user_email, :presence => true, :if => :fs_assigning_to_ha_and_fs_is_lfs

  include AASM
  STATE_MAP = {:new => 'N', :pending_approval => 'P', :in_review => 'I', :active => 'A', :rejected => 'X', :inactive => 'D'}
  STATUS_STORE = STATE_MAP.collect{|k,v| [v.to_s, k.to_s.titleize]}.last(4).unshift(["", "---"])
  aasm :column => :user_status do
    state :new, :initial => true
    state :pending_approval, :after_enter => :send_activation_request
    state :in_review
    state :active
    state :rejected
    state :inactive

    event :request_profile_access do
      transitions :to => :pending_approval, :from => :new
    end

    event :enter_verification_token, :before => :verify_activation_token do
      transitions :to => :in_review, :from => :pending_approval
    end

    event :activate do
      transitions :to => :active, :from => :in_review
      transitions :to => :active, :from => :inactive

    end

    event :inactivate do
      transitions :to => :inactive, :from => :active
    end

    event :reject do
      transitions :to => :rejected, :from => :in_review
    end

    event :rejected_by_user do
      transitions :to => :rejected, :from => :pending_approval
    end

    event :resend_profile_request do
      transitions :to => :pending_approval, :from => [:pending_approval, :rejected]
    end
  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :user_status
    write_attribute_without_mapping(attr, v)
  end

  def user_status
    STATE_MAP.invert[read_attribute(:user_status)]
  end

  def admin?
    role_type == ADMIN
  end

  def office_staff
    User.current.to_s
  end

  def fs_assigning_to_ha_and_fs_is_lfs
    return false unless user
    (self.fs_assigning_to_ha and user.is_a? LiteFieldStaff)
  end

  def send_activation_request
    verify_token = Array.new(6){rand(36).to_s(36)}.join
    debug_log verify_token
    self.update_attribute(:verify_token, verify_token)
    os = office_staff
    spawn_block do
      FasternotesMailer.profile_access_request(self, os).deliver
    end
  end

  def set_user_email
    self.user.upgrade_to_a_full_fledged_field_staff(self.user_email) if self.user.is_a? LiteFieldStaff
  end

  def verify_activation_token
    self.verify_token == activation_token
  end

  alias_method :enter_verification_token_original!, :enter_verification_token!

  def enter_verification_token!
    enter_verification_token_original! if verify_activation_token
  end

  private

  def assign_role_type_if_required
    self.role_type = REGULAR if (self.role_type.nil? and self.user.user_type == 'OrgStaff')
  end

  def initiate_visit_types
    return true unless self.user.is_a? FieldStaff
    v_types = Org.current.visit_types.select{|x| x.license_types.include?(user.license_type) and x.discipline.present?}
    v_types.each{|v| self.visit_types << v }
    self.save!
  end
end
