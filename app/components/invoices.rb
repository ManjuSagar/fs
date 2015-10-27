class Invoices < Mahaswami::Panel

  def configuration
    c = super
    c.merge(
        layout: {type: 'border'},
        header: false,
        item_id: :invoices_grid,
        items: [
            :invoice_list.component,
            :invoice_details.component
        ]
    )
  end

  component :invoice_list do
    {
        region: :west,
        width: "60%",
        class_name: "InvoiceList",
        item_id: :invoice_list_grid,
        auto_scroll: true,
        scope: config[:invoice_scope]
    }
  end

  component :invoice_details do
    {
        name: :details,
        class_name: "Netzke::Basepack::TabPanel",
        header: false,
        region: :center,
        items: [{
          class_name: "ReceivableList",
          item_id: :invoice_details_grid,
          title: "Details",
          auto_scroll: true,
          enable_pagination: false,
          strong_default_attrs: {invoice_id: component_session[:invoice_id]},
          invoice_id: component_session[:invoice_id],
          scope: (component_session[:invoice_id].nil? ? {:invoice_id => 0} : {:invoice_id => component_session[:invoice_id]})
        },{
          class_name: "InvoicePaymentList",
          item_id: :invoice_payment_list_grid,
          enable_pagination: false,
          auto_scroll: true,
          scope: (component_session[:invoice_id].nil? ? {:invoice_id => 0} : {:invoice_id => component_session[:invoice_id]})
        }]
    }
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.resetSessionContext({}, function(){
        this.down('#invoice_details_grid').store.load();
      });

      this.down('#invoice_list_grid').on('itemclick',function(view, record){
        this.setInvoiceId({invoice_id : record.get('id')}, function(result){
          var details = this.down('#invoice_details_grid');
          this.down('#invoice_details_grid').store.load();
          this.down('#invoice_payment_list_grid').store.load();
          details.actions.edit.setDisabled(!result);
          details.actions.apply.setDisabled(!result);
          details.actions.addInForm.setDisabled(!result);
          details.actions.del.setDisabled(!result);
        }, this);
      }, this);
    }    
  JS

  endpoint :reset_session_context do |params|
    invoice = Org.current.invoices.where(config[:invoice_scope]).first
    component_session[:invoice_id] = invoice ? invoice.id : nil
    {:set_result => true}
  end

  endpoint :set_invoice_id do |params|
    component_session[:invoice_id] = params[:invoice_id]
    invoice = Invoice.find(params[:invoice_id])
    result = invoice.draft?
    {:set_result => result}
  end
end
