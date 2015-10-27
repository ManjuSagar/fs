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

require 'geometry'

class FieldStaff < User
  has_one :field_staff_detail, :dependent => :destroy
  has_many :credentials, :class_name => "FieldStaffCredential", :dependent => :destroy
  belongs_to :license_type
  has_many :staffing_requests, :as => :staff, :dependent => :destroy
  has_many :treatment_visits, :foreign_key => :visited_user_id, :dependent => :destroy

  before_save :save_signatures, :reset_review_agency_changes_flag
  after_validation :check_signature_and_sign_password_present, :unless => :new_record?
  after_create :associate_to_org, :auto_assign_clinical_staff_to_patient
  after_update :save_field_staff_detail
  after_validation :check_errors
  attr_accessor :field_staff_signature_data
  before_save :field_staff_profile_changes
  netzke_attribute :field_staff_signature_data

  scope :user_scope, lambda{ where(:id => User.current.id) if User.current}

  scope :org_scope, lambda{|org = Org.current| joins(:org_users).where(:org_users => {:org_id => org.id})}

  scope :active_field_staffs, lambda{joins(:org_users).where("org_id = ? and org_users.user_status = ?", Org.current.id, "A")}

  scope :field_staffs_by_discipline, lambda{|discipline_id| org_scope.active_field_staffs.where(["users.id in (select fsd.field_staff_id from field_staff_details fsd where license_type_id in
              (select lt.id from license_types lt where lt.discipline_id = ?))", discipline_id])}

  scope :field_staffs_with_only_visit_types, lambda{|visit_type_id| org_scope.active_field_staffs.where(["users.id in (select fsd.field_staff_id from field_staff_details fsd where license_type_id in
              (select lt.id from license_types lt inner join license_types_visit_types ltvt on ltvt.license_type_id = lt.id and ltvt.visit_type_id = ?))", visit_type_id])}

  scope :field_staffs_with_both_discipline_and_visit_type, lambda{|discipline_id, visit_type_id| org_scope.active_field_staffs.where(["users.id in
              (select fsd.field_staff_id from field_staff_details fsd where license_type_id in (select lt.id from license_types lt inner join license_types_visit_types ltvt
                on ltvt.license_type_id = lt.id and lt.discipline_id = ? and ltvt.visit_type_id = ?))", discipline_id, visit_type_id])}
  scope :clinical_staffs, lambda {active_field_staffs.where(["users.id in
              (select fsd.field_staff_id from field_staff_details fsd where clinical_staff = true)"])}

  def field_staff_detail_with_build
    field_staff_detail_without_build || build_field_staff_detail
  end
  alias_method_chain :field_staff_detail, :build

  delegate :review_agency_changes_flag, :review_agency_changes_flag=, :license_type, 
					:license_type=, :license_type_id, :license_type_id=, :license_number, :license_number=, :clinical_staff, :clinical_staff=, to: :field_staff_detail

  def independent?
    license_type.independent?
  end
  def send_activation_email?
    true
  end
  
  def review_agency_changes_flag?
    review_agency_changes_flag == true 
  end

  def license_type_code
    field_staff_detail and field_staff_detail.license_type and field_staff_detail.license_type.license_type_code
  end

  def license_type_description
    field_staff_detail and field_staff_detail.license_type and field_staff_detail.license_type.license_type_description
  end

  def full_name(include_suffix = true)
    if include_suffix
      "#{super}, #{license_type.license_type_code}"
    else
      super
    end
  end

  def independent_fs?
    license_type.independent_flag
  end

  def visit_types(org = Org.current)
    org_user = org_users.detect{|o| o.org == org}
    org_user ? org_user.visit_types : []
  end

  def self.qualified_field_staff_list_for_staffing(discipline = nil, visit_type = nil, patient_preference = false,  preferred_languages = nil, preferred_gender = nil, patient_address = nil)
    res = if discipline.present? and visit_type.present?
            field_staffs_with_both_discipline_and_visit_type(discipline.id, visit_type.id)
          elsif discipline.present? and visit_type.nil?
            field_staffs_by_discipline(discipline.id)
          elsif discipline.nil? and visit_type.present?
            field_staffs_with_only_visit_types(visit_type.id)
          else
            []
          end
    if patient_preference and not res.empty?
      res = res.where(["users.id in (select u.id from users u inner join user_languages ul on ul.user_id = u.id and ul.language_id in (?))", preferred_languages.map(&:id)]) unless preferred_languages.nil?
      res = res.where(["gender = ?", preferred_gender]) unless preferred_gender.nil?
      if patient_address and res.size > 0
        long, lat = res.first.geocode_party patient_address
        res = res.select{|s| (long.nil? or lat.nil? )? true : s.qualified_for_staffing?(long, lat) }
      end
    else
      res
    end
    res
  end

  def self.clinical_staff_ids
    ids = clinical_staffs.map(&:id)
    ids.blank? ? [-1] : ids
  end

  def qualified_for_staffing?(long = nil, lat = nil)
    debug_log "start-#{full_name}"
    return false if not (is_within_preferred_coverage_area?(long, lat))
    debug_log "Coverage Area OK"
    true
  end

  def check_errors
    unless field_staff_detail.valid?
      field_staff_detail.errors.each do |k, v|
        self.errors.add(k, v)
      end

    end

  end

  def save_signatures
    if field_staff_signature_data
      file = Tempfile.new(["signature", ".png"])
      file.binmode
      require 'base64'
      file.write(Base64.decode64(field_staff_signature_data))
      file.close
      file = File.open(file.path)
      self.signature = file
    end
   end
   
   def geocode_party(address_string)
      combined_address = address_string
      results = Geocoder.search(combined_address)
      return nil if results.nil? or results.empty?
      long = results[0].geometry["location"]["lng"]
      lat = results[0].geometry["location"]["lat"]
      [long,lat]
   end
   
  include Geometry
   
   def is_within_preferred_coverage_area?(long, lat)
    return true # Temporarily disable the coverage areas checking facility
    areas_covered = field_staff_detail.areas_covered || []
    debug_log "Areas Covered - #{areas_covered.size}"
    return true if areas_covered.empty? or long.nil? or lat.nil?
    result = areas_covered.find {|area|
      pol_points = area.collect{|p| Point(p[0], p[1])  }
      rectangle = Polygon.new pol_points
      inner = Point(long, lat)
      rectangle.contains?(inner)
    }
    debug_log "Result for Patient Coverage Check = #{result.nil? == false}"
    result.nil? ? false : true
   end

  def send_login_information
    spawn_block do
      FasternotesMailer.fasternotes_user_access_information(self).deliver
    end
  end

  def convert_fs_to_clinical_staff
    # Field Staff associated to one agency we are converting to Clinical Staff
    facility_owner = orgs.where(org_type: "FacilityOwner").first
    if orgs.size <= 2 and facility_owner.present?
      field_staff_detail.update_column(:clinical_staff, true)
      associate_user = OrgUser.where(org_id: facility_owner, user_id: self)
      associate_user.first.destroy
      auto_assign_clinical_staff_to_patient
    else
      false
    end
  end

  def convert_cs_to_field_staff
    if self.clinical_staff.present?
      field_staff_detail.update_column(:clinical_staff, false)
      associate_to_facility_owner
      undo_associate_with_patient
    else
      false
    end
  end

  def visit_type_rate(params)
    params[:visit_type].field_staff_visit_type_rate(params.merge({staff: self}))
  end

  def payable_rate(params)
    params[:visit_type].field_staff_amount_for_visit(params.merge({staff: self}))
  end

  def field_staff_profile_changes
    return unless User.current.present? and User.current.office_staff?
    return if (User.current == self)
    data = {field_staff: self}
    fs_changes = self.changes.select{|x| ["first_name", "last_name", "suite_number", "street_address", "city", "state", "zip_code",
                                          "email", "phone_number", "gender", "middle_initials", "phone_number_2", "fax_number", "suffix"].include? x}
    field_staff_detail_changes = self.field_staff_detail.changes.select{|x| ["license_number"].include? x}
    edited_information = fs_changes.merge(field_staff_detail_changes)
    return if edited_information.blank?
    first_name = edited_information["first_name"]
    last_name = edited_information["last_name"]
    middle_initials = edited_information["middle_initials"]
    name = get_formatted_name(first_name, last_name, middle_initials) if (first_name.present? or last_name.present? or middle_initials.present?)
    data[:edited_information] = edited_information.reject{|x| ["first_name", "last_name", "middle_initials"].include? x}
    data[:name] = name
    data[:os] = User.current
    data[:org] = User.current.orgs.first
    send_profile_change_email_notification(data)
  end

  def get_formatted_name(fname, lname, mi)
    if fname.present? and lname.present? and mi.present?
      "#{fname.last} #{mi.last} #{lname.last}"
    elsif fname.present? and lname.present?
      "#{fname.last} #{middle_initials} #{lname.last}"
    elsif fname.present?
      middle_initials.present? ?  "#{fname.last} #{middle_initials} #{last_name}" :  "#{fname.last} #{last_name}"
    elsif lname.present?
      middle_initials.present? ?  "#{first_name} #{middle_initials} #{lname.last}" : "#{first_name} #{lname.last}"
    elsif mi.present?
      "#{first_name} #{mi.last} #{last_name}"
    end
  end

  def send_profile_change_email_notification(data)
    spawn_block do
      FasternotesMailer.field_staff_profile_changes(data).deliver
    end
  end

  private
  
  def reset_review_agency_changes_flag
    self.review_agency_changes_flag = false if review_agency_changes_flag.nil?
    nil
  end
  
  def associate_to_org
    associate_to_facility_owner if self.clinical_staff.blank?
    associate_to_ha if (Org.current.org_type == "HealthAgency" and not user_type == "LiteFieldStaff")
  end

  def auto_assign_clinical_staff_to_patient
    if self.clinical_staff.present?
      treatments = PatientTreatment.org_scope
      #TODO method staffing move to treatment
      treatments.each do |treatment|
        staffing_master = treatment.staffing_masters.create!
        discipline = license_type.discipline
        staffing_requirement = staffing_master.staffing_requirements.create!(:discipline => discipline,
                                                                             :visit_type => nil, staffing_status: "A")
        treatment_staff = treatment.treatment_staffs.build(:discipline => discipline, staff: self, staffing_requirement: staffing_requirement, system_assigned: true)
        treatment_staff.save!
      end
    end
  end

  def undo_associate_with_patient
    if self.clinical_staff.blank?
      treatments = PatientTreatment.org_scope
      treatments.each do |treatment|
        discipline = license_type.discipline
        treatment_staff = treatment.treatment_staffs.where(:discipline_id => discipline, staff_id: self)
        treatment_staff.destroy_all
      end
    end
  end

  def associate_to_ha
    ha = Org.current
    ha.org_users.build(:user => self)
    ha.save!
  end

  def associate_to_facility_owner
    fo = FacilityOwner.first
    fo.org_users.build(:user => self)
    self.send_login_information if (user_type != "LiteFieldStaff" and send_activation_email?)
    fo.save!
  end

  def save_field_staff_detail
    field_staff_detail.save! if field_staff_detail.changed?
  end

  def check_signature_and_sign_password_present
    if User.current == self
      errors.add(:base, "Signature is required") if self.field_staff_signature_data.nil? and (not self.signature?)
      errors.add(:base, "Sig Password is required") if self.sign_password.nil? and self.encrypted_sign_password.nil?
    end
  end

  def self.field_staff_list(missing_frequency)
    discipline_ids =  if missing_frequency
                        Discipline.all.map(&:id)
                      else
                        [27, 28, 29]
                      end
    org_scope.where(["users.id in (select fsd.field_staff_id from field_staff_details fsd where license_type_id in
              (select lt.id from license_types lt where lt.discipline_id IN (?)))", discipline_ids]).collect{|fs| [fs.id, fs.full_name]}
  end

end
