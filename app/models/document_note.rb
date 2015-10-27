# == Schema Information
#
# Table name: document_notes
#
#  id              :integer          not null, primary key
#  document_id     :integer          not null
#  note_date       :datetime         not null
#  notes           :text
#  created_user_id :integer          not null
#

class DocumentNote < ActiveRecord::Base
  belongs_to :created_user, :class_name => "User"
  belongs_to :document
  belongs_to :treatment_episode
  has_many :all_documents, :as => :documentable, :dependent => :destroy

  audited :associated_with => :document, :allow_mass_assignment => true

  before_create :set_defaults
  before_save :inform_document, :if => :new_record?

  default_scope order('note_date ASC')
  scope :active_notes, -> {where(archived: false)}
  scope :archived_notes, -> {where(archived: true)}
  scope :event_changed_notes, -> {where(event_changed: true)}

  def notes_text
    "#{notes} </br>"
  end

  def note_date_format_with_time
    note_date.strftime("%m/%d/%Y %I:%M %p")
  end

  def note_date_format_with_out_time
    note_date.strftime('%m/%d/%Y')
  end

  def org_staff_name
      "(#{created_user.full_name}, Office Staff #{note_date_format_with_time})"  if created_user.user_type == "OrgStaff"
  end

  def field_staff_name
    "(#{created_user.full_name} #{note_date_format_with_time})" if created_user.user_type == "FieldStaff"
  end

  private

  def inform_document
    document.comment_added if self.event_changed.blank?
  end

  def set_defaults
    self.created_user = User.current
    self.note_date = Time.current
    self.treatment_episode = document.treatment_episode
  end

end
