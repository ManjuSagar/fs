class ReceivedPaymentInvoices < Mahaswami::GridPanel
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
        item_id: 'received_payment_invoices',
        bbar: false,
        tbar: [{name: :payer_name, fieldLabel: 'Insurance', filter: true, enableKeyEvents: true, xtype: 'textfield',
          item_id: 'received_payer_name'}, "->", :apply.action, :edi_download.action, :print.action, :undo.action],
        columns: [{name: :patient_name, width: '14%',label: "Patient", editable: false, addHeaderFilter: true },
                  {name: :field_staff, label: "Field Staff", width: '14%', addHeaderFilter: true},
                  {name: :purpose, width: '14%', label: 'Visit', editable: false, addHeaderFilter: true},
                  {name: :receivable_date, editable: false, label: "Date", width: '8.5%', addHeaderFilter: true},
                  {name: :invoice_no, width: '6%', label: "Invoice", addHeaderFilter: true},
                  {name: :sent_date_display, editable: false, label: "Sent", width: '8.5%', filter1: {xtype: :datefield}},
                  {name: :payment_due_date_display, editable: false, label: "Due", width: '8.5%', filter1: {xtype: :datefield}},
                  {name: :total_amount, label: "Billed", width: '6%', renderer: :formattedAmount},
                  {name: :received_amount, label: "Received", width: '6%', renderer: :formattedAmount},
                  {name: :reference_number, label: "Ref #", width: '6%', addHeaderFilter: true},
                  {name: :balance_amount, label: "Balance", width: '6%', renderer: :formattedAmount}
                ],
        scope: component_session[:scope] || ["scope_with_params,private_ins_scope"] + ['R']
    )
  end
  action :edi_download, text: 'EDI Download', cls: 'blue-color-button', disabled: true
  action :print, text: 'Print', cls: 'blue-color-button', disabled: true
  action :undo, text: 'Undo', cls: 'blue-color-button', disabled: true

  js_method :init_component, <<-JS
    function(){
     this.callParent();
     var actions = ['print','undo'];
     this.getSelectionModel().on('selectionchange', function(selModel){
        var selectedRecordCount = (selModel.getCount() == 0)
        enableDisableActions(actions, selectedRecordCount, this);
        this.actions.ediDownload.setDisabled(selModel.getCount() == 0);
     },this);
      var receivedPayerName = Ext.ComponentQuery.query('#received_payer_name')[0];
      receivedPayerName.on('keyup', function(t, e) {
        if(e.getKey() == e.ENTER) {
        this.filterInsurancePayments({payer_name: receivedPayerName.value, status: 'R'}, function() {
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

  js_method :on_print, <<-JS
    function(){
      if(this.selectedRecordIds.length > 0){
        this.loadNetzkeComponent({name: "print_selection_component", callback: function(w){
          w.show();
        }});
      } else {
        Ext.MessageBox.alert("Status", "No record(s) selected to process.");
      }
    }
  JS

  component :print_selection_component do
    {
        class_name: "PopupWindow",
        comp_name: "PrivateInsurancePrintSelection",
        border: false,
        params: {invoice_list_item_id: 'received_payment_invoices', received_payments_print: true},
        width: "20%",
        height: "30%",
        title: "Print"
    }
  end

  js_method :on_undo, <<-JS
    function() {
      if(this.selectedRecordIds.length > 0) {
        this.undoSelectedRecords({record_ids: this.selectedRecordIds}, function(res){
          if(res){
            this.doNotRememberAfterStoreReload = true;
            this.store.load();
            this.doNotRememberAfterStoreReload = false;
          }
        })
      } else {
        Ext.MessageBox.alert("Status", "No record(s) selected to process.");
      }

    }

  JS

  endpoint :undo_selected_records do |params|
    receivables = PrivateReceivable.sent_receivables(params[:record_ids], 'R')
    receivables.each{|receivable|
      receivable.system_driven_event = true
      receivable.undo! if receivable.may_undo?
    }
    {set_result: receivables.size > 0}
  end

end