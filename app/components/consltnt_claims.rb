class ConsltntClaims < InvoiceList
  def configuration
    s = super
    s.merge(
        infinite_scroll: false,
        enable_pagination: false,
        rows_per_page: 500,
        title: "Claims",
        item_id: :consultant_invoices_list,
        columns: [{name: :invoice_number, label: "Claim", editable: false, width: "5%", addHeaderFilter: true},
                  {name: :agency_name, label: "Agency", editable: false, width: "23%", addHeaderFilter: true},
                  {name: :treatment__to_s, label: "Patient", editable: false, addHeaderFilter: true, width: "17%"},
                  {name: :patient_hi_claim_number, label: "HIC", editable: false, width: "12%", addHeaderFilter: true},
                  {name: :invoice_type, label: "Type", getter: lambda{|r| Invoice::INVOICE_TYPES[r.invoice_type]}, filter1: {xtype: "combo", store: Invoice::TYPE_STORE_FOR_CONSULTANT}, width: "6%"},
                  {name: :treatment_episode__to_s, label: "Episode", editable: false, filter1: {xtype: :datefield}, width: "14%"},
                  {name: :invoice_amount, label: "Amount", editable: false, align: "right", renderer: :render_invoice_amount, width: "8%"},
                  {name: :invoice_status, label: "Status", editable: false, getter: lambda{|r| get_invoice_status(r)}, width: "9%", filter1: {xtype: "combo", store: Invoice::STATUS_STORE_FOR_CONSULTANT}},
                  # {label: "", renderer: :action_image_renderer, width: "3%"}
        ],
        scope: :consultant_scope
    )
  end
  def default_bbar
    actions = [{text: "Send", item_id: 'menu', menu: send_buttons}]
    actions = actions + [:undo_claims_mark_as_sent.action, :export_zip_file.action, :print_invoice.action]
  end

  def send_buttons
    [:ready_for_esend.action, :print_claim_and_mark_sent.action, :send_claims.action]
  end

  action :send_claims, text: "Mark Sent", tooltip: "Mark Claim(s) as Sent"
  action :ready_for_esend, text: "Send Electronically and Mark Sent", tooltip: "Mark Claim(s) As Ready For ESend"
  action :undo_claims_mark_as_sent, text: "Undo", tooltip: "Undo Claim(s) Mark As Sent"
  action :export_zip_file, text: "", tooltip: "Export as Zip", icon: :zip_folder

  def get_invoice_status(r)
    r.invoice_status == :ready_for_esend ? 'Approved' : r.invoice_status.to_s.titleize
  end

  js_method :action_image_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store) {
      var recordId = record.get("id");
      var recordStatus = record.get("invoice_status");
      var joinedAttrs = recordId + ':' + recordStatus;
      var imageClick = 'Ext.ComponentQuery.query(\"#consultant_invoices_list\")[0].performAction(\"' + joinedAttrs + '\");';
      if(recordStatus=="Approved"){
        return "<div style='cursor:pointer;' onclick="+ imageClick +"><img src='/assets/right1.png'/></div>"
      }else if(recordStatus=="Sent"){
        return "<div style='cursor:pointer;' onclick="+ imageClick +"><img src='/assets/wrong.png'/></div>"
      }
    }
  JS

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      grid = this;
      this.on('itemclick',function(view, record){
        this.checkStatusToHideSendClaimsButton({invoice_id : record.get('id')}, function(result){
          this.actions.undoClaimsMarkAsSent.setDisabled(result);
          if(result){
            this.actions.sendClaims.show();
          } else {
            this.actions.sendClaims.hide();
          }
        }, this);
      });
    }
  JS

  js_method :perform_action,<<-JS
    function(joinedAttrs){
      var attrArr = joinedAttrs.split(":");
      var recordId = attrArr[0];
      var recordStatus = attrArr[1];
      if (recordStatus == "Approved"){
        this.sentInvoice({invoice_id: recordId}, function(){
          this.afterActionResetSelection();
        },this);
      }else if (recordStatus == "Sent"){
        this.unsentInvoice({invoice_id: recordId}, function(){
          this.afterActionResetSelection();
        },this);
      }
    }
  JS

  js_method :after_action_reset_selection, <<-JS
    function(){
       this.doNotRememberAfterStoreReload = true;
       this.store.load();
       this.doNotRememberAfterStoreReload = false;
    }
  JS

  js_method :on_send_claims,<<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
            this.loadNetzkeComponent({name: "sent_date_component", callback: function(w){
                w.show();
            }});
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
    }
  JS

  component :sent_date_component do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: config[:item_id], mark_as_sent: true},
        width: "20%",
        height: "18%",
        title: "Claim Sent Date"
    }
  end

  js_method :on_print_claim_and_mark_sent, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      if(this.selectedRecordIds.length > 0) {
        this.loadNetzkeComponent({name: "date_component_and_print", callback: function(w){
          w.show();
        }});

      }

    }

  JS

  component :date_component_and_print do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: config[:item_id],
                 print_and_mark_as_sent: true},
        width: "20%",
        height: "18%",
        title: "Claim Sent Date"
    }
  end

  js_method :print_invoice_after_sent, <<-JS
    function(w, date){
      var selModel = this.getSelectionModel();
      var recordId = selModel.selected.first().getId();
        this.printInvoiceDetails({records: this.selectedRecordIds, check_box_model: true}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }
      },this);
      this.sendClaimSentDate(w, date);
      this.afterActionResetSelection();

    }
  JS

  js_method :send_claim_sent_date, <<-JS
    function(w, date){
      this.sentSelectedInvoices({records: this.selectedRecordIds, sent_date: date }, function(result) {
        if(result){
          w.close();
          this.store.load();
          this.afterActionResetSelection();
        } else {
          Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
        }
      }, this);
    }
  JS

  js_method :on_ready_for_esend,<<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.invoicesReadyForElectronicSubmission({records: this.selectedRecordIds}, function(res){
        this.afterActionResetSelection();
        },this);
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
    }
  JS

  js_method :on_undo_claims_mark_as_sent,<<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.unSentSelectedInvoices({records: this.selectedRecordIds}, function(res){
          this.afterActionResetSelection();
        },this);
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
    }
  JS

  js_method :on_export_zip_file,<<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.setLoading("Generating...");
        this.generateExcelFormattedUb04({records: this.selectedRecordIds}, function(url){
          this.setLoading(false);
          var recs = [];
          Ext.each(this.selectedRecordIds, function(rec_id, index){
            recs.push(this.store.findRecord('id', rec_id));
          }, this);
          this.getSelectionModel().deselect(recs);
          url = window.location.protocol + "//" + window.location.host + url + "?target=_blank";
          window.location = url;
        }, this);
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to download.");
      }
    }
  JS

  endpoint :check_status_to_hide_send_claims_button do |params|
    result = false
    invoice = Invoice.find_by_id(params[:invoice_id])
    if invoice
      result = invoice.approved?
    end
    {:set_result => result }
  end

  endpoint :generate_excel_formatted_ub04 do |params|
    reference_name = Invoice.generate_zip_file(params[:records])
    url = Rails.application.routes.url_helpers.export_claims_zip_file_path(reference_name)
    {set_result: url}
  end

  endpoint :sent_selected_invoices do |params|
    list = Invoice.consultant_scope.where(["id in (?) and invoice_status in (?)", params[:records], 'A'])
    ActiveRecord::Base.transaction do
      list.each{|i|
        i.sent_date = params[:sent_date].to_date
        i.mark_as_sent! if i.may_mark_as_sent?
      }
    end
    {:set_result => true}
  end


 endpoint :invoices_ready_for_electronic_submission do |params|
    list = Invoice.consultant_scope.where(["id in (?) and invoice_status in (?)", params[:records], 'A'])
    ActiveRecord::Base.transaction do
      list.each{|i| i.mark_as_ready_for_esend! if i.may_mark_as_ready_for_esend?}
    end
    {:set_result => true}
  end

  endpoint :un_sent_selected_invoices do |params|
    list = Invoice.consultant_scope.where("id in (?)", params[:records])
    ActiveRecord::Base.transaction do
      list.each{|i| i.undo! if i.may_undo?}
    end
    {:set_result => true}
  end

  endpoint :check_uniq_payer_invoices do |params|
    claims_insurances = Invoice.consultant_scope.where(['id in (?)',params[:records]]).map(&:payer).uniq
    res = [claims_insurances.count > 1, (claims_insurances.count  == 1 and claims_insurances.first.company_code != 'MEDICARE')]
    {set_result: res}
  end

  endpoint :check_status_to_hide_mark_sent_button do |params|
    result = false
    approved_claims = Invoice.consultant_scope.where(["id in (?) and invoice_status in (?)", params[:records], 'A'])
    if approved_claims
      result = approved_claims.count > 0
    end
    {:set_result => result }
  end

  js_method :on_print_invoice, <<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.setLoading(true);
        this.printInvoiceDetails({records: this.selectedRecordIds, check_box_model: true}, function(res){
          this.afterActionResetSelection();
          this.setLoading(false);
          if(res){
            this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
          }
        }, this);
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
    }
  JS

  endpoint :print_invoice_details do |params|
    list = params[:records]
    selected_invoices = Invoice.consultant_scope.where("id in (?)", list)
    invoice = selected_invoices.first
    res = ReportDataSource::MedicareClaim.combine_selected_invoices(selected_invoices)
    session[:pre_generated_file_name] = res
    component_session[:title] = "Claim Details"
    component_session[:report_url] = "/reports/pre_generated"
    {:set_result => res}
  end

  endpoint :sent_invoice do |params|
    invoice = Invoice.consultant_scope.find(params[:invoice_id])
    ActiveRecord::Base.transaction do
      invoice.mark_as_sent! if invoice.may_mark_as_sent?
    end
  end

  endpoint :unsent_invoice do |params|
     invoice = Invoice.consultant_scope.find(params[:invoice_id])
     ActiveRecord::Base.transaction do
       invoice.undo! if invoice.may_undo?
     end
  end

end