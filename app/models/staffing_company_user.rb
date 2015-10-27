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

class StaffingCompanyUser  < ActiveRecord::Base
  set_table_name "org_users"

  belongs_to :org
  belongs_to :staffing_company, :class_name => "Org", :foreign_key => :org_id
  belongs_to :user
  belongs_to :field_staff, :foreign_key => :user_id
  audited :associated_with => :staffing_company, :allow_mass_assignment => true



  before_validation :set_random_password, :set_random_email, :on => :create
  after_validation :check_errors
  before_save :save_field_staff
  before_create :set_defaults

  netzke_attribute :first_name
  netzke_attribute :last_name
  netzke_attribute :email
  netzke_attribute :password
  netzke_attribute :password_confirmation
  netzke_attribute :license_number
  netzke_attribute :license_type_id
  netzke_attribute :user_type

  delegate :first_name, :first_name=, :last_name, :last_name=, :email, :email=, :password, :password=, :password_confirmation,
           :password_confirmation=, :user_type, :user_type=, :license_number, :license_number=, :license_type_id, :license_type_id=, :to => :field_staff


  def field_staff_with_build
    field_staff_without_build || build_field_staff
  end
  alias_method_chain :field_staff, :build


  def license_type_description
   field_staff.license_type_description
  end

  def set_random_password
    self.password = self.password_confirmation = Time.current.to_f
  end

  def set_random_email
    #self.email = "#{first_name}@#{license_number}.com"
    random_string = Array.new(6){rand(36).to_s(36)}.join
    self.email = "#{first_name}#{last_name}#{random_string}@fasternotes.com"
  end

  def save_field_staff
    field_staff.save!
  end

  def check_errors
    unless field_staff.valid?
      field_staff.errors.each do |k, v|
        self.errors.add(k, v)
      end
    end
  end

  def set_defaults
    self.user_status = 'A'
  end

end
