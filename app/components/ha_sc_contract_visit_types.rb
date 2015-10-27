class HaScContractVisitTypes < Mahaswami::HasManyCollectionList
  association "visit_type_rates"
  parent_model "StaffingCompanyContract"

  def configuration
    c = super
    c.merge(
      title: "Visit Type Rates",
      editOnDblClick: false,
      infinite_scroll: false,
      enable_pagination: false,
      rows_per_page: 500,
      columns: [
          {name: :visit_type__visit_type_display, header: "Visit Type", editable: false, scope: :org_scope},
          {name: :visit_rate, header: "Visit Rate"},
          {name: :hourly_rate, header: "Hourly Rate"}
      ],
      height: 250,
      bbar: [:add_in_form.action, :edit.action, :apply.action, :del.action],
      context_menu: [:edit.action, :apply.action, :del.action],
      add_form_config: {
            class_name: "Mahaswami::FormPanel",
            items:[
            {name: :visit_type__visit_type_display, field_label: "Visit Type", scope: :org_scope},
            {name: :visit_rate, field_label: "Visit Rate", xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false, mouseWheelEnabled: false},
            {name: :hourly_rate, field_label: "Hourly Rate", xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false, mouseWheelEnabled: false}
        ]}
    )
  end

  add_form_window_config title: "Add Visit Rate"

end
