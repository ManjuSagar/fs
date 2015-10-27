# == Schema Information
#
# Table name: orgs
#
#  id                   :integer          not null, primary key
#  org_name             :string(100)      not null
#  org_type             :string(50)       not null
#  org_package          :string(2)        not null
#  week_start_day       :string(3)        not null
#  suite_number         :string(15)
#  street_address       :string(50)       not null
#  city                 :string(50)       not null
#  state                :string(2)        not null
#  zip_code             :string(10)       not null
#  email                :string(100)      not null
#  preferred_alert_mode :string(1)        not null
#  notes                :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  phone_number         :string(15)
#  fax_number           :string(15)
#  lock_version         :integer          default(0)
#
require 'jasper-rails'
class Org < ActiveRecord::Base
  include JasperRails
  has_many :org_users, :dependent =>  :destroy
  has_many :users, :through => :org_users
  has_many :org_physicians, :dependent =>  :destroy
  has_many :physicians, :through => :org_physicians
  has_many :field_staffs, :through => :org_users, :source => :user, :conditions => ["user_type = 'FieldStaff'"]
  has_many :contacts, :class_name => 'OrgContact', :dependent => :destroy
  has_many :visit_types, :dependent => :destroy
  has_many :document_definitions
  has_many :free_form_templates, :dependent => :destroy
  has_many :vitals_reference_ranges, :dependent => :destroy
  has_many :reference_numbers
  has_many :payables
  has_many :payrolls
  has_many :receivables
  has_many :invoices
  has_many :private_insurance_invoices
  has_many :invoice_payments
  has_many :supplies
  has_many :insurance_companies
  has_many :attachment_types
  has_many :order_types
  has_one :health_agency_detail, :dependent =>  :destroy, :foreign_key => :health_agency_id
  self.inheritance_column = :org_type
  attr_accessible :zip_code_part2
  audited :allow_mass_assignment => true
  has_associated_audits

  attr_accessible :org_type
  ALERT_MODES = [['E', 'Email'],['P', 'Phone Number']]
  WEEK_DAYS = [['SUN', 'Sunday'],['MON', 'Monday'],['TUE', 'Tuesday'],['WED', 'Wednesday'],['THU', 'Thursday'],['FRI', 'Friday'],['SAT', 'Saturday']]
  ORG_PACKAGES = [['F','Free'],['C', 'Classic'],['S','Silver'],['P','Platinum']]
  ORG_TYPES = [['HealthAgency', 'Health Agency'], ['StaffingCompany', 'Staffing Company']]
  WEEK_DAYS_NUMBER = {:SUN => 0, :MON => 1, :TUE => 2, :WED => 3, :THU => 4, :FRI => 5, :SAT => 6}

  attr_accessor :primary_contact_first_name, :primary_contact_last_name, :primary_contact_phone_number,
                :primary_contact_extension, :primary_contact_email, :primary_contact_password, :primary_contact_password_confirmation

  validates :org_name, presence: true
  validate :check_org_type
  validates :org_type, presence: true
  validates :week_start_day, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, length: { is: 5, message: "part 1 must be 5 digits" }
  validates :email, presence: true
  validates :org_package, presence: true
  validates :preferred_alert_mode, presence: true
  validates :fed_tax_number, presence: true, length: {maximum: 9}, :format => {:with => /^[0-9]{9}/, message: "Tax Id Must contain the 9 digit number"}
  validate :validate_branch_id

  validates :primary_contact_first_name, presence: true, on: :create, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validates :primary_contact_last_name, presence: true, on: :create, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validates :primary_contact_phone_number, presence: true, on: :create, :if => lambda{|r| r.org_type != "ConsultingCompany" }

  #validates_uniqueness_of    :primary_contact_email, :case_sensitive => false, :allow_blank => true, :on => :create
  validates :primary_contact_email, :presence => true, on: :create, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validates_format_of :primary_contact_email, :with  => Devise.email_regexp, :allow_blank => true, :on => :create, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validates_presence_of   :primary_contact_password, :on=>:create, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validates_confirmation_of   :primary_contact_password, :on=>:create, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validates_length_of :primary_contact_password, :within => Devise.password_length, :allow_blank => true, :if => lambda{|r| r.org_type != "ConsultingCompany" }
  validate :check_primary_contact_password_confirmation, :if => lambda{|r| r.org_type != "ConsultingCompany" }

  scope :health_agency_scope, lambda{where(:org_type => "HealthAgency")}

  scope :field_staff_scope, lambda{ health_agency_scope.includes( :org_users).where({:org_users => {:user_id => User.current.id}}).order("org_name")}

  def to_s
    org_name
  end

  def is_ha?
    self.org_type == "HealthAgency"
  end

  def week_start_day_index
    WEEK_DAYS.index{|w| w[0] == week_start_day}
  end

  def week_days
    days_array = WEEK_DAYS[week_start_day_index..6]
    days_array += WEEK_DAYS[0..(week_start_day_index-1)] if week_start_day_index > 0  # Remember in Ruby 0..-1 is full array again
    days_array.collect{|w| w[1]}
  end

  def address_string
    agency_address1 + " " + agency_address2
  end

  def agency_address1
    street = []
    street << street_address unless street_address.blank?
    street << "Suite " + suite_number unless suite_number.blank?
    street.join(", ")
  end

  def agency_address2
    street = []
    street << city unless city.blank?
    street << ["#{state} #{zip_code}"].reject{|x| x.blank?}
    street.join(", ")
  end

  def agency_address_string
    if suite_number?
     "#{street_address} <b>. </b> Suite #{suite_number} <b>. </b> #{city} #{state} #{zip_code}"
    else
      "#{street_address} <b>. </b> #{city} #{state} #{zip_code}"
    end
  end


  def location
    "#{city}, #{state}-#{zip_code}"
  end

  def contact_details
    phone = []
    phone << "Tel " + phone_number unless phone_number.blank?
    phone << "Fax " + fax_number unless fax_number.blank?
    phone.join(" ")
  end

  def office_staff_name
    users.where(user_type: "OrgStaff").first.full_name
  end

  def agency_provider_number
    health_agency_detail.provider_number
  end

  after_create :save_contact_and_user, :create_health_agency_detail_if_required

  def save_contact_and_user
    return true if self.draft_status
    u = User.find_by_email(primary_contact_email)
    unless u
      u = User.new
      u.email = primary_contact_email
      u.first_name = primary_contact_first_name
      u.last_name = primary_contact_last_name
      u.password = primary_contact_password
      u.password_confirmation = primary_contact_password_confirmation
      u.user_type = "OrgStaff"
      u.save
    end
    org_user = self.org_users.build(org: self, user: u, role_type: "A")
    org_user.save!

    c = OrgContact.new
    c.contact_first_name = primary_contact_first_name
    c.contact_last_name = primary_contact_last_name
    c.phone_number = primary_contact_phone_number
    c.extension = primary_contact_extension
    c.email = primary_contact_email
    c.contact_type = ContactType.find_by_type_name("Authorized Representative")
    c.org_id = self.id
    c.save
  end

  def check_org_type
    if org_type == 'HealthAgency' and zip_code_part2 == nil
       errors.add(:zip_code_part_2, "can't be empty")
    elsif org_type == 'HealthAgency' and zip_code_part2.length != 4
      errors.add(:zip_code_part_2, 'must be 4 digits')
    end
  end

  def self.current=(org_obj)
    Thread.current[:org] = org_obj
  end

  def self.current
    Thread.current[:org]
  end

  def check_primary_contact_password_confirmation
    if ((primary_contact_password.present? == true) and (primary_contact_password_confirmation.present? == false))
      errors.add(:password_confirmation, "is required.")
    end
  end

  private

  def validate_branch_id
    msg = "Branch ID must contain the following N/P followed by 9 spaces or It must contain numbers or uppercase letters
            in bytes 1 and 2, Q in byte 3, numbers or uppercase letters in bytes 4 through 7, and numbers in bytes 8 through 10"
    if branch_id
      if branch_id.size == 1
        if (branch_id != "N" and branch_id != "P")
          errors.add("branch_id", msg)
        end
      else
        unless branch_id.match(/^[A-Z0-9]{2}Q[A-Z0-9]{4}[0-9]{3}$/)
          errors.add("branch_id", msg)
        end
      end
    end
  end

  def create_health_agency_detail_if_required
    self.health_agency_detail = HealthAgencyDetail.create!(:health_agency => self) if is_ha?
  end
end
