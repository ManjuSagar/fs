# == Schema Information
#
# Table name: visit_attachments
#
#  id                      :integer          not null, primary key
#  visit_id                :integer          not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  attachment_name         :string(100)
#  created_at              :datetime
#  attachment_type_id      :integer          not null
#  document_definition_id  :integer
#

require 'attachment'
class VisitAttachment < ActiveRecord::Base
  include Attachment
  has_attached_file :attachment
  belongs_to :attachment_type
  belongs_to :treatment_visit, :foreign_key => :visit_id
  belongs_to :document_definition
  before_post_process :set_content_dispositon
  after_initialize :set_defaults, :if => :new_record?
  after_create :sign_visit_if_required

  audited :associated_with => :treatment_visit, :allow_mass_assignment => true

  validates :attachment_type, presence: true
  validates_attachment :attachment, presence: true
  validates :attachment_date, presence: true

  def to_s
    attachment_type.attachment_description
  end

  def sign_visit_if_required
    treatment_visit.sign_visit_if_required if attachment_type == AttachmentType.route_sheet
  end

  def set_defaults
    treatment_visit.visit_start_date.strftime("%Y/%m/%d") if treatment_visit
  end
end
