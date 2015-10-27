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

class StaffingCompany < Org
  has_one :staffing_company_detail, :dependent => :destroy
  has_many :staffing_requests, :as => :staff, :dependent =>  :destroy
  has_many :agency_contracts, :class_name => "StaffingCompanyContract", :dependent =>  :destroy
  has_many :health_agencies, :through => :agency_contracts
   has_many :staffing_company_users, :class_name => "StaffingCompanyUser", :dependent => :destroy, foreign_key: :org_id
  has_many :staffs, :through => :org_users, :source => :user, :conditions => ["user_type = 'LiteFieldStaff'"]

  scope :org_scope, lambda{includes(:staffing_company_detail).where({:staffing_company_details => {:created_org_id => Org.current.id}, :draft_status => false}).order("orgs.org_name") if Org.current}

  scope :scs_for_only_discipline, lambda{|discipline_id| org_scope.where(["orgs.id in (select hsc.staffing_company_id from ha_sc_contracts hsc inner join orgs o
                                    on o.id = hsc.staffing_company_id inner join ha_sc_contract_details hscd on hscd.contract_id = hsc.id where
                                  hscd.discipline_id = ? and hscd.visit_type_id is null and hsc.health_agency_id = ?)", discipline_id, Org.current.id])}
  scope :scs_for_only_visit_type, lambda{|visit_type_id| org_scope.where(["orgs.id in (select hsc.staffing_company_id from ha_sc_contracts hsc inner join orgs o
                                    on o.id = hsc.staffing_company_id inner join ha_sc_contract_details hscd on hscd.contract_id = hsc.id where
                                  hscd.discipline_id is null and hscd.visit_type_id = ? and hsc.health_agency_id = ?)", visit_type_id, Org.current.id])}
  scope :scs_for_both_discipline_and_visit_type, lambda{|discipline_id, visit_type_id| org_scope.where(["orgs.id in (select hsc.staffing_company_id from ha_sc_contracts hsc inner join orgs o
                                    on o.id = hsc.staffing_company_id inner join ha_sc_contract_details hscd on hscd.contract_id = hsc.id where
                                  hscd.discipline_id = ? and hscd.visit_type_id = ? and hsc.health_agency_id = ?)", discipline_id, visit_type_id, Org.current.id])}

  before_create :init_detail, :set_defaults
  before_update :sample_org_to_real_if_required
  after_create :setup_default_agency_contract

  def full_name
    org_name
  end

  def self.qualified_sc_list_for_staffing(discipline = nil, visit_type = nil, patient_preference = false,  preferred_languages = nil, preferred_gender = nil, patient_address = nil)
    sc_list = if discipline.present? and visit_type.present?
                scs_for_both_discipline_and_visit_type(discipline.id, visit_type.id)
              elsif discipline.present? and visit_type.nil?
                scs_for_only_discipline(discipline.id)
              elsif discipline.nil? and visit_type.present?
                scs_for_only_visit_type(visit_type.id)
              else
                []
              end
    patient_preference ? sc_list.select{|s| s.qualified_for_staffing?(patient_address)} : sc_list
  end

  def qualified_for_staffing?(discipline = nil, visit_type = nil, preferred_languages = nil, preferred_gender = nil, patient_address = nil)
    agency_contracts.detect{|o| o.health_agency == Org.current}.qualified_for_staffing?(patient_address)
  end

  def is_within_preferred_coverage_area?(patient_address)
    true
  end

  def contract_period_with_in_from_date_and_to_date(date)
    agency_contracts.detect{|c| c.applicable?(date)}
  end

  def visit_type_rate(params)
    contract_period_with_in_from_date_and_to_date(params[:visit_date]).sc_fs_visit_type_rate(params.merge({staff: self}))
  end

  def payable_rate(params)
    contract_period_with_in_from_date_and_to_date(params[:visit_date]).staffing_company_rate_for_visit(params)
  end

  private

  def init_detail
    self.build_staffing_company_detail(:created_org => Org.current)
  end

  before_validation :set_defaults, :set_random_password, :on => :create

  def set_random_password
    self.primary_contact_password = self.primary_contact_password_confirmation = "test1234"
  end

  def set_defaults
    self.week_start_day = "MON"
    self.org_package = "F"
    self.preferred_alert_mode = "E"
  end

  def setup_default_agency_contract
    return unless Org.current.is_a?(HealthAgency)
    self.agency_contracts.create!(:health_agency => Org.current, :contract_date => Date.current, :effective_from_date => Date.current)
  end

  def sample_org_to_real_if_required
    self.draft_status = false
    nil
  end

end
