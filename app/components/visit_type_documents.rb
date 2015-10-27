class VisitTypeDocuments < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'VisitTypeDocumentDefinition',
        title: 'Visit Type Document Definitions',
        columns: [{name: :visit_type__visit_type_description, label: "Visit Type", editable: false},
                  {name: :document_definition__document_name, label: "Document Definition", editable: false, width: "30%"},
                  {name: :mandatory_flag, label: "Mandatory?", editable: false, width: "10%"}],
        scope: :org_scope
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Visit Type Document"
  action :edit_in_form, text: "Edit Visit Type Document"
end