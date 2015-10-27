# == Schema Information
#
# Table name: vitals_reference_ranges
#
#  id                    :integer          not null, primary key
#  org_id                :integer          not null
#  vital_sign            :string(255)      not null
#  minimum_value         :float
#  maximum_value         :float
#  last_updated_datetime :datetime         not null
#

class VitalsReferenceRange < ActiveRecord::Base
  belongs_to :org

  before_create :set_defaults
  after_initialize :set_org
  audited :associated_with => :org, :allow_mass_assignment => true
  scope :org_scope, lambda { includes(:org).where({:orgs => {:id => Org.current.id}}) if Org.current}

  def vital_sign_display
    self.vital_sign.titleize
  end

  validates_presence_of :check_minimum_value, :message => ", it should be less than Maximum Value", :if => :vitals_present?

  def check_minimum_value
    self.minimum_value < self.maximum_value
  end

  def vitals_present?
    self.minimum_value.present? and self.maximum_value.present?
  end

  private

  def set_org
    self.org_id = Org.current.id if new_record?
  end

  def set_defaults
    self.last_updated_datetime = Time.current
  end




end
