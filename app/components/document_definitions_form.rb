class DocumentDefinitionsForm < Mahaswami::FormPanel
  def configuration
    super.merge(
        model: 'DocumentDefinition',
        title:  'Document Definitions',
        items: [
            {name: :document_code, field_label: "Code", editable: false, width: "13%"},
            {name: :document_name, field_label: "Name", editable: false, width: "15%"},
            {name: :payable_rate,  field_label: "Payable Rate", editable: false, align: 'right'},
            {name: :document_form_template__template_description, field_label: "Form Template", editable: false}
        ],
        scope: :org_scope
    )
  end
end