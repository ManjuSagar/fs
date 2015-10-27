class ClaimSentDate < Netzke::Basepack::Panel

  def configuration
    s = super
    show_print_options = s[:params][:show_printing_options]
    s.merge(
        title: false,
        header: false,
        item_id: 'sent_date',
        bbar: ['->',:ok.action, :cancel.action ],
        items:
            (show_print_options ? [class_name: 'PrivateInsurancePrintSelection', item_id: 'pvtPrint',bbar: show_print_options, header: false] : [])+
            [{name: :sent_date, field_label: "Sent Date", xtype: "datefield", item_id: :sent_date,  margin: 5, allowBlank: false,
                value: Date.current, dateFormat: 'Y-m-d', labelWidth: 80}]
    )
  end

  action :ok, text: "", tooltip: "Ok", icon: :save_new
  action :cancel, text: "", tooltip: "Cancel", icon: :cancel_new

  js_method :on_cancel, <<-JS
    function(){
      this.up('window').close();
    }
  JS

  js_method :on_ok, <<-JS
    function(){
      var g = Ext.ComponentQuery.query("#" + this.invoiceListItemId)[0];
      var w = this.up('window');
      var date = this.down('#sent_date').getValue();
      var printOptions = w.down('#pvtPrint');
	  if(printOptions){	
      	documents = printOptions.down('#documents').getValue();
      	invoices = printOptions.down('#invoices').getValue();
      	forms = printOptions.down('#forms').getValue();
	  }		
      var xml = false;
      if (date == null)
        Ext.MessageBox.alert("Status", "Sent Date can't be blank.");
      else if (printOptions && documents == false && invoices == false && forms == false){
        Ext.MessageBox.alert("Status", "Select at least one option(s).");
      }else{
        if(this.markAsSent == true){
         g.sendClaimSentDate(w, date);
		}
        else if(this.ediDownload == true){
          g.ediFileDownload(w,date);
        }else if(this.invoiceListItemId == 'private_insurance_pending_billing' && this.printAndMarkAsSent == true){
          g.printInvoiceAfterSent(w, date, documents, invoices, forms);
        }else if( this.printAndMarkAsSent == true){
          g.printInvoiceAfterSent(w, date);
        }else{
          g.sentInvoices(date);
        }
        w.close();
	    }
    }
  JS


end