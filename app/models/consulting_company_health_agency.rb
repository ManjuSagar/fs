class ConsultingCompanyHealthAgency < ActiveRecord::Base

  belongs_to :consulting_company
  belongs_to :health_agency

  has_associated_audits
  audited :associated_with => :health_agency, :allow_mass_assignment => true

  validates :consulting_company, :presence => true
  validates :health_agency, :presence => true

  scope :active_health_agencies, lambda { where({active: true, consulting_company_id: Org.current}) }
  scope :pending_health_agencies, lambda { where({active: false, consulting_company_id: Org.current}) }

  def activate
    self.active = true
  end

end