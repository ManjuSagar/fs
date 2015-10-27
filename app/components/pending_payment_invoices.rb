class PendingPaymentInvoices < Mahaswami::GridPanel
  include EdiFileDownloadForPrivateInsuranceInvoices
	def configuration
    c = super
    c.merge(
        auto_scroll: true,
        model: 'PrivateReceivable',
        editOnDblClick: false,
        checkboxModel: true,
        infinite_scroll: false,
        enable_pagination: false,
        bbar: false,
        item_id: 'pending_payments_invoices', 
        tbar: [{name: :payer_name, fieldLabel: 'Insurance', filter: true, enableKeyEvents: true, xtype: 'textfield',
                 item_id: 'pending_payer_name'}, "->", :apply.action, :edi_download.action, :print.action, :receive.action, :undo.action],
        columns: [{name: :patient_name, width: '14%',label: "Patient", editable: false, addHeaderFilter: true },
                  {name: :field_staff, label: "Field Staff", width: '14%', addHeaderFilter: true},
                  {name: :purpose, width: '14%', label: 'Visit', editable: false, addHeaderFilter: true},
                  {name: :receivable_date, editable: false, label: "Date", width: '8.5%', addHeaderFilter: true},
                  {name: :invoice_no, width: '6%', label: "Invoice", addHeaderFilter: true},
                  {name: :sent_date_display, editable: false, label: "Sent", width: '8.5%', addHeaderFilter: true, filter1: {xtype: :datefield}},
                  {name: :payment_due_date_display, editable: false, label: "Due", width: '8.5%', filter1: {xtype: 'datefield'}},
                  {name: :total_amount, label: "Billed", width: '6%', renderer: :formattedAmount},
                  {name: :received_amount, label: "Received", width: '6%', renderer: :formattedAmount},
                  {name: :reference_number, label: "Ref #", width: '6%', addHeaderFilter: true},
                  {name: :balance_amount, label: "Balance", width: '6%', renderer: :formattedAmount}
                 ],
        scope: component_session[:scope] || ["scope_with_params,private_ins_scope"] + ['S']
    )
  end

  action :edi_download, text: 'EDI Download', cls: 'blue-color-button', disabled: true
  action :print, text: 'Print', cls: 'blue-color-button', disabled: true
  action :receive, text: 'Receive', cls: 'blue-color-button', disabled: true
  action :undo, text: 'Undo', cls: 'blue-color-button', disabled: true

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      actions = ['print','receive','undo','ediDownload'];
      this.getSelectionModel().on("selectionchange", function(selModel){
        var selectedRecordCount = (selModel.getCount() == 0);
        enableDisableActions(actions, selectedRecordCount, this);
        this.actions.ediDownload.setDisabled(selModel.getCount() == 0);
      },this);
      var pendingPayerName = Ext.ComponentQuery.query('#pending_payer_name')[0];
      pendingPayerName.on('keyup', function(t, e) {
        if(e.getKey() == e.ENTER) {
          this.filterInsurancePayments({payer_name: pendingPayerName.value, status: 'S'}, function() {
            this.store.load();
          }, this);
        }
      }, this);
      this.store.on('load', function(){
        if(this.url) window.location = this.url;
          this.url = null;
        }, this);
    }
  JS

  endpoint :filter_insurance_payments do |params|
    value = params[:payer_name].upcase if params[:payer_name]
    sql_string = "org_id = #{Org.current.id} AND receivable_status = '#{params[:status]}' AND payer_id in (SELECT id FROM insurance_companies WHERE upper(company_name) LIKE '%#{value}%')"
    component_session[:scope] = sql_string.empty? ? [] : ["#{sql_string}"]
    {}
  end

  js_method :on_receive, <<-JS
    function(){
      if(this.selectedRecordIds.length > 0){
        this.updateReceivableStatusToReceived({record_ids: this.selectedRecordIds}, function(res){
          if(res){
            this.doNotRememberAfterStoreReload = true;
            this.store.load();
            this.doNotRememberAfterStoreReload = false;
          }
        }, this);
      } else {
        Ext.MessageBox.alert("Status", "No record(s) selected to process.");
      }
    }
  JS

  js_method :on_print, <<-JS
    function(){
      if(this.selectedRecordIds.length > 0){
        this.loadNetzkeComponent({name: "print_selection",  callback: function(w){
          w.show();
        }})
      } else {
        Ext.MessageBox.alert("Status", "No record(s) selected to process.");
      }
    }
  JS

  component :print_selection do
    {
        class_name: 'PopupWindow',
        comp_name: 'PrivateInsurancePrintSelection',
        border: false,
        params: {invoice_list_item_id: 'pending_payments_invoices', pending_payments_print: true},
        width: "20%",
        height: "30%",
        title: "print"
    }
  end

  js_method :on_undo, <<-JS
    function() {
      if(this.selectedRecordIds.length > 0) {
        this.checkSameInvoiceNumber({record_ids: this.selectedRecordIds}, function(res){
          if(res){
            this.undoSelectedReceivables({record_ids: this.selectedRecordIds}, function(res){
              if(res){
                this.doNotRememberAfterStoreReload = true;
                this.store.load();
                this.doNotRememberAfterStoreReload = false;
              }
            }, this);
          }else {
            Ext.MessageBox.alert("Status", "Select same invoice number receivables.");
          }
        }, this);
      } else {
        Ext.MessageBox.alert("Status", "No record(s) selected to process.");
      }
    }
  JS

  endpoint :undo_selected_receivables do |params|
    receivables = PrivateReceivable.sent_receivables(params[:record_ids], 'S')
    receivables.each{|receivable|
      receivable.system_driven_event = true
      receivable.undo! if receivable.may_undo?
    }
    {set_result: receivables.size > 0}
  end

  endpoint :check_same_invoice_number do |params|
    receivables = PrivateReceivable.org_scope.find(params[:record_ids])
    res = (receivables.collect{|x| x.invoice_package.package_number if x.invoice_package}.uniq.size == 1)
    {set_result: res}
  end

  endpoint :update_receivable_status_to_received do |params|
    receivables = PrivateReceivable.org_scope.find(params[:record_ids])
    receivables.each{|receivable|
      receivable.mark_as_received! if receivable.may_mark_as_received?
    }
    {set_result: receivables.size > 0}
  end

end