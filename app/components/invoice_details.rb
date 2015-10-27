class InvoiceDetails < Mahaswami::GridPanel

  def configuration
    c = super
    component_session[:invoice_id] = c[:invoice_id]
    c.merge(
        editOnDblClick: false,
        auto_scroll: true,
        model: 'Receivable',
        title: 'Invoice Details',
        item_id: :invoice_details_grid,
        columns: [{name: :receivable_date, editable: false, label: "Date", width: 70},
            {name: :purpose, width: 130, editable: false},
            {name: :receivable_amount, label: "Amount", align: "right", editable: false, renderer: :render_receivable_amount, width: 60},
            {name: :receivable_status, label: "Status", editable: false, getter: lambda{|r| r.receivable_status.to_s.titleize}, width: 60},
            {name: :hcpcs_code, label: "HCPCS", width: 50},
            {name: :revenue_code, label: "Rev Code", width: 60},
            {name: :service_units, label: "Service Units"},
            {name: :invoice_payment__payment_reference_number, label: "Payment Ref. #", editable: false, width: 110}
        ],
        scope: (c[:scope].nil? ? :org_scope : c[:scope])
    )
  end

  def default_bbar
    User.current.field_staff? ? [] : [:del.action]
  end

  def default_context_menu
    []
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.checkInvoiceStatusToDelete({}, function(result){
          this.actions.del.setDisabled(!result);
        }, this);
      }, this)
      this.store.on('load', function(){
        this.checkInvoiceStatusToDelete({}, function(result){
          this.actions.del.setDisabled(!result);
        }, this);
      }, this);
    }
  JS

  endpoint :check_invoice_status_to_delete do |params|
    invoice = Invoice.find(component_session[:invoice_id])
    {:set_result => invoice.draft? }
  end

  js_method :render_receivable_amount,<<-JS
    function(value){
      return value.toFixed(2);
    }
  JS

  js_method :on_del, <<-JS
   function() {
       Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
       if (btn == 'yes') {
        var records = [];
        this.getSelectionModel().selected.each(function(r){
          if (r.isNew) {
            // this record is not know to server - simply remove from store
            this.store.remove(r);
          } else {
            records.push(r.getId());
          }
        }, this);
        this.deleteData({receivable_ids : records}, function(result){
          this.up('panel').down('#invoice_details_grid').store.load();
          this.up('panel').down('#invoice_list_grid').store.load();
        }, this);
    }
  }, this);
  }
  JS

  endpoint :delete_data do |params|
    params[:receivable_ids].each {|receivable_id|
      receivable = Receivable.find(receivable_id)
      invoice = receivable.invoice
      receivable.invoice = nil
      receivable.save!
      receivable.system_driven_event = true
      receivable.revert_status_to_approved!  if receivable.may_revert_status_to_approved?
      receivable.system_driven_event = false
      refresh_invoice(invoice, receivable)
    }
    {:set_result => true}
  end

  def refresh_invoice(invoice, receivable)
    invoice.receivables.empty? ? invoice.delete : invoice.update_attributes(:invoice_amount => invoice.invoice_amount - receivable.receivable_amount)
  end
end

