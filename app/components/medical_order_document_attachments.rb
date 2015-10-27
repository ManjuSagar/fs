class MedicalOrderDocumentAttachments < Mahaswami::HasManyCollectionList
  def initialize(conf={}, parent_id = nil)
    super
    components[:add_form][:items].first.merge!(:medical_order_id => component_session[:parent_id])
  end

  def configuration
   c = super
   c.merge(
       columns: [
           {name: :document__document_definition__document_name, getter: lambda{|r| "#{r.document.document_definition.document_name} (#{r.document.document_date})"}, header: "Document Name", width: "25%" },
       ],
   )
 end

  def default_bbar
    [:add_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :del.action]
  end

  add_form_config class_name: "MedicalOrderDocumentAttachmentForm"
  action :add_in_form, text: "", tooltip: "Add Document Attachment"
  add_form_window_config title: "Add Attach Document"
  edit_form_window_config title: "Edit Attach Document"
end
