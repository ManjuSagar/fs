class DocumentFormTemplateSetsEditForm < Mahaswami::FormPanel
  def configuration
      c = super
      c.merge(
          model: 'DocumentFormTemplateSet',
          items: [{name: :set_name, label: "Name", editable: false},
                            {name: :set_description, field_label: "Description"},
                            {name: :remarks,field_label: "Remarks"},
           :visit_docs.component

          ]
      )

  end

  component :visit_docs do {
      class_name: "Mahaswami::HasAndBelongsToManyInput",
      association: "document_form_templates",
      record: record,
      columns: 2
      }
  end


end