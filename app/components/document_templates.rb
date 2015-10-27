class DocumentTemplates < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'DocumentFormTemplate',
        title:  'Document Templates',
        columns: [
            {name: :template_name, header: "Name", editable: false},
            {name: :template_description, header: "Description", editable: false},
            {name: :document_class_name, header: "Document Form Class Name", editable: false, width: "14%"},
            {name: :report_file_name, header: "Report Definition File Name", editable: false, width: "13%"},
            {name: :oasis, header: "OASIS", editable: false, width: "13%"},
            {name: :document_type, header: "Oasis Document Type", editable: false, width: "13%"}

        ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Document Template"
  action :edit_in_form, text: "Edit Document Template"

end