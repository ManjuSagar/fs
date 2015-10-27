class FreeFormTemplateForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: "FreeFormTemplate",
        items: [
            {name: :template_short_description, field_label: "Description"},
            {name: :template_narrative, field_label: "Narrative", rows: 20}
        ],
        scope: :org_scope
    )
  end
end