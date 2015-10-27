class PrivateInsurancePrintSelection < Netzke::Basepack::Panel

  def configuration
    s = super
    s.merge(
         title: false,
         header: false,
         border: false,
         itemId: 'pvtPrint',
         bbar: s[:bbar] ? false : ['->',:ok.action, :cancel.action ],
         items:[
             {
                 xtype: :panel,
                 border: 0,
                 layout: {
                     align: 'stretch',
                     type: 'hbox'
                 },
                 items:[
                     {
                        xtype: :checkboxgroup,
                        layout: {
                             align: 'stretch',
                             type: 'vbox'
                        },
                        items: [
                            {
                                xtype: :checkboxfield,
                                name: 'Invoices',
                                boxLabel: 'Invoices',
                                inputValue: '1',
                                itemId: 'invoices'
                            },
                            {
                                xtype: :checkboxfield,
                                name: 'Documents',
                                boxLabel: 'Documents',
                                inputValue: '2',
                                itemId: 'documents'
                            },
                            {
                                xtype: :checkboxfield,
                                name: 'Forms',
                                boxLabel: 'Forms',
                                inputValue: '3',
                                itemId: 'forms'
                            }
                        ]
                     }
                 ]
             }
         ]
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
      documents = this.down('#documents').getValue();
      invoices = this.down('#invoices').getValue();
      forms = this.down('#forms').getValue();
      claims = g.selectedRecordIds;
      var status = 'D';
      if(this.pendingPaymentsPrint){status = 'S'}
      else if(this.receivedPaymentsPrint){status = 'R'}
       if (documents == false && invoices == false && forms == false)
         Ext.MessageBox.alert("Status", "Select at least one option(s).");
       else {
          w.close();
          g.setLoading(true);
         this.printInvoiceDetails({doc_required: documents, form_required: forms, inv_required: invoices,
               selected_claims: claims, grid: g.itemId, status: status},function(res){
                if(res){
                  this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
                  w.close();
                }else{
                if(documents == true && invoices == false && forms == false){
                  Ext.MessageBox.alert("Status", "No Documents to print.");
                }else if (documents == false && invoices == false && forms == true){
                  Ext.MessageBox.alert("Status", "No Form type selected to print.");
                }else if (documents == true && invoices == false && forms == true){
                  Ext.MessageBox.alert("Status", "No Documents and No Form type selected to print.");
                }
         }
        g.setLoading(false);
        },this);
       }
    }
  JS

  endpoint :print_invoice_details do |params|
    p = PrivateInsuranceInvoice.new
    url = p.print_claims(params)
    if url
      session[:pre_generated_file_name] = url
      component_session[:title] = "Invoice"
      component_session[:report_url] = "/reports/pre_generated"
    end
    {set_result: url.present? }
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

end


