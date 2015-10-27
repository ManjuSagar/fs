class InvoiceList < Mahaswami::GridPanel
  include ButtonsOfOasisHeader
  def configuration
    s = super
    s.merge(
        checkboxModel: true,
        model: "Invoice",
        editOnDblClick: false,
        infinite_scroll: false,
        enable_pagination: false,
        rowsPerPage: 5000,
        item_id: "invoice_list_grid",
        columns:[
            {name: :invoice_number, label: "Invoice #", editable: false, width: "10%", addHeaderFilter: true}] +
            (s[:scope] ? [] : [{name: :treatment__to_s, label: "Patient", editable: false, addHeaderFilter: true}])+
            [{name: :payer_name, label: "Payer", editable: false, width: "15%", addHeaderFilter: true},
             {name: :invoice_type, label: "Type", editable: false, getter: lambda{|r| Invoice::INVOICE_TYPES[r.invoice_type]}, filter1: {xtype: "combo", store: Invoice::TYPE_STORE}, width: "10%"},
             {name: :treatment_episode__to_s, label: "Episode", editable: false, filter1: {xtype: :datefield}, width: "17%"},
             {name: :invoice_amount, label: "Amount", editable: false, align: "right", renderer: :render_invoice_amount},
             {name: :invoice_status, label: "Status", editable: false, getter: lambda{|r| get_invoice_status(r)}, filter1: {xtype: "combo", store: Invoice::STATUS_STORE}},
             {name: :aged, label: "Status", label: "Aged?", hidden: true},
             {name: :status_date, label: "Status Date", editable: false, width: "9%", filter1: {xtype: :datefield}},
             action_column("invoice_list_grid")
            ],
        scope: (s[:scope] || :not_pending_scope)
    )
  end

  def action_column(grid_component_id = nil)
    comp_id = grid_component_id || self.class.name.underscore
    {name: :actions, flex: 1, label: "", editable: false,
     :getter => lambda {|x| x.events_for_current_state.collect{|r|
       link_to_function(human_action_name(r, x), perform_event(comp_id, x, r), {id: "record_#{x.id}"}) if x.can_display_actions? }.join(" | ")
     }
    }
  end

  def get_invoice_status(r)
    r.invoice_status == :ready_for_esend ? 'Approved' : r.invoice_status.to_s.titleize
  end

  def perform_event(comp_name, record, event)
    if event == :mark_as_sent
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.loadNetzkeComponent({name: "date_component", callback: function(w){
          w.show();
        }});
      JS
    elsif event == :approve
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.displayIcd10Component({record_id: "#{record.id}"}, function(res){
          if(res){
            g.loadNetzkeComponent({name: "icd10_display_component", callback: function(w){
              w.show();
              var okButton = Ext.ComponentQuery.query('#icd9_to_icd10_ok')[0];
              okButton.on('click', function(){
                 var transistionForm = Ext.ComponentQuery.query('#icd9_to_icd_10_transition')[0];
                 var icd10Values = transistionForm.getValues();
                 g.checkErrors({values: icd10Values}, function(res){
                   if(res == true){
                     g.setLoading(true);
                     g.performAction(#{record.id}, "#{event.name}");
                     g.setLoading(false);
                     var window = transistionForm.up('window');
                     window.close();
                   }else{
                     Ext.MessageBox.alert('Errors', res.join(''));
                  }
                });
              });
            }});
          } else {
            g.setLoading(true);
            g.performAction(#{record.id}, "#{event.name}");
            g.setLoading(false);
          }
        },g);
      JS
    else
      super
    end
  end

  endpoint :check_errors do |params|
    icd10_codes = ["m1021_primary_diag_icd", "m1023_oth_diag1_icd", "m1023_oth_diag2_icd", "m1023_oth_diag3_icd", "m1023_oth_diag4_icd", "m1023_oth_diag5_icd"]
    icd9_codes = ["m1020_primary_diag_icd", "m1022_oth_diag1_icd", "m1022_oth_diag2_icd", "m1022_oth_diag3_icd", "m1022_oth_diag4_icd", "m1022_oth_diag5_icd"]
    total_icd_codes = icd10_codes + icd9_codes
    icd_values = params["values"]
    errors_res = []
    if icd_values.present?
      m1021 = icd_values[:m1021_primary_diag_icd]
       if (m1021.present? and  (m1021[0].upcase == 'V' || m1021[0].upcase == 'W'|| m1021[0].upcase == 'X'|| m1021[0].upcase == 'Y'))
         errors_res << "M1021 Primary diagonsis icd, #{m1021[0].upcase} code not allowed. <br/>"
       end
      total_icd_codes.each do |icd|
        icd_code = icd_values["#{icd}"]
        if icd_code.present?
          valid_code = Document.netzke_combo_options_for(icd, {query: icd_code})
          (valid_code.empty?)?  errors_res << "#{icd[0..4].upcase} Enter the Valid ICD codes. </br>" : ''
        end
      end
      (icd_values[:m1021_primary_diag_icd] == '' && icd_values[:m1023_oth_diag1_icd]== '' && icd_values[:m1023_oth_diag2_icd] == '' &&
         icd_values[:m1023_oth_diag3_icd] == '' && icd_values[:m1023_oth_diag4_icd] && icd_values[:m1023_oth_diag5_icd])? errors_res << "Enter atleast one ICD-10 code <br/>": ''
      (icd_values[:m1020_primary_diag_icd] == '' && icd_values[:m1022_oth_diag1_icd]== '' && icd_values[:m1022_oth_diag2_icd] == '' &&
          icd_values[:m1022_oth_diag3_icd] == '' && icd_values[:m1022_oth_diag4_icd] && icd_values[:m1022_oth_diag5_icd])? errors_res << "Enter atleast one ICD-9 code <br/>": ''
      if errors_res.length > 0
        {set_result: errors_res}
      else
        doc = Document.find(component_session[:doc_id])
        doc.update_attributes(params["values"])
        doc.save
        {set_result: true}
      end
    else
      {set_result: true}
    end
  end

  endpoint :display_icd10_component do |params|
    invoice = Invoice.org_scope.where(id: params[:record_id]).first
    component_session[:doc_id] = invoice.treatment_episode.rap_generated_document if invoice
    {set_result: invoice.display_transition_window}
  end

  component :date_component do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: config[:item_id],
                 mark_as_sent: true},
        width: "20%",
        height: "18%",
        title: "Claim Sent Date"
    }
  end

  component :icd10_display_component do
    invoice = Invoice.org_scope.where(id: component_session[:invoice_id]).first
    doc_id = invoice.treatment_episode.rap_generated_document if invoice
    rap = invoice.rap? if invoice
    {
      class_name: "PopupWindow",
      comp_name: "Icd9ToIcd10Transition",
      params: {doc_id: doc_id, invoice_id: component_session[:invoice_id]},
      modal: true,
      width: "50%",
      height: "60%",
      title: 'Final Claim Approval with ICD Codes',
      header: {
          titlePosition: 0,
          items: [
            gem_button('gem')
          ]
      }
    }
  end

  def human_action_name(event, invoice)
    if event == :undo
      "Undo " + invoice.aasm_current_state.to_s.titleize
    else
      event.title
    end
  end

  def default_bbar
    edit_button + [:undo_claims.action, {menu: send_buttons, item_id: 'menu', text: "Send"}, :del.action,
                   {item_id: 'print_menu',menu: [:print_invoice.action, :print_invoice_wot_border.action, :private_ins_invoice.action], text: "", iconCls: 'print_icon'},
                   :dde_link.action, :view_reconcile_claim.action]
  end

  def edit_button
    ha_detail = HealthAgencyDetail.find_by_health_agency_id(Org.current)
    ha_detail.can_submit_claims_electronilly? ? [:edit_claim.action] : []
  end

  def send_buttons
    consultantHA = ConsultingCompanyHealthAgency.where(health_agency_id: Org.current.id)

    actions = consultantHA.present? ? [:send_claims_for_test.action] : ha_electronic_claim_send_buttons
    actions += [:send_claims_for_test_xml.action, :send_claims_for_prod_xml.action, :print_from_edi.action] if Rails.env == "development"
    actions
  end

  def ha_electronic_claim_send_buttons
    ha_detail = HealthAgencyDetail.find_by_health_agency_id(Org.current)
    ha_detail.can_submit_claims_electronilly? ? [:send_claims_for_test.action, :ready_for_esend.action, :print_claim_and_mark_sent.action, :mark_as_sent.action] :
                                [:send_claims_for_test.action, :print_claim_and_mark_sent.action, :mark_as_sent.action]

  end

  action :print_invoice, text: "Medicare with border", tooltip: "Print Medicare", icon: :print
  action :print_invoice_wot_border, text: "Medicare without border", tooltip: "Print Medicare", icon: :print
  action :dde_link, text: "DDE", tooltip: "Access DDE"
  action :private_ins_invoice, text: "Private", tooltip: "Print Private", icon: :print
  action :view_reconcile_claim, text: "", tooltip: "View Claim Details", icon: :view_details
  action :send_claims_for_test, text: "Download Batch File", tooltip: "Send As Test"
  action :ready_for_esend, text: "Send Electronically and Mark Sent", tooltip: "Send Electronic Transmission and Mark Sent"
  action :print_claim_and_mark_sent, text: "Print Claim and Mark Sent", tooltip: "Print Claim and Mark Sent"
  action :mark_as_sent, text: "Mark Sent", tooltip: "Mark Sent"
  action :send_claims_for_test_xml, text: "Test XML", tooltip: "Send As Test XML"
  action :send_claims_for_prod_xml, text: "Send XML", tooltip: "Send XML"
  action :edit_claim, text: "Edit Esend Failed Claims", tooltip: "Edit Esend failed claims", icon: ''
  action :undo_claims, text: "Undo", tooltip: "Undo Claims"
  action :print_from_edi, text: "EDI to UB04", tooltip: "EDI to UB04"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
       grid = this;
      this.actions.editClaim.hide();
      this.actions.viewReconcileClaim.disable();
      this.getView().on('refresh', function(){
        this.addRowColor();
      }, this);

      this.on('itemdblclick',function(view, record, e){
        this.setInvoiceId({invoice_id : record.get('id')}, function(result){
          this.onViewReconcileClaim({});
        }, this);
      }, this);

      this.on('itemclick',function(view, record){
        this.checkStatusToDisableButtons({invoice_id : record.get('id')}, function(result){
          this.actions.del.setDisabled(!result[0]);
        }, this);
      });

      this.on('itemclick',function(view, record){
        this.checkStatusToDisableEditClaimButton({invoice_id : record.get('id')}, function(result){
          if(result){
             this.actions.editClaim.show();
          } else {
            this.actions.editClaim.hide();
          }

        }, this);
      });

      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.viewReconcileClaim.setDisabled(selModel.getCount() == 0);
        this.checkUniqPayerInvoices({records: this.selectedRecordIds}, function(res){
          var menu = Ext.ComponentQuery.query('#menu')[0];
          if(res[0]){
            menu.setDisabled(res[0]);
            this.actions.undoClaims.setDisabled(res[0]);
            Ext.MessageBox.alert('Warning', 'Select Same insurance Company invoice(s).');
          }else {
            this.actions.readyForEsend.setDisabled(res[1]);
            this.actions.undoClaims.setDisabled(res[0]);
            menu.setDisabled(res[0]);
          }
        }, this);
        this.checkStatusToHideMarkSentButton({records: this.selectedRecordIds}, function(result){
          if(result){
            this.actions.markAsSent.show();
            this.actions.printClaimAndMarkSent.show();
            this.actions.readyForEsend.show();
          } else {
            this.actions.markAsSent.hide();
            this.actions.printClaimAndMarkSent.hide();
            this.actions.readyForEsend.hide();
          }
        }, this);
      }, this);

      //HACK:: After reloading a store we are setting the same url for the purpose of after load complete download will start
      this.store.on('load', function(){
        if(this.url) window.location = this.url;
          this.url = null;
        }, this);
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      g = this;
      var printButton = Ext.ComponentQuery.query('#print_menu')[0];
      this.getSelectionModel().on('selectionchange', function(selModel){
        if(printButton != undefined){
          printButton.setDisabled(selModel.getCount() > 1);
        }
      }, this);
    }
  JS

  js_method :on_edit_claim, <<-JS
    function(){
      if(this.selectedRecordIds.length > 0){
        this.changeClaimStatusToDraft({records: this.selectedRecordIds}, function(res){
          this.afterActionResetSelection();

        }, this)
      } else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }


    }
  JS

  js_method :on_mark_as_sent, <<-JS
    function(){
      this.loadNetzkeComponent({name: "date_component", callback: function(w){
        w.show();
      }});
    }
  JS

  js_method :on_send_claims_for_test, <<-JS
    function(){
      this.testMode = true;
      this.xml = false;
      this.ub04Print = false;
      this.onSendClaims();
    }
  JS

  js_method :on_ready_for_esend, <<-JS
    function(){
      this.onSendClaimsElectronically();
    }
  JS

  js_method :on_send_claims_for_test_xml, <<-JS
    function(){
      this.testMode = true;
      this.xml = true;
      this.ub04Print = false;
      this.onSendClaims();
    }
  JS

  js_method :on_send_claims_for_prod_xml, <<-JS
    function(){
      this.testMode = false;
      this.xml = true;
      this.ub04Print = false;
      this.onSendClaims();
    }
  JS

  js_method :on_print_from_edi, <<-JS
    function(){
      this.testMode = true;
      this.xml = false;
      this.ub04Print = true;
      this.onSendClaims();
    }
  JS

  js_method :on_send_claims, <<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.selectApprovedClaims({records: this.selectedRecordIds}, function(res){
          if(!res) {
            Ext.Msg.show({
              title: 'Send Error',
              msg: "We can't send the selected records.<br/> Only APPROVED claims can be processed.",
              buttons: Ext.Msg.OK,
              icon: Ext.Msg.ERROR,
            });
          } else {
            if (this.testMode) {
              this.sentInvoices(null);
            } else {
              this.loadNetzkeComponent({name: "sent_date_component", callback: function(w){
                w.show();
              }});
            }
          }
        },this);
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
    }
  JS

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

  js_method :print_invoice_after_sent, <<-JS
    function(w, date){
      var selModel = this.getSelectionModel();
      var recordId = selModel.selected.first().getId();
        this.printInvoiceDetails({invoice_id: recordId}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }
      },this);
      this.sendClaimSentDate(w, date);
      this.afterActionResetSelection();

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

  js_method :on_send_claims_electronically, <<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.selectApprovedClaims({records: this.selectedRecordIds}, function(res){
          if(!res) {
            Ext.Msg.show({
              title: 'Send Error',
              msg: "We can't send the selected records.<br/> Only APPROVED claims can be processed.",
              buttons: Ext.Msg.OK,
              icon: Ext.Msg.ERROR,
            });
          } else if (this.selectedRecordIds.length > 0) {
                this.claimsReadyForSent({records: this.selectedRecordIds}, function(res){
                this.afterActionResetSelection();
               });
             }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
       },this);
    }
    }
  JS

  js_method :on_undo_claims, <<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.unSentSelectedInvoices({records: this.selectedRecordIds}, function(res){
          if(!res)
            Ext.Msg.show({
              title: 'Undo Sent Error',
              msg: "Only sent claims can undo.",
              buttons: Ext.Msg.OK,
              icon: Ext.Msg.ERROR,
            });
          else
            this.afterActionResetSelection();
        },this);
      }else {
        Ext.MessageBox.alert("Status", "No claim(s) selected to process.");
      }
    }
  JS

  js_method :sent_invoices, <<-JS
    function(date){
      this.sendSelectedInvoices({records: this.selectedRecordIds, sent_date: date, test_mode: this.testMode, xml: this.xml, ub04_print: this.ub04Print}, function(res){
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
        } else if (res[2]) {
          this.loadNetzkeComponent({name: "edi_to_pdf_component", callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.closeRes === "ok") {
                this.store.load();
              }
            }, this);
          }});
        } else if (res[3]) {
          this.url = window.location.protocol + "//" + window.location.host + res[1] + "?target=_blank";
          this.doNotRememberAfterStoreReload = true;
          this.store.load();
          this.doNotRememberAfterStoreReload = false;
        }else if (!res[3]){
          Ext.Msg.show({
            title: 'Send Error',
            msg: "Select same insurance company invoices.",
            buttons: Ext.Msg.OK,
            icon: Ext.Msg.ERROR,
          });
        }
      },this);
    }
  JS

  component :edi_to_pdf_component do
    {
        class_name: "LaunchReport",
        title: "Invoice(s)",
        width: '80%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

  js_method :after_action_reset_selection, <<-JS
    function(){
       this.doNotRememberAfterStoreReload = true;
       this.store.load();
       this.doNotRememberAfterStoreReload = false;
    }
  JS


  js_method :add_row_color, <<-JS
    function(){
      Ext.each(this.store.data.items, function(item, index){
				if (item.data.aged == "true"){
				var invoiceGrid = $('#app__invoices-body tr:nth-child(' + (index + 2) + ')')[0];
        var patientClaims = $('#app__p_profile__netzke_0__netzke_0__invoices__invoice_list-body tr:nth-child(' + (index + 2) + ')')[0];
        if (invoiceGrid)
          invoiceGrid.style.color = 'red';
        else if (patientClaims)
          patientClaims.style.color = 'red';
      }
			});
		}
  JS

  endpoint :check_status_to_disable_buttons do |params|
    component_session[:invoice_id] = params[:invoice_id]
    result = [false, false]
    invoice = Invoice.find_by_id(params[:invoice_id])
    if invoice
      result[0] = invoice.draft?
      result[1] = (invoice.sent? or invoice.partially_paid?)
    end
    {:set_result => result }
  end

  endpoint :check_status_to_hide_mark_sent_button do |params|
    result = false
    approved_claims = Invoice.claims_status_scope(params[:records], 'A')
    if approved_claims
      result = approved_claims.count > 0
    end
    {:set_result => result }
  end


  endpoint :check_status_to_disable_edit_claim_button do |params|
    result = false
    invoice = Invoice.find_by_id(params[:invoice_id])
    if invoice
      result = invoice.esend_failed?
    end
    {:set_result => result }
  end

  js_method :render_invoice_amount,<<-JS
    function(value){
      return Ext.util.Format.usMoney(value);
    }
  JS

  js_method :on_view_reconcile_claim, <<-JS
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

  component :popup_window do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimReconciliationGridExplorer",
        params: {invoice_id: component_session[:invoice_id]},
        width: '90%',
        height: '90%',
        title: "Claim Details"
    }
  end

  component :sent_date_component do
    {
        class_name: "PopupWindow",
        comp_name: "ClaimSentDate",
        params: {invoice_list_item_id: config[:item_id]},
        width: "20%",
        height: "18%",
        title: "Claim Sent Date"
    }
  end

  js_method :on_print_invoice, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      if (selModel.getCount() != 1) {
        return;
      }
      var recordId = selModel.selected.first().getId();
      this.printInvoiceDetails({invoice_id: recordId}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }
      },this);
    }
  JS

  js_method :on_print_invoice_wot_border, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      if (selModel.getCount() != 1) {
        return;
      }
      var recordId = selModel.selected.first().getId();
      this.printInvoiceDetailsWithoutBorder({invoice_id: recordId}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }
      },this);
    }
  JS


  js_method :on_dde_link, <<-JS
    function(){
      Ext.Msg.show({
         title: 'DDE Screen',
         msg: "Launch Internet Explorer <br> Copy and paste the below URL <br> https://portal.visionshareinc.com/",
         buttons: Ext.Msg.OK,
         icon: Ext.Msg.INFO,
         viewConfig: {enableTextSelection: true},
         readOnly: false
      });
    }
  JS

  js_method :on_private_ins_invoice, <<-JS
    function(){
      var selModel = this.getSelectionModel();
      if (selModel.getCount() != 1) {
        return;
      }
      var recordId = selModel.selected.first().getId();
      this.printPrivateInvoiceDetails({invoice_id: recordId}, function(res){
        if(res){
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        }
      },this);
    }
  JS

  endpoint :change_claim_status_to_draft do |params|
    esend_failed_claims = Invoice.claims_status_scope(params[:records], 'F')
    Invoice.change_claim_status_as_draft(esend_failed_claims)
    {set_result: true}
  end

  endpoint :select_approved_claims do |params|
    approved_claims = Invoice.claims_status_scope(params[:records], 'A')
    {set_result: approved_claims.size > 0 }
  end


  endpoint :claims_ready_for_sent do |params|
    list = Invoice.claims_status_scope(params[:records], 'A')
    Invoice.mark_claims_as_esend(list)
    {:set_result => list.size > 0}
  end

  endpoint :send_selected_invoices do |params|
    approved_claims = Invoice.claims_status_scope(params[:records], 'A')
    claims_insurance_count  = approved_claims.map(&:payer).uniq.size
    same_ins_claims = true
    url = nil
    errors_present = false
    if(claims_insurance_count == 1)
      url, errors_present = Invoice.get_edi_url_and_claims_mark_as_sent(approved_claims, params)
    else
      same_ins_claims = false
    end

    if errors_present == false and params[:ub04_print]
      session[:pre_generated_file_name] = url
      component_session[:title] = "Invoice(s)"
      component_session[:report_url] = "reports/pre_generated"
    end
    {:set_result => [errors_present, url, params[:ub04_print], same_ins_claims]}
  end

  endpoint :check_uniq_payer_invoices do |params|
    claims_insurances = Invoice.org_scope.where(['id in (?)',params[:records]]).map(&:payer).uniq
    res = [claims_insurances.count > 1, (claims_insurances.count  == 1 and claims_insurances.first.company_code != 'MEDICARE')]
    {set_result: res}
  end

  endpoint :un_sent_selected_invoices do |params|
    list = Invoice.claims_status_scope(params[:records], 'S')
    Invoice.mark_claims_as_undo(list)
    {:set_result => list.size > 0}
  end

  endpoint :print_private_invoice_details do |params|
    invoice_id = params[:invoice_id]
    invoice = Invoice.find(invoice_id.to_i)
    d = ReportDataSource::Cms1500Print.new(invoice)
    res = d.to_pdf
    session[:pre_generated_file_name] = res
    component_session[:title] = "Private Insurance Invoice #: #{invoice.invoice_number}"
    component_session[:report_url] = "/reports/pre_generated"
    {set_result: res}
  end

  endpoint :print_invoice_details do |params|
    invoice_id = params[:invoice_id]
    invoice = Invoice.find(invoice_id.to_i)
    ds = ReportDataSource::MedicareClaim.new(invoice)
    res = ds.to_pdf
    session[:pre_generated_file_name] = res
    component_session[:title] = "Invoice #: #{invoice.invoice_number}"
    component_session[:report_url] = "/reports/invoice/Invoice_#{invoice.invoice_number}.pdf"
    {set_result: res}
  end

  endpoint :print_invoice_details_without_border do |params|
    invoice_id = params[:invoice_id]
    invoice = Invoice.find(invoice_id.to_i)
    ds = ReportDataSource::MedicareClaim.new(invoice)
    res = ds.to_pdf(false)
    session[:pre_generated_file_name] = res
    component_session[:title] = "Invoice #: #{invoice.invoice_number}"
    component_session[:report_url] = "/reports/invoice/Invoice_#{invoice.invoice_number}.pdf"
    {set_result: res}
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

  js_method :on_del, <<-JS
   function() {
      if (this.getSelectionModel().selected.length == 1){
        var recordIds = [];
        this.getSelectionModel().selected.each(function(r){
          recordIds.push(r.getId());
        });
        this.canDeleteInvoice({record_id: Ext.encode(recordIds[0])}, function(res){
          if(res){
            Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
              if (btn == 'yes') {
                if (recordIds.length > 0){
                  if (!this.deleteMask) this.deleteMask = new Ext.LoadMask(this.getEl(), {msg: this.deleteMaskMsg});
                  this.deleteMask.show();
                  // call API
                  this.deleteData({records: Ext.encode(recordIds)}, function(){
                    this.store.load();
                    this.up('panel').down('#invoice_details_grid').store.load();
                    this.up('panel').down('#invoice_payment_list_grid').store.load();
                    this.deleteMask.hide();
                  }, this);
                }
              }
            }, this);
          } else {
            Ext.MessageBox.alert("Status", "Invoice cannot be deleted.<br/><br/> <b>Reasons:</b><br/>Invoice contains details.");
          }
        }, this);
      } else {
        Ext.MessageBox.alert("Status", "Select one invoice to delete.");
      }
    }
  JS

  js_method :send_claim_sent_date, <<-JS
    function(w, date){
      var rec = this.getSelectionModel().selected.items[0];
      this.updateSentDate({record_id: rec.getId(), sent_date: date }, function(result) {
        if(result){
          w.close();
          this.store.load();
        } else {
          Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
        }
      }, this);
    }
  JS

  endpoint :update_sent_date do |params|
    invoice = Invoice.org_scope.find(params[:record_id])
    invoice.sent_date = params[:sent_date].to_date
    debug_log invoice.inspect
    invoice.mark_as_sent! if invoice.may_mark_as_sent?
    {:set_result => true}
  end

  endpoint :can_delete_invoice do |params|
    record_id = ActiveSupport::JSON.decode(params[:record_id])
    invoice = Invoice.find(record_id)
    res = invoice.draft?
    {:set_result => res}
  end

  endpoint :set_invoice_id do |params|
    component_session[:invoice_id] = params[:invoice_id]
    {}
  end


end