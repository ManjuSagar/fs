# == Schema Information
#
# Table name: staffing_requests
#
#  id                       :integer          not null, primary key
#  staff_type               :string(100)      not null
#  staff_id                 :integer          not null
#  requested_date_time      :datetime         not null
#  request_status           :string(1)        not null
#  lock_version             :integer          default(0)
#  staffing_requirement_id  :integer          not null
#  discipline_id            :integer
#  visit_type_id            :integer
#  apply_patient_preference :string(1)
#

class StaffingRequest < ActiveRecord::Base
  include WelcomeHelper
  include AASM

  belongs_to :staffing_requirement
  belongs_to :discipline
  belongs_to :visit_type
  belongs_to :staff, :polymorphic => true
  has_and_belongs_to_many :visit_types, :join_table => "staffing_request_visit_types"
  has_many :staffing_request_visit_types, :dependent => :destroy

  audited :associated_with => :staffing_requirement, :allow_mass_assignment => true
  has_associated_audits

  default_scope lambda{order("requested_date_time DESC")}

  scope :fs_staffing_request, lambda {|request_filter| where(["staff_type = ? and staff_id = ? and request_status IN (?)", "User", User.current.id, request_filter]) if User.current}

  APPLY_PATIENT_PREFERENCE = '0'
  DONT_APPLY_PATIENT_PREFERENCE = '1'
  ACTIVE = ['N', 'E', 'D']
  ARCHIVE = ['S', 'C']

  before_create :set_defaults
  #after_create :send_email_notification
  after_initialize :init_staffing, :if => :new_record?
  after_create :create_visit_types
  after_save :send_email_notification_if_required
  validates_uniqueness_of :staff_id, :scope => [:staff_type, :staffing_requirement_id]
  netzke_attribute :send_notification
  attr_accessor :send_notification

  store :data, :accessors => ["previous_request_status", "staff_finalized"]

  STATE_MAP = {:new => 'N', :declined => 'D', :interested => 'E', :selected => 'S', :cancelled => 'C'}

  aasm :column => :request_status do
    state :new, :initial => true
    state :declined
    state :interested, :after_enter => :deallocate_staff
    state :selected, :after_enter => :allocate_staff
    state :cancelled, :after_enter => :deallocate_staff

    event :interested do
      transitions :from => :new, :to => :interested
    end

    event :undo do
      transitions :from => :interested, :to => :new, :guard => :previous_status_is_new_and_staff_not_finalized?
      transitions :from => :declined, :to => :new, :guard => :previous_status_is_new_and_staff_not_finalized?
      transitions :from => :selected, :to => :interested, :guard => :current_user_is_office_staff_and_previous_status_is_interested_and_staff_not_finalized?

      transitions :from => :cancelled, :to => :new, :guard => :current_user_is_office_staff_and_previous_status_is_new_and_staff_not_finalized?
      transitions :from => :cancelled, :to => :interested, :guard => :current_user_is_office_staff_and_previous_status_is_interested_and_staff_not_finalized?
      transitions :from => :cancelled, :to => :selected, :guard => :current_user_is_office_staff_and_previous_status_is_selected_and_staff_not_finalized?
      transitions :from => :cancelled, :to => :declined, :guard => :current_user_is_office_staff_and_previous_status_is_declined_and_staff_not_finalized?
    end

    event :decline do
      transitions :from => :new, :to => :declined
    end

    event :select do
      transitions :from => :interested, :to => :selected, :guard => :current_user_is_office_staff?
    end

    event :cancel do
      transitions :from => [:new, :interested, :selected], :to => :cancelled, :guard => :current_user_is_office_staff_and_staff_not_finalized?
    end

  end

  alias_method :write_attribute_without_mapping, :write_attribute
  def write_attribute(attr, v)
    v = STATE_MAP[v.to_sym] if attr == :request_status
    write_attribute_without_mapping(attr, v)
  end

  def request_status
    STATE_MAP.invert[read_attribute(:request_status)]
  end

  def send_email_notification_if_required
    if send_notification
      spawn_block do
        send_email_notification
      end
    end
  end

  def staff_not_finalized?
    self.staff_finalized != true
  end

  def staff_finalized?
    self.staff_finalized == true
  end

  def field_staff?
    User.current.is_a? FieldStaff
  end

  def current_user_is_office_staff_and_previous_status_is_new_and_staff_not_finalized?
    current_user_is_office_staff_and_staff_not_finalized? and previous_status_is_new?
  end

  def current_user_is_office_staff_and_previous_status_is_interested_and_staff_not_finalized?
    current_user_is_office_staff_and_staff_not_finalized? and previous_status_is_interested?
  end

  def current_user_is_office_staff_and_previous_status_is_selected_and_staff_not_finalized?
    current_user_is_office_staff_and_staff_not_finalized? and previous_status_is_selected?
  end

  def current_user_is_office_staff_and_previous_status_is_declined_and_staff_not_finalized?
    current_user_is_office_staff_and_staff_not_finalized? and previous_status_is_declined?
  end

  def current_user_is_office_staff_and_staff_not_finalized?
    current_user_is_office_staff? and staff_not_finalized?
  end

  def previous_status_is_new_and_staff_not_finalized?
    previous_status_is_new? and staff_not_finalized?
  end

  def previous_status_is_new?
    self.previous_request_status == :new
  end

  def previous_status_is_interested?
    self.previous_request_status == :interested
  end

  def previous_status_is_selected?
    self.previous_request_status == :selected
  end

  def previous_status_is_declined?
    self.previous_request_status == :declined
  end

  def allocate_staff
    staffing_requirement.allocate_staff(self)
  end

  def deallocate_staff
    staffing_requirement.deallocate_staff(self) if previous_status_is_selected?
  end

  def staff_full_name
    if staff.present?
      staff.phone_number.present? ?  "#{self.staff.full_name} - #{self.staff.phone_number}" : self.staff.full_name
    end
  end

  def staff_name
    (staff.is_a? StaffingCompany) ? staff.org_name : staff.first_name
  end

  def send_email_notification
    os = office_staff
    FasternotesMailer.staffing_invitation(self, os).deliver
  end

  def required_visit_types
    visit_type = staffing_requirement.visit_type
    visit_type.present? ? visit_type.visit_type_description : nil
  end

  def self.get_statuses(params)
    arr = []
    arr << ACTIVE if params[:active]
    arr << ARCHIVE if params[:archive]
    arr.flatten
  end

  def status_display
    if request_status == :interested
      "FS Interested"
    elsif request_status == :declined
      "FS Declined"
    else
      request_status.to_s.titleize
    end
  end

  def gender_requirements
    staffing_requirement.gender_requirements
  end

  def languages_preferred
    staffing_requirement.languages_preferred
  end

  def special_instructions_required
    staffing_requirement.special_instructions_required
  end

  def health_agency
    staffing_requirement.health_agency
  end

  def agency_email
    health_agency.email
  end

  def agency_phone_number
    health_agency.phone_number
  end

  def provider_name
    health_agency.org_name.upcase
  end

  def provider_address
    " #{health_agency.street_address}, Suite #{health_agency.suite_number} "
  end

  def provider_city_details
    "#{health_agency.city}, #{state_description(health_agency.state)} #{health_agency.zip_code}"
  end

  def state_description(state_code)
    State.find_by_state_code(state_code).state_code if state_code
  end

  def provider_full_address
    provider_address + ' ' +  provider_city_details
  end

  def provider_contact
    contact = ""
    contact = "Tel #{health_agency.phone_number}" if health_agency.phone_number.present?
    contact += ", " if health_agency.phone_number && health_agency.fax_number
    contact += "Fax #{health_agency.fax_number}" if health_agency.fax_number.present?
    contact
  end


  def office_staff
    User.current
  end

  private

  def init_staffing
    self.apply_patient_preference = APPLY_PATIENT_PREFERENCE
  end

  def set_defaults
    self.requested_date_time = Time.current
    self.request_status = "N"
  end

  def create_visit_types
    if discipline and visit_type
      self.visit_types << visit_type
    elsif discipline and not visit_type
      discipline.visit_types.org_scope.select{|vt|
        if staff.is_a?(FieldStaff)
          vt.license_types.include?(staff.license_type)
        else
          true #For staffing company, currently if they do a discipline we assume they can do all visit types
        end
      }.each{|vt| self.visit_types << vt unless vt.optional_flag}
    elsif discipline.nil?
      self.visit_types << visit_type
    end
  end

end
