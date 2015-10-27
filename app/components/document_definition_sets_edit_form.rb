class DocumentDefinitionSetsEditForm < Mahaswami::FormPanel
  def configuration
    c = super
    c.merge(
        model: 'DocumentDefinitionSet',
            items: [{name: :set_name, field_label: "Name"},
              {name: :set_description, field_label: "Description"},
              {name: :remarks, field_label: "Remarks"},
              :set_details.component
            ]
    )

  end

  component :set_details do {
    class_name: "Mahaswami::HasAndBelongsToManyInput",
    association: "document_definitions",
    record: record,
    columns: 2,
    scope: :org_scope
  }
  end


end