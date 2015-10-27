class HaScContractDocDefns < Mahaswami::HasManyCollectionList
  association "document_definition_rates"
  parent_model "StaffingCompanyContract"

  def configuration
    c = super
    c.merge(
      title: "Document Rates",
      editOnDblClick: false,
      infinite_scroll: false,
      enable_pagination: false,
      rows_per_page: 500,
      columns: [
          {name: :document_definition__to_s, header: "Name", editable: false, scope: :org_scope},
          {name: :chargeable_rate, header: "Rate"}
      ],
      height: 250,
      bbar: [:add_in_form.action, :edit.action, :apply.action, :del.action],
      context_menu: [:edit.action, :apply.action, :del.action],
      add_form_config: {
          class_name: "Mahaswami::FormPanel",
          items:[
              {name: :document_definition__to_s, field_label: "Name", scope: :org_scope},
              {name: :chargeable_rate, field_label: "Chargeable Rate", xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false, mouseWheelEnabled: false},
          ]}
    )
  end

  add_form_window_config title: "Add Document Rate"

end
