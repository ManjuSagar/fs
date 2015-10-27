class StaffingCompanyContracts < Mahaswami::GridPanel
  def configuration
    s = super
    component_session[:staffing_company_id] = s[:staffing_company_id] if s[:staffing_company_id]
    s.merge(
      model: "StaffingCompanyContract",
      title: "Contracts",
      item_id: 'contracts',
      columns: [
        {name: :effective_from_date, label: "From Date", editable: false, width: "15%"},
        {name: :effective_to_date, label: "To Date", editable: false, width: "15%"}
      ],
      scope: {staffing_company_id: component_session[:staffing_company_id], health_agency_id: Org.current.id},
      strong_default_attrs: {staffing_company_id: component_session[:staffing_company_id], health_agency_id: Org.current.id}
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :contract_rates.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :contract_rates.action]
  end

  action :edit_in_form, text: "", tooltip: "Edit Contract"
  action :add_in_form, text: "", tooltip: "Add Contract"
  action :contract_rates, text: "Contract Rates", icon: false, disabled: true
  add_form_config        class_name: "StaffingCompanyContactForm", mode: :add
  edit_form_config        class_name: "StaffingCompanyContactForm", mode: :edit
  edit_form_window_config width: "50%", height: "40%", title: "Edit Contract"
  add_form_window_config width: "50%", height: "40%", title: "Add Contract"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectRecord({sc_contract_id: record.get('id')});
      }, this);
     this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.contractRates.setDisabled(selModel.getCount() != 1);
      }, this);
    }
  JS

  js_method :on_contract_rates, <<-JS
    function(windowTitle){
      var w = new Ext.window.Window({
          title: "Contract Rates",
          modal: true,
          layout: 'fit',
          width: "50%",
          height: "65%",
        });
        w.show();
        this.loadNetzkeComponent({name: "contract_rates", container:w, callback: function(w){
          w.show();
          }
        });

        w.on('close', function(){
          this.store.load();
        }, this);
    }
  JS

  component :contract_rates do
    {
        name: :rates,
        class_name: "Netzke::Basepack::TabPanel",
        header: false,
        plain: true,
        items: [
            :visit_type_rates.component(
                class_name: "HaScContractVisitTypes",
                parent_id: component_session[:sc_contract_id]
            ),
            :document_definition_rates.component(
                class_name: "HaScContractDocDefns",
                parent_id: component_session[:sc_contract_id]
            )
        ]
    }
  end

  endpoint :select_record do |params|
    component_session[:sc_contract_id] = params[:sc_contract_id]
  end

end