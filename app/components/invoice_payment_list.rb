class InvoicePaymentList < Mahaswami::GridPanel

  def configuration
    c = super
    c.merge(
      model: "InvoicePayment",
      title: "Payments",
      editOnDblClick: false,
      item_id: "invoice_payment_list_grid",
      columns: [
        {name: :payment_reference_number, label: "Ref. #", editable: false, width: '10%'},
        {name: :invoice__invoice_number, label: "Invoice #", editable: false, width: "10%"},
        {name: :payment_date, label: "Date", editable: false},
        {name: :payment_amount, label: "Amount", editable: false, align: "right", renderer: :render_invoice_payment_amount},
        {name: :payment_status, label: "Status", editable: false, getter: lambda{|r| r.payment_status.to_s.titleize }},
        action_column("invoice_payment_list_grid")
      ],
      scope: (c[:scope].nil?? :org_scope : c[:scope])
    )
  end

  def default_bbar
    [:del.action]
  end

  def default_context_menu
    []
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.on('itemclick',function(view, record){
        this.checkStatusToDelete({payment_id : record.get('id')}, function(result){
          this.actions.del.setDisabled(!result);
        }, this);
      }, this);
    }
  JS

  endpoint :check_status_to_delete do |params|
    payment = InvoicePayment.find(params[:payment_id])
    result = payment.draft?
    {:set_result => result}
  end

  js_method :render_invoice_payment_amount,<<-JS
    function(value){
      return Ext.util.Format.usMoney(value);
    }
  JS

  endpoint :delete_data do |params|
    if !config[:prohibit_delete]
      record_ids = ActiveSupport::JSON.decode(params[:records])
      data_adapter.destroy(record_ids)
      on_data_changed
      {:netzke_feedback => I18n.t('netzke.basepack.grid_panel.deleted_n_records', :n => record_ids.size), :load_store_data => get_data, :refresh_grids => 1}
    else
      {:netzke_feedback => I18n.t('netzke.basepack.grid_panel.cannot_delete')}
    end
  end

  js_method :refresh_grids,<<-JS
    function(params){
      var invoicesGrid = this.up('#invoices_grid');
      if(invoicesGrid){
        invoicesGrid.down("#invoice_list_grid").store.load();
        invoicesGrid.down("#invoice_details_grid").store.load();
      }
    }
  JS
end