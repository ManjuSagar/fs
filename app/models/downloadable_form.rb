# == Schema Information
#
# Table name: form_library
#
#  id                        :integer          not null, primary key
#  form_name                 :string(50)       not null
#  form_description          :string(255)      not null
#  form_content_file_name    :string(255)
#  form_content_content_type :string(255)
#  form_content_file_size    :integer
#  form_content_updated_at   :datetime
#  scope                     :string(2)
#  org_id                    :integer          not null
#

class DownloadableForm < ActiveRecord::Base
  set_table_name "form_library"
  belongs_to :org
  has_attached_file :form_content

  validates_attachment :form_content, presence: true
  validates :form_name, presence: true
  validates :form_description, presence: true

  before_create :set_defaults
  before_create :set_org

  audited :associated_with => :org, :allow_mass_assignment => true

  scope :org_scope, lambda{(User.current.is_a? FieldStaff) ? includes(:org => :org_users).where(:org_users => {:user_id => User.current.id, :user_status => "A"}).
      order("form_name, form_description") : where({:org_id => Org.current.id}).order("form_name, form_description") }

  def set_defaults
    self.form_content_updated_at = Date.current
  end

  def set_org
    self.org = Org.current unless org_id
  end

  def agency_name
    self.org.to_s
  end


end
