class RegularDocWorkFlow < DocumentWorkflow
  aasm do
    state :draft, :initial => true, :after_enter => :set_document_status
    state :pending_qa, :after_enter => [:set_document_status, :change_visit_status]
    state :approved, :after_enter => [:set_document_status, :change_visit_status, :on_document_ready, :create_receivables, :archive_notes]

    event :approve, :before => [:set_agency_approved_user, :add_approved_document_event_to_notes] do
      transitions :from => :pending_qa, :to => :approved, :guard => lambda {|d| d.valid_document? and d.current_user_is_office_staff? }
    end

  end

  def exported?
    false
  end
end