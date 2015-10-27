# == Schema Information
#
# Table name: free_form_templates
#
#  id                         :integer          not null, primary key
#  template_short_description :string(100)      not null
#  template_narrative         :text
#  template_category          :string(100)
#  org_id                     :integer          not null
#  lock_version               :integer          default(0)
#

class FreeFormTemplate < ActiveRecord::Base
  belongs_to :org

  #scope :org_scope, lambda { includes(:org).where({:orgs => {:id => Org.current.id}}) if Org.current}
  scope :org_scope, lambda{(User.current.is_a? FieldStaff) ? includes(:org => :org_users).where(:org_users => {:user_id => User.current.id, :user_status => 'A'}).
                    order("template_short_description") : where({:org_id => Org.current.id}).order("template_short_description") }

  before_create :set_org_scope

  audited :associated_with => :org, :allow_mass_assignment => true

  validates :template_short_description, :presence => true

  def set_org_scope
    self.org_id = Org.current.id
  end

  def agency_name
    self.org.to_s
  end

end
