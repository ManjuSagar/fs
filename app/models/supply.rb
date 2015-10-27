class Supply < ActiveRecord::Base
  belongs_to :org

  scope :org_scope, lambda{where({:org_id => Org.current.id}).order("supply_description ASC")}

  validates_presence_of :supply_hcpcs_code
  validates_presence_of :supply_description

  audited :associated_with => :org, :allow_mass_assignment => true

  def to_s
    supply_description
  end

end