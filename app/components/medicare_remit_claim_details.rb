class MedicareRemitClaimDetails < Mahaswami::GridPanel
  def configuration
    c = super
    c.merge(
      model: 'MedicareRemittanceClaim',
      title:  "Remittance Claims List",
      edit_on_dbl_click: false,
      autoScroll: true,
      columns: [
        {name: :patient_name, header: "Patient Name", editable: false,width: '20%'},
        {name: :account_number, header: "Account #", editable: false, width: '13%'},
        {name: :internal_control_number, header: "ICN", editable: false, width: '13%'},
        {name: :claim_billed_amount, header: "Billed Amt", align: "left", editable: false, width: '12%', renderer: :formattedAmount},
        {name: :provider_paid_amount, header: "Paid Amt", align: "left", width: '12%', editable: false, renderer: :formattedAmount},
        {name: :service_from_date_display, header: "Srv. from Date", editable: false, width: '15%'},
        {name: :service_to_date_display, header: "Srv. to Date", editable: false, width: '14%'},
        {name: :claim_assignment, header: "ASG", editable: false, width: '6%'},
      ]
    )
  end

  def default_bbar
    [ :view_claim_details.action]
  end

  action :view_claim_details, text: "", tooltip: "View Reconcile Claim", disabled: true, item_id: 'view_claim_detail_button', icon: :view_details

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.viewClaimDetails.setDisabled(selModel.getCount() == 0);
      }, this);
      this.on('itemdblclick',function(view, record){
        this.setInvoiceId({remit_claim_id : record.get('id')}, function(result){
          this.loadClaimReconciliationComponent({});
        }, this);
      }, this);
    }
  JS

  js_method :on_view_claim_details, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      var recordId = selModel.selected.first().get("id");
      this.setInvoiceId({remit_claim_id : recordId}, function(result){
        this.loadClaimReconciliationComponent({});
      }, this);
    }
  JS

  js_method :load_claim_reconciliation_component, <<-JS
    function(){
      this.loadNetzkeComponent({name: "popup_window", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            this.store.load();
          }
        }, this);
      }});
    }
  JS

  endpoint :set_invoice_id do |params|
    remit_claim = MedicareRemittanceClaim.find(params[:remit_claim_id])
    component_session[:remit_claim_id] = remit_claim.id
    component_session[:invoice_id] = remit_claim.invoice_id
    {}
  end

  component :popup_window do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimReconciliationGridExplorer",
        params: {invoice_id: component_session[:invoice_id], remit_claim_id: component_session[:remit_claim_id]},
        width: '90%',
        height: '90%',
        title: "Claim Details"
    }
  end

end