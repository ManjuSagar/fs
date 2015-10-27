# == Schema Information
#
# Table name: treatment_attachments
#
#  id                      :integer          not null, primary key
#  treatment_id            :integer          not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  attachment_name         :string(100)
#  created_at              :datetime
#  attachment_type_id      :integer          not null
#

require 'attachment'
class TreatmentAttachment < ActiveRecord::Base
  include Attachment
  has_attached_file :attachment
  belongs_to :attachment_type
  belongs_to :treatment, :class_name => "PatientTreatment", :foreign_key => :treatment_id
  belongs_to :treatment_episode
  has_many :all_documents, :as => :documentable, :dependent => :destroy
  before_post_process :set_content_dispositon

  after_initialize :set_defaults, :if => :new_record?
  before_create :create_all_document
  after_save :update_all_documents_if_required, :unless => :new_record?

  validates_attachment :attachment, presence: true
  validates :attachment_type, presence: true
  validates :attachment_date, presence: true

  audited :associated_with => :treatment, :allow_mass_assignment => true
  scope :org_scope, lambda{includes(:treatment).where(:patient => {:org_id => Org.current.id})} if Org.current

  private

  def create_all_document
    description = attachment_type.attachment_description
    document = self.all_documents.build(treatment_episode: treatment_episode, category: "Attachment", description: description)
    document.document_date = attachment_date
  end

  def update_all_documents_if_required
    return unless attachment_type
    description = attachment_type.attachment_description
    self.all_documents.each{|d|
      d.update_attributes(description: description) if (description != d.description)
      d.update_column(:document_date, attachment_date)
    }
  end

end
