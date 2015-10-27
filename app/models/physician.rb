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

class Physician < User
  has_many :org_physicians, :dependent =>  :destroy
  has_many :orgs, :through => :org_physicians
  has_many :communication_notes
  attr_accessor :personal_phone_number_1, :personal_phone_number_2
  validate :check_npi_number, if: :new_record?

  audited :allow_mass_assignment => true
  has_associated_audits

  after_initialize :set_defaults
  before_validation :set_default_email
  #after_validation :check_errors

  default_scope lambda {order('users.last_name, users.first_name')}
  scope :physician_agency_specific, lambda{includes(:org_physicians).where(["org_physicians.org_id in (?)", Org.current.id])}
  def check_errors
    unless physician_detail.valid?
      physician_detail.errors.each do |k, v|
        self.errors.add(k, v)
      end
    end
  end

  def street_address
    org_physician.street_address if org_physician.present?
  end

  def city
    org_physician.city if org_physician.present?
  end

  def suite_number
    org_physician.suite_number if org_physician.present?
  end

  def state
    org_physician.state if org_physician.present?
  end

  def zip_code
    org_physician.zip_code if org_physician.present?
  end

  def phone_number
    org_physician.phone_number if org_physician.present?
  end


  def personal_phone_contact_1
    org_physician.personal_phone_number_1 if org_physician.present?
  end

  def personal_phone_contact_2
    org_physician.personal_phone_number_2 if org_physician.present?
  end

  def physician_email
    org_physician.email if org_physician.present?
  end

  def physician_fax_number
    org_physician.fax_number if org_physician.present?
  end

  def org_physician
    self.org_physicians.find_by_org_id(Org.current.id)
  end

  def full_name(include_suffix = false)
    super(true)
  end

  def full_name_without_suffix
    "#{first_name} #{last_name}"
  end

  def physcn_first_name
    "#{first_name}"
  end

  def physcn_last_name
    "#{last_name}"
  end

  def suffix
    org_physician.suffix if org_physician.present?
  end

  def physician_address
    address = []
    address << street_address unless street_address.blank?
    address << suite_number unless suite_number.blank?
    address << city unless city.blank?
    address << state unless state.blank?
    address << zip_code unless zip_code.blank?
    address.join(", ")
  end

  def send_medical_order(os, medical_order)
    FasternotesMailer.medical_order(medical_order, self, os).deliver
  end

  def office_staff
    User.current.to_s
  end

  def send_batch_of_medical_orders(os, order, physician_copy)
    FasternotesMailer.batch_medical_order(order, self, physician_copy, os).deliver
  end

  def self.physician_list_store
    all.collect{|p| [p.id, p.full_name] }.uniq
  end

  def check_npi_number
    org_phy = OrgPhysician.where("physician_id in (select physician_id from physician_details where npi_number = ? )",
                           self.npi_number).where("org_id = ?", Org.current.id)
    self.errors.add(:base, "This NPI number already exists") unless org_phy.empty?
  end

  def address_line_1
    suite_string = "Suite" if suite_number.present?
    ["#{street_address}", "#{suite_string} #{suite_number}"].reject{|x| x.blank?}.join(", ")
  end

  def address_line_2
    ["#{city}", "#{state} #{zip_code}"].reject{|x| x.blank?}.join(", ")
  end

  def phone_number_formatted
    ("Phone: " + phone_number) if phone_number.present?
  end

  def fax_number_formatted
    ("Fax: " + fax_number) if fax_number.present?
  end

  private

  def set_defaults
    if new_record?
      set_default_password
    else
      if self.default_email?
        self.email = nil
      end
    end
  end

  def set_default_password
    self.password = self.password_confirmation = "test1234"
  end

  def set_default_email
    random_string = Array.new(6){rand(36).to_s(36)}.join
    self.email = "#{first_name}#{last_name}#{random_string}default@fasternotes.com" if self.email.nil?
  end

  def physician_full_name
    "#{first_name} #{last_name}"
  end

  def save_details
    self.physician_detail.save if physician_detail.changed?
  end

  def assign_org
    self.orgs << Org.current
    self.orgs << FacilityOwner.first if Org.current.is_a? HealthAgency
  end

  def save_contacts_if_required
    if Org.current.is_a? HealthAgency
      if self.orgs.include?(Org.current)
        org_physician = self.org_physicians.find_by_org_id(Org.current.id)
        org_physician.personal_phone_number_1 = personal_phone_number_1 if org_physician
        org_physician.personal_phone_number_2 = personal_phone_number_2 if org_physician
        org_physician.save! if org_physician
      else
        self.org_physicians.create!(:org => Org.current, :personal_phone_number_1 => personal_phone_number_1,
                                    :personal_phone_number_2 => personal_phone_number_2)
      end
    end
  end
end
