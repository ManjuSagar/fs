class DocRejectedWorkflow < OasisDocumentWorkflow

  aasm do

    event :sign, :before => :set_signed_user, :before => :add_sign_document_event_to_notes do
      transitions :from => :draft, :to => :draft, :on_transition => Proc.new {|d, *args| d.set_as_fs_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_field_staff? and d.field_staff_signature_required? and d.supervisor_signature_required? and d.field_signature_required? }
      transitions :from => :draft, :to => :pending_qa, :on_transition => Proc.new {|d, *args| d.set_as_fs_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_field_staff? and d.only_field_staff_signature_required? and d.field_signature_required? }
      transitions :from => :draft, :to => :pending_qa, :on_transition => Proc.new {|d, *args| d.set_as_supervisor_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_supervised_user? and d.supervisor_signature_required? and (not d.field_staff_signature_required?) and d.field_signature_required? }
    end

    event :approve, :before => [:set_agency_approved_user, :add_approved_document_event_to_notes] do
      transitions :from => :pending_qa, :to => :approved, :guard => lambda {|d| d.valid_document? and d.current_user_is_office_staff? }
    end

    event :edit_document, :before => :add_edit_document_event_to_notes do
      transitions :from => :pending_qa, :to => :draft, :on_transition => Proc.new {|obj, *args| obj.set_as_fs_not_signed}, :guard => lambda {|d| d.current_user_is_office_staff? and d.system_driven_event? }
      transitions :from => :approved, :to => :draft, :on_transition => Proc.new {|obj, *args| obj.set_as_fs_not_signed}, :guard => lambda {|d| d.current_user_is_office_staff? and d.system_driven_event? }
    end

    event :request_correction, :before => :add_corrrection_request_document_event_to_notes do
      transitions :from => [:pending_qa, :approved], :to => :draft, :on_transition => Proc.new {|d, *args| d.set_as_fs_not_signed }, :guard => lambda {|d| d.valid_document?  and d.current_user_is_office_staff? and d.field_signature_required? and d.system_driven_event? }
      transitions :from => :draft, :to => :draft, :on_transition => Proc.new {|d, *args| d.set_as_fs_not_signed }, :guard => lambda {|d| d.current_user_is_supervised_user? and d.system_driven_event? and d.only_supervisor_signature_required? and d.field_signature_required? }
    end

    event :export, :before => :add_exported_document_event_to_notes do
      transitions :from => :approved, :to => :exported, :guard => lambda {|d| d.valid_document?  and d.current_user_is_office_staff? and d.system_driven_event? }
    end

  end
end