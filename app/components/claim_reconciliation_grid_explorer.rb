class ClaimReconciliationGridExplorer < Mahaswami::Panel
  def configuration
    s = super
    s = s.merge(s[:params])
    @invoice ||= Invoice.org_scope.find(s[:invoice_id])
    @remit_claim ||= MedicareRemittanceClaim.find_by_invoice_id(@invoice.id)
    s.merge(
      header: false,
      payments_details_required: @remit_claim.present?,
      claim_not_sent: [:draft, :approved].include?(@invoice.invoice_status),
      margin: '0 0 5 0',
      bbar: ['->', :mark_as_denied.action, :mark_as_partially_paid.action, :mark_as_paid.action, :cancel.action],
      items: [
          :patient_and_amount_details.component,
          :claim_reconcile.component
      ] + (@remit_claim.present? ? [:payments.component] : [])
    ).merge(@remit_claim.present? ? {auto_scroll: true} : {layout: :border})
  end

  component :patient_and_amount_details do
    {
        class_name: "PatientAndAmountDetails",
        height: 100,
        region: :north,
        xtype: :fieldset,
        margin: 5,
        title: "Details",
        invoice_id: config[:invoice_id],
        remit_claim_id: config[:remit_claim_id]
    }
  end

  component :claim_reconcile do
    {
        class_name: "ReceivableList",
        title: "Line Items",
        region: :center,
        height: 200,
        margin: 5,
        enable_pagination: false,
        edit_on_dbl_click: false,
        item_id: :claim_line_items,
        strong_default_attrs: {invoice_id: config[:invoice_id]},
        invoice_id: config[:invoice_id],
        scope: {:invoice_id => config[:invoice_id]}
    }
  end

  component :payments do
    {
        class_name: "RemittanceClaimPaymentsExplorer",
        height: 400,
        invoice_id: config[:invoice_id],
        border: false,
        region: :south,
        header: false,
        margin: 5,
        receivable_id: (component_session[:receivable_id] || -1),
        service_id: (component_session[:line_item_id] || -1),
        claim_pmt_id: (component_session[:claim_pmt_id] || -1),
        remit_claim_id: config[:remit_claim_id]
    }
  end

  action :mark_as_denied, text: "Mark as Denied"
  action :mark_as_partially_paid, text: "Mark as Partially Paid"
  action :mark_as_paid, text: "Mark as Paid"
  action :cancel, text: "", tooltip: "Cancel", icon: :cancel_new

  js_method :buttons_disable_or_enable, <<-JS
    function(){
       this.actions.markAsDenied.setDisabled(this.claimNotSent);
       this.actions.markAsPartiallyPaid.setDisabled(this.claimNotSent);
       this.actions.markAsPaid.setDisabled(this.claimNotSent);
    }
  JS

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.buttonsDisableOrEnable();
      if(this.paymentsDetailsRequired) {
        var claimLineItems = this.up('panel').down('#claim_line_items');
        var servicePayments = this.up('panel').down('#claim_service_payment');
        var claimPayments = this.up('panel').down('#claim_payment');
        var servicePaymentAdjustments = this.up('panel').down('#service_payment_adjustment');
        var claimPaymentAdjustments = this.up('panel').down('#claim_payment_adjustment');

        claimLineItems.on('itemclick', function(view, record){
          this.setClaimId({claim_id: record.get('id')}, function(result){
            servicePayments.store.load();
            servicePaymentAdjustments.store.load();
          }, this);
        }, this);

        servicePayments.on('itemclick', function(view, record){
          this.setServicePmtId({service_pmt_id: record.get('id')}, function(result){
            servicePaymentAdjustments.store.load();
          }, this);
        }, this);

        claimPayments.on('itemclick', function(view, record){
          this.setClaimPmtId({clm_pmt_id: record.get('id')}, function(result){
            claimPaymentAdjustments.store.load();
          }, this);
        }, this);
      }
    }
  JS

  js_method :on_mark_as_denied,<<-JS
    function(){
      this.updateInvoiceStatus("denied");
    }
  JS

  js_method :on_mark_as_partially_paid,<<-JS
    function(){
      this.updateInvoiceStatus("partially_paid");
    }
  JS

  js_method :on_mark_as_paid,<<-JS
    function(){
      this.updateInvoiceStatus("paid");
    }
  JS

  js_method :update_invoice_status,<<-JS
    function(status){
      this.changeClaimStatus({status: status}, function(res){
        this.reloadInvoicesListGrid();
        this.closeWindow();
      }, this);
    }
  JS

  js_method :on_cancel, <<-JS
    function(){
      this.closeWindow();
    }
  JS

  js_method :close_window, <<-JS
    function(){
      var window = this.up('window');
      window.close();
    }
  JS

  js_method :reload_invoices_list_grid, <<-JS
    function(){
      var refershGrid = Ext.ComponentQuery.query('#invoice_list_grid')[0];
      if(refershGrid){
        refershGrid.store.load();
      }
    }
  JS

  endpoint :set_claim_id do |params|
    component_session[:receivable_id] = params[:claim_id]
    component_session[:line_item_id] = nil
  end

  endpoint :set_service_pmt_id do |params|
    component_session[:line_item_id] = params[:service_pmt_id]
  end

  endpoint :set_claim_pmt_id do |params|
    component_session[:claim_pmt_id] = params[:clm_pmt_id]
  end

  endpoint :change_claim_status do |params|
    invoice = Invoice.org_scope.find(config[:invoice_id])
    res = false
    invoice.system_driven_event = true
    res = case params[:status]
            when "denied"
              invoice.mark_as_denied! if invoice.may_mark_as_denied?
            when "partially_paid"
              invoice.mark_as_partially_paid! if invoice.may_mark_as_partially_paid?
            when "paid"
              invoice.mark_as_paid! if invoice.may_mark_as_paid?
          end
    invoice.system_driven_event = false
    {set_result: res}
  end
end

