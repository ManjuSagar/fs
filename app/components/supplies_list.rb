class SuppliesList < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge({
      model: "Supply",
      title: "Supplies",
      editOnDblClick: false,
      infinite_scroll: false,
      enable_pagination: false,
      strong_default_attrs: {org_id: Org.current.id},
      columns: [
          {name: :supply_hcpcs_code, header: "HCPCS Code", editable: false, addHeaderFilter: true},
          {name: :supply_description, header: "Description", width: "30%", addHeaderFilter: true},
          {name: :supply_quantity, header: "Quantity", align: :right},
          {name: :supply_price, header: "Price", renderer: :supply_price_renderer, align: :right}
      ],
      add_form_config: {items:[
          {name: :supply_hcpcs_code, field_label: "HCPCS Code"},
          {name: :supply_description, field_label: "Description", xtype: :textarea},
          {name: :supply_quantity, field_label: "Quantity", xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false,
           mouseWheelEnabled: false},
          {name: :supply_price, field_label: "Price", xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false,
           mouseWheelEnabled: false}
      ]},
      scope: :org_scope
    })
  end

  def default_bbar
    [:edit.action, :apply.action, :add_in_form.action]
  end

  def default_context_menu
    [:edit.action, :apply.action, :add_in_form.action]
  end

  js_method :supply_price_renderer,<<-JS
    function(value){
      return value.toFixed(2);
    }
  JS

end