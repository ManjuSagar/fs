class ConsultingCompany < Org

  has_many :consulting_company_health_agencies, :foreign_key => :consulting_company_id, :dependent => :destroy
  has_many :health_agencies, :through => :consulting_company_health_agencies

  after_create :save_contact_and_user

  audited :allow_mass_assignment => true

  private

  def save_contact_and_user
    return nil
  end

end