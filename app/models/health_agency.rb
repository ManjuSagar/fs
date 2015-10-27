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

class HealthAgency < Org

  AGENCY_TYPES = [['H', 'Home Health'],['O', 'Hospice'],['P', 'Private Pay']]
  has_one :health_agency_detail, :dependent =>  :destroy
  has_many :staffing_company_contracts, :dependent =>  :destroy
  has_many :staffing_companies, :through => :staffing_company_contracts
  has_many :patient_details, :foreign_key => :org_id
  has_many :patients, through: :patient_details
  has_many :treatments, through: :patients
  has_many :treatment_visits, through: :treatments
  has_many :medical_orders, through: :treatments
  has_many :consulting_company_health_agencies, :foreign_key => :health_agency_id, :dependent => :destroy
  has_many :consulting_companies, :through => :consulting_company_health_agencies
  has_many :office_staffs, :through => :org_users, :source => :user, :conditions => ["user_type = 'OrgStaff'"]

  # OASIS Field Info Start
  def hha_agency_id
    self.health_agency_detail.provider_number
  end

  def cms_certification_number
    self.health_agency_detail.cms_cert_number
  end
  def acy_name
    self.org_name
  end

  def acy_addr_1
    self.street_address
  end

  def acy_addr_2
    self.suite_number
  end

  def acy_city
    self.city
  end

  def acy_st
    self.state
  end

  def acy_zip
    self.zip_code
  end

  def acy_cntct
    self.contacts.first.full_name unless self.contacts.empty?
  end

  def acy_phone
    self.phone_number.gsub("-", "").gsub("(", "").gsub(")", "").gsub(" ", "")
  end

  def file_dt
    Date.current
  end

  def natl_prov_id
    self.health_agency_detail.npi_number
  end

  def fs_and_sc_field_staffs
    field_staffs + staffing_companies.map(&:staffs).flatten
  end
  # OASIS Field Info End

  def fs_and_sc_list
    field_staffs + staffing_companies.collect{|sc| sc.staffs }.flatten
  end

  def staffs
    fs_and_sc_list + office_staffs
  end

  def field_staff_store(sc_staff_required = false)
    list = [[' ','---']]
    list += if sc_staff_required
              fs_and_sc_field_staffs.collect {|staff| ["#{staff.class.name}_#{staff.id}", staff.full_name]}.uniq
            else
              field_staffs.collect{|f| [f.id, f.full_name]}.uniq
            end

  end

  private
end
