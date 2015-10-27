class OasisDocumentWorkflow < DocumentWorkflow

  aasm do
    state :draft, :initial => true, :after_enter => [:set_document_status, :delete_export_record_if_necessary]
    state :pending_qa, :after_enter => [:set_document_status, :change_visit_status, :delete_export_record_if_necessary]
    state :approved, :after_enter => [:set_document_status, :change_visit_status, :on_document_ready, :create_receivables, :mark_episode_ready_to_bill,
                                      :generate_hipps_code, :inform_episode_doc_completed, :create_oasis_export_if_required, :archive_notes]
    state :exported, :after_enter => :set_document_status

    event :export, :hidden => true, :before => :add_exported_document_event_to_notes do
      transitions :from => :approved, :to => :exported, :guard => lambda {|d| d.valid_document?  and d.current_user_is_office_staff? }
    end

    event :unlock do
      transitions :from => :exported, :to => :exported, :guard => lambda {|d| d.valid_document?  and d.current_user_is_office_staff? }
    end

  end

  def delete_export_record_if_necessary
    res = ready_for_export_present?
    return unless res
    rec = ready_for_export
    return if rec.record_type == OasisExport::INACTIVE
    rec.destroy
    nil
  end

end