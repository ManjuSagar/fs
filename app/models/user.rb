# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  first_name              :string(100)      not null
#  last_name               :string(100)      not null
#  suite_number            :string(15)
#  street_address          :string(50)
#  city                    :string(50)
#  state                   :string(2)
#  zip_code                :string(10)
#  phone_number            :string(15)
#  user_type               :string(50)
#  lock_version            :integer          default(0)
#  approved                :boolean          default(FALSE), not null
#  gender                  :string(1)
#  signature_file_name     :string(255)
#  signature_content_type  :string(255)
#  signature_file_size     :integer
#  signature_updated_at    :datetime
#  middle_initials         :string(2)
#  suffix                  :string(10)
#  ethnicity               :string(20)
#  encrypted_sign_password :string(255)
#

class User < ActiveRecord::Base

  has_many :payables, :as => :payee, :dependent => :destroy
  has_many :payrolls, :as => :payee, :dependent => :destroy
  
  has_many :org_users, :dependent => :destroy
  has_many :orgs, :through => :org_users, :dependent => :destroy
  has_and_belongs_to_many :languages, :join_table => "user_languages"
  has_and_belongs_to_many :ethnicities, :join_table => "user_ethnicities"
  has_and_belongs_to_many :visit_types, :join_table => "org_field_staff_visit_types", :foreign_key => :org_user_id
  has_attached_file :signature, :styles => {:thumb => "200x200" }
  before_save :encrypt_signed_password
  self.inheritance_column = :user_type
  after_initialize :set_approved_flag, :if => :new_record?
  after_create :send_admin_mail
  scope :org_scope, lambda { includes(:org_users).where({:org_users => {:org_id => Org.current.id}}).order("users.last_name, users.first_name") if Org.current}

  audited :allow_mass_assignment => true
  has_associated_audits

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :approved,
                  :suite_number, :street_address, :city, :state, :zip_code, :phone_number, :encrypted_password, :sign_in_count
  attr_accessor :sign_password, :sign_password_confirmation
  netzke_attribute :sign_password
  netzke_attribute :sign_password_confirmation

  USER_ROLES = {:SA => "Super Admin", :HA => "Health Agency", :SC => "Staffing Company", :FS => "Field Staff"}

  GENDERS = [['M', 'Male'],['F', 'Female']]

  validates :first_name, presence: true, length: {maximum: 100}
  validates :last_name, presence: true, length: {maximum: 100}
  #validates :sign_password, presence: true
  #validates_presence_of  :sign_password
  validates_confirmation_of :sign_password
  validates_length_of :sign_password, :within => Devise.password_length, :allow_blank => true
  validates_presence_of :sign_password_confirmation, :if => :sign_password
  validates :middle_initials, length: {maximum: 2}
  validates :zip_code, length: {maximum: 5}
  validates_presence_of :zip_code, :if => :zip_code_required?
  validate :valid_zip_code_check
  validates :street_address, length: {maximum: 50}
  validates :suite_number, length: {maximum: 10}
  validates :city, length: {maximum: 50}
  validate :phone_number_mandatory
  validate :check_confirm_password

  def active_for_authentication?
    os = OrgUser.unscoped.find_by_user_id self.id
    if self.user_type == "OrgStaff"
      super && approved? && os.user_status == :active
    else
      super && approved?
    end
  end

  def address_string
    "#{street_address} #{suite_number}, #{city}, #{state}, #{zip_code}"
  end

  def location
    ["#{street_address}", "#{suite_number}", "#{city}", "#{state}", "#{zip_code}"].reject{|x| x.blank?}.join(", ")
  end

  def address_line_1
    suite_string = "Suite" if suite_number.present?
    ["#{street_address}", "#{suite_string} #{suite_number}"].reject{|x| x.blank?}.join(", ")
  end

  def address_line_2
    ["#{city}", "#{state} #{zip_code}"].reject{|x| x.blank?}.join(", ")
  end

  def gender_string
    GENDERS.detect{|g| g.first == gender}[1]
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def send_admin_mail
    #AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  def default_org
    orgs.first
  end

  def super_admin?
    self.is_a? SuperAdmin
  end

  def field_staff?
    self.is_a? FieldStaff
  end

  def consultant?
    self.is_a? Consultant
  end

  def office_staff?
    (self.is_a? OrgStaff or clinical_staff?)
  end

  def clinical_staff?
    User.current.field_staff? and User.current.clinical_staff.present?
  end

  def patient?
    self.is_a? Patient
  end

  def zip_code_required?
    patient? or self.user_type == "FieldStaff"
  end

  def to_s
    full_name
  end

  def user_profile_completed?
    return true if (self.super_admin? || self.consultant?)
    User.current.encrypted_sign_password.present? and User.current.signature?
  end

  def full_name(include_suffix = false)
    name = "#{first_name} #{last_name}"
    if include_suffix
      [name, suffix].reject{|n| n.blank?}.join(", ")
    else
      name
    end

  end

  def self.current=(user_obj)
    Thread.current[:user] = user_obj
    Org.current = user_obj.default_org if user_obj
  end

  def self.current
    Thread.current[:user]
  end

  def set_approved_flag
    self.approved = true # This is temporary until we make this conditional
  end

  def reset_user_password
    self.password = self.password_confirmation = Array.new(8){rand(36).to_s(36)}.join
    self.save!
  end

  def valid_sign_password?(password)
    return false if encrypted_sign_password.blank?
    bcrypt   = ::BCrypt::Password.new(encrypted_sign_password)
    password = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt.salt)
    Devise.secure_compare(password, encrypted_sign_password)
  end

  def default_email?
    return @def_email if defined?(@def_email)
    @def_email = self.email.end_with?("default@fasternotes.com")
  end

  def phone_number_without_separator
    phone_num = phone_number
    phone_num = phone_number_2 if (phone_num.nil? or (phone_num and phone_num.size < 0))
    (phone_num[1..3] + phone_num[6..8] + phone_num[10..13]).to_i if phone_num
  end

  def phone_numbers
    p = []
    p << phone_number if phone_number
    p << phone_number_2 if phone_number_2
    p
  end

  def atleast_one_phone_number
    return phone_number if phone_number
    return phone_number_2 if phone_number_2
  end

  def check_confirm_password
    if ((password.present? == true) and (password_confirmation.present? == false))
      errors.add(:password_confirmation, "is required.")
    end
  end

  def valid_zip_code_check
    return if zip_code.nil?
    self.errors.add(:zip_code, " is not valid.") unless ZipCode.find_by_zip_code(zip_code)
  end

 private
  def encrypt_signed_password
    self.encrypted_sign_password = BCrypt::Password.create(sign_password) if sign_password.present?
  end

  def phone_number_mandatory
    return unless user_type == "Patient"
    res = self.phone_number || phone_number_2
    self.errors.add(:phone_number, " is required." ) unless res
  end

end
