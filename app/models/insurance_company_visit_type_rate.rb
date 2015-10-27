# == Schema Information
#
# Table name: insurance_company_visit_type_rates
#
#  id                       :integer          not null, primary key
#  org_id                   :integer          not null
#  insurance_company_id     :integer          not null
#  visit_type_id            :integer          not null
#  rate                     :decimal(8, 2)
#  external_visit_type_code :string(20)
#  lock_version             :integer          default(0)
#

class InsuranceCompanyVisitTypeRate < ActiveRecord::Base

  belongs_to :org
  belongs_to :insurance_company
  belongs_to :visit_type
  
  validates :insurance_company_id, :presence => true
  validates :visit_type_id, :presence => true
  validates :visit_rate, :allow_nil => true, :numericality => {:only_decimal => true}
  validates :hourly_rate, :allow_nil => true, :numericality => {:only_decimal => true}
  validates :external_visit_type_code, :length => {:maximum => 20}

  audited :associated_with => :insurance_company, :allow_mass_assignment => true

  default_scope order('insurance_company_visit_type_rates.id ASC')
  scope :org_scope, lambda { includes(:org).where({:orgs => {:id => Org.current.id}}) if Org.current}
  
  before_create :assign_org

  def calculate_hourly_visit_amount(time_in_hour)
    rate = self.hourly_rate
    rate ? time_in_hour * rate : 0
  end
  
  private
  
  def assign_org
	self.org = Org.current
  end
  
end
