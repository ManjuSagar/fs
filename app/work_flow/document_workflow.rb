class DocumentWorkflow
  include AASM
  aasm do

    event :sign, :before => :set_signed_user, :before => [:add_sign_document_event_to_notes, :set_comment_for_fs_signed] do
      transitions :from => :draft, :to => :draft, :on_transition => Proc.new {|d, *args| d.set_as_fs_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_field_staff? and d.field_staff_signature_required? and d.supervisor_signature_required? and d.field_signature_required? }
      transitions :from => :draft, :to => :pending_qa, :on_transition => Proc.new {|d, *args| d.set_as_fs_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_field_staff? and d.only_field_staff_signature_required? and d.field_signature_required? }
      transitions :from => :draft, :to => :pending_qa, :on_transition => Proc.new {|d, *args| d.set_as_supervisor_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_supervised_user? and d.field_staff_and_supervisor_signature_required? and d.field_signature_required? }
      transitions :from => :draft, :to => :pending_qa, :on_transition => Proc.new {|d, *args| d.set_as_supervisor_signed }, :guard => lambda {|d| d.valid_document? and d.current_user_is_supervised_user? and d.supervisor_signature_required? and (not d.field_staff_signature_required?) and d.field_signature_required? }
    end

    event :submit_to_qa, :hidden => true do
      transitions :from => :draft, :to => :pending_qa, :guard => lambda {|d| d.valid_document? and d.current_user_is_office_staff? and d.field_signature_not_required? }
    end

    event :save_as_draft, :hidden => true do
      transitions :from => :pending_qa, :to => :draft, :guard => lambda {|d| d.current_user_is_office_staff? and d.field_signature_not_required? }
    end

    event :delete_document, :hidden => true do
      transitions :from => :draft, :to => :draft
    end

    event :edit_document_by_default, :hidden => true do
      transitions :from => :draft, :to => :draft
    end

    event :edit_document, :hidden => true, :before => :add_edit_document_event_to_notes do
      transitions :from => :pending_qa, :to => :draft, :on_transition => Proc.new {|obj, *args| obj.set_as_fs_not_signed}, :guard => lambda {|d| d.current_user_is_office_staff? }
      transitions :from => :approved, :to => :draft, :on_transition => Proc.new {|obj, *args| obj.set_as_fs_not_signed}, :guard => lambda {|d| d.current_user_is_office_staff? }
    end

    event :request_correction, :hidden => true, :before => :add_corrrection_request_document_event_to_notes do
      transitions :from => [:pending_qa, :approved], :to => :draft, :on_transition => Proc.new {|d, *args| d.set_as_fs_not_signed }, :guard => lambda {|d| d.valid_document?  and d.current_user_is_office_staff? and d.field_signature_required? }
      transitions :from => :draft, :to => :draft, :on_transition => Proc.new {|d, *args| d.set_as_fs_not_signed }, :guard => lambda {|d| d.current_user_is_supervised_user? and d.only_supervisor_signature_required? and d.field_signature_required? }
    end

  end

  attr_accessor :state, :doc
  def initialize doc
    @doc = doc
    @state = @doc.status
  end

  def set_document_status
    self.status = aasm_current_state
    doc.status = aasm_current_state
    doc.save!
  end

  def aasm_read_state
    if doc.new_record?
      status.blank? ? aasm_determine_state_name(self.class.aasm_initial_state) : status.to_sym
    else
      status.nil? ? nil : status.to_sym
    end
  end

  def method_missing sym, *args
    if doc.respond_to? sym
      doc.send sym, *args
    else
      super
    end
  end
end