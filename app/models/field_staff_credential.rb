# == Schema Information
#
# Table name: field_staff_credentials
#
#  id                      :integer          not null, primary key
#  field_staff_id          :integer          not null
#  credential_type_id      :integer          not null
#  expiry_date             :date
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  comments                :string(255)
#  credential_status       :string(1)        not null
#

class FieldStaffCredential < ActiveRecord::Base
  belongs_to :field_staff
  belongs_to :field_staff_credential_type, :foreign_key => :credential_type_id
  has_attached_file :attachment

  scope :field_staff_scope, lambda { includes(:field_staff).where ({:field_staff_id => User.current.id}) if User.current}

  before_post_process :set_content_dispositon
  before_create :set_defaults

  audited :associated_with => :field_staff, :allow_mass_assignment => true

  validates :expiry_date, :presence => true, :if => :check_expiry?
  validates_presence_of :field_staff_credential_type
  validates_attachment :attachment, presence: true
  before_create :create_field_staff_profile_changes
  before_update :update_field_staff_profile_changes
  before_destroy :destroy_field_staff_profile_changes

  def check_expiry?
    self.field_staff_credential_type.expiry_flag if self.field_staff_credential_type
  end

  def credential_type
    self.field_staff_credential_type.ct_description
  end

  def set_content_dispositon
    #self.options.merge({:s3_headers => {"Content-Disposition" => "attachment; filename="+self.sample_file_name}})
  end

  def set_defaults
    self.credential_status = "A"
    self.attachment_updated_at = Time.current
  end

  def field_staff_profile_changes(action)
    return unless User.current.present? and User.current.office_staff?
    return if (User.current == self)
    data = {field_staff: field_staff}
    data[:os] = User.current
    data[:org] = Org.current
    case action
      when "create"
        data[:added_credential] = self.field_staff_credential_type.ct_description
      when "update"
        credential_changes = self.changes.reject{|x| ["attachment_file_name", "attachment_content_type", "attachment_file_size",
                                                      "attachment_updated_at"].include? x}
        res = {"name" => ["", self.field_staff_credential_type.ct_description]}.merge(credential_changes)
        data[:updated_credential] = res
      when "destroy"
        data[:removed_credential] = self.field_staff_credential_type.ct_description
    end
    spawn_block do
      send_profile_change_email_notification(data)
    end
  end

  def send_profile_change_email_notification(data)
    FasternotesMailer.field_staff_profile_changes(data).deliver
  end

  def create_field_staff_profile_changes
    field_staff_profile_changes("create")
  end

  def update_field_staff_profile_changes
    field_staff_profile_changes("update")
  end

  def destroy_field_staff_profile_changes
    field_staff_profile_changes("destroy")
  end

end
