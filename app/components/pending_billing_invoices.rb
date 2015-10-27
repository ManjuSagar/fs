class PendingBillingInvoices < Mahaswami::GridPanel
  include EdiFileDownloadForPrivateInsuranceInvoices
  def configuration
    c = super
    c.merge(
        auto_scroll: true,
        model: 'PrivateReceivable',
        editOnDblClick: false,
        checkboxModel: true,
        item_id: 'private_insurance_pending_billing',
        infinite_scroll: false,
        enable_pagination: false,
        columns: [{name: :payer_name, editable: false, label: "Insurance", width: '16%', addHeaderFilter: true},
                  {name: :patient_name, width: '14%',label: "Patient", editable: false, addHeaderFilter: true },
                  {name: :field_staff, label: "Field Staff", width: '12%', addHeaderFilter: true},
                  {name: :purpose, width: '12%', label: 'Visit', editable: false, addHeaderFilter: true},
                  {name: :receivable_date, editable: false, label: "Date", width: '8.5%', filter1: {xtype: 'datefield'}, addHeaderFilter: true},
                  {name: :due_date_display, editable: false, label: "Due", width: '8.5%',filter1: {xtype: 'datefield'}},
                  {name: :units_display, label: "Unit", editable: false, width: "6%", addHeaderFilter: true,
                          filter1: {xtype: "combo", editable: false, store: [["", "---"], ["V", "Visit"], ["H", "Hour"]]}},
                  {name: :no_of_units, label: "#", align: 'center', width: '4%'},
                  {name: :visit_type_rate, editable: false, label: "Rate", width: '6%', align: "right", renderer: :formattedAmount},
                  {name: :total_amount, label: "Total", width: '6%', align: "right", renderer: :formattedAmount}
        ],
        scope: :pending_billing_scope
    )
  end

  def default_bbar
    [:print.action, :edi_download.action, {text: 'Send', cls: 'blue-color-button', item_id: :send_button, menu: [:print_claim_and_mark_sent.action, :mark_as_sent.action]}]
  end

  action :print, text: 'Print', cls: 'blue-color-button', disabled: true
  action :mark_as_sent, text: 'Mark Sent'
  action :print_claim_and_mark_sent, text: "Print and Mark Sent"
  action :edi_download, text: "EDI Download", cls: 'blue-color-button', disabled: true

js_method :init_component, <<JS
  function(){
    this.callParent();
    var sendButton = Ext.ComponentQuery.query('#send_button')[0];
    sendButton.setDisabled(true);
    this.actions.print.setDisabled(true);
    this.getSelectionModel().on('selectionchange', function(selModel){
      var selectedModelCount = selModel.getCount();
      sendButton.setDisabled(selectedModelCount == 0);
      this.actions.ediDownload.setDisabled(selectedModelCount == 0);
      this.actions.print.setDisabled(selectedModelCount == 0);
    },this);
  }
JS

  js_method :on_print, <<JS
    function(){
      this.loadNetzkeComponent({name: "print_component", params:{component_params: {print_and_mark_as_sent: true}},callback: function(w){
        w.show();
      }});
    }
JS

  js_method :on_print_claim_and_mark_sent,<<-JS
    function(){
      this.loadNetzkeComponent({name: "date_component_and_print",callback: function(w){
        w.show();
     }});
  }
  JS

  js_method :on_edi_download,<<-JS
    function(){
      this.checkSameInsuranceCompany({record_ids: this.selectedRecordIds}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "edi_download",callback: function(w){
            w.show();
          }});
        } else {
          Ext.MessageBox.alert("Status", "Select same insurance company receivables.");
        }
      });
    }
  JS

  js_method :edi_file_download,<<-JS
    function(w, date){

          this.createInvoiceAndEdiDownload({record_ids: this.selectedRecordIds, date: date}, function(res){
            if(res[0]) {
              var msg = "The following claim number having problem:<br/><br/>";
              Ext.each(res[1], function(error, index){
              msg = msg + error[0].toString() + " : " + error[1] + "<br/>";
              }, this);
              msg = msg + "<br/>" + "Please contact FasterNotes support at (888) 255-8508 <br/> to set up batch claim transmission."
              Ext.Msg.show({
              title: 'Send Error',
              msg: msg,
              buttons: Ext.Msg.OK,
              icon: Ext.Msg.ERROR,
              });
            } else if (res[1]) {
              window.location.href = window.location.protocol + "//" + window.location.host + res[1] + "?target=_blank";
              this.doNotRememberAfterStoreReload = true;
              this.store.load();
              this.doNotRememberAfterStoreReload = false;
            }
          },this);
    }
  JS

  js_method :on_mark_as_sent,<<JS
    function(){
      this.loadNetzkeComponent({name: "date_component", callback: function(w){
        w.show();
     }});
  }
JS

  component :date_component do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: 'private_insurance_pending_billing', show_printing_options: false, mark_as_sent: true},
        title: "Claim Sent Date"
    }
  end

  component :edi_download do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: 'private_insurance_pending_billing', show_printing_options: false, edi_download: true},
        title: "Claim Sent Date"
    }
  end

  component :date_component_and_print do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: 'private_insurance_pending_billing', show_printing_options: true, print_and_mark_as_sent: true},
        title: "Claim Sent Date"

    }
  end

  js_method :print_invoice_after_sent, <<-JS
    function(w, date, documents, invoices, forms){
      var selModel = this.getSelectionModel();
      this.sendClaimSentDate(w, date);
      this.printInvoiceDetails({selected_claims: this.selectedRecordIds, date: date,
                                 doc_required: documents, form_required: forms, inv_required: invoices}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }else{
          if(documents == true && invoices == false && forms == false){
            Ext.MessageBox.alert("Status", "No Documents to print.");
          }else if (documents == false && invoices == false && forms == true){
            Ext.MessageBox.alert("Status", "No Form type selected to print.");
          }else if (documents == true && invoices == false && forms == true){
            Ext.MessageBox.alert("Status", "No Documents and No Form type selected to print.");
          }
        }
      },this);
      this.rememberStoreReload();
    }
  JS

  js_method :remember_store_reload, <<-JS
    function(){
      this.doNotRememberAfterStoreReload = true;
      this.store.load();
      this.doNotRememberAfterStoreReload = false;
    }
JS

  component :print_component do
   {
       class_name: "PopupWindow",
       comp_name: "PrivateInsurancePrintSelection",
       params: {invoice_list_item_id: 'private_insurance_pending_billing'},
       width: "20%",
       height: "30%",
       title: "Print"
   }
  end

  endpoint :print_invoice_details do |params|
    p = PrivateInsuranceInvoice.new
    params.merge!({status: 'S', action: 'sent'})
    url = p.print_claims(params)
    if url
      session[:pre_generated_file_name] = url
      component_session[:title] = "Invoice"
      component_session[:report_url] = "/reports/pre_generated"
    end
    {set_result: url.present?}
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: component_session[:title],
        width: '60%',
        height: '90%',
        url: component_session[:report_url]
    }
  end


  js_method :send_claim_sent_date,<<JS
    function(w,date){
    var paymentInvoiceGrid = Ext.ComponentQuery.query('#pending_payments_invoices')[0];
    this.createInvoice({record_ids: this.selectedRecordIds, date: date}, function(res){
      if(res){
          w.close();
          this.rememberStoreReload();
        } else {
          Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
        }
    },this);
   }
JS

  class ClaimEdiDownloadException < Exception
    def message
      "This exception is raised here. Since we need to stop sending claims if errors present while downloading EDI."
    end
  end

  endpoint :create_invoice_and_edi_download do |params|
    url = [];errors_present = false
    begin
    ActiveRecord::Base.transaction do
      PrivateInsuranceInvoice.create_invoice_group_by_insurance_company(params)
      private_receivables = PrivateReceivable.org_scope.where(id: params[:record_ids])
      private_claims = private_receivables.group_by(&:private_insurance_invoice).keys
      errors_present, url = PrivateInsuranceInvoice.get_edi_url_and_claims_mark_as_sent(private_claims, params, private_receivables)
      raise ClaimEdiDownloadException if errors_present
      {set_result: [errors_present, url]}
    end
    rescue ClaimEdiDownloadException
      {set_result: [errors_present, url]} if errors_present
    end
  end

  endpoint :create_invoice do |params|
    PrivateInsuranceInvoice.create_invoice_group_by_insurance_company(params)
    {set_result: true}
  end

end