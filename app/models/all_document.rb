class AllDocument < ActiveRecord::Base
  attr_accessible :documentable_type, :documentable_id, :treatment_episode, :treatment_episode_id, :category, :staff,
                  :description, :status
  belongs_to :documentable, :polymorphic => true, :dependent => :destroy
  belongs_to :treatment_episode

  attr_accessor :attachment, :document_valid
  netzke_attribute :document_valid, type: :boolean
  default_scope lambda{ order("all_documents.document_date DESC") }

  audited :associated_with => :treatment_episode, :allow_mass_assignment => true

  STATUS_REQUIRED = ["MedicalOrder", "Document", "CommunicationNote"]

  def document_valid
    if self.documentable_type == "Document"
      self.documentable.valid_document?
    else
      true
    end
  end

  def document_date_display
   document_date.to_date.strftime("%-m/%-e/%y") if document_date
  end

  def events_for_current_state
    STATUS_REQUIRED.include?(documentable_type) ? documentable.events_for_current_state : []
  end

end