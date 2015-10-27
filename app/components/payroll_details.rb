class PayrollDetails < Mahaswami::GridPanel
  
  def configuration
    c = super
      c.merge(
      auto_scroll: true,
      model: 'Payable',
      title: 'Payroll Details',
      item_id: :payroll_details_grid,
      editOnDblClick: false,
      columns: [
                {name: :treatment__to_s, editable: false, label: "Patient", addHeaderFilter: true},
                {name: :visit_date, editable: false, label: "Date", width: 100},
                {name: :purpose, label: "Visit", width: 130, editable: false},
                {name: :payable_amount_in_currency, align: "right", label: "Amount", width: 100},
                action_column("payroll_details_grid", 100)
                ],
                scope: (c[:scope].nil? ? :org_scope : c[:scope])
    )
  end

  def default_bbar 
    []
  end

  def default_context_menu
    []
  end

  def human_action_name(event)
    if event.name == :revert_status_to_unpaid
      "Undo"
    else
      event.title
    end
  end

  js_method :refresh_data, <<-JS
      function() {
        Ext.ComponentQuery.query("#unpaid_payable_lst")[0].store.load();
        Ext.ComponentQuery.query("#payroll_grid")[0].store.load();
        this.getStore().load();
      }
  JS

end

