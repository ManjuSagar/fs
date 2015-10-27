class InvoicePaymentForm < Mahaswami::FormPanel

  def configuration
    c = super
    component_session[:invoice_id] ||= c[:invoice_id]
    c.merge(
      model: "InvoicePayment",
      item_id: :invoice_payment_form,
      layout: :border,
      items: [
          {
              header: false,
              border: false,
              region: :north,
              items: [
                  {name: :payment_date, field_label: "Date"},
                  {name: :payment_amount, field_label: "Amount", xtype: :numberfield, minValue: 0, hideTrigger: true, keyNavEnabled: false, mouseWheelEnabled: false},
                  {name: :payment_description, field_label: "Details", width: 400},
                  {
                      xtype: 'radiogroup',
                      fieldLabel: "Payment For",
                      labelAlign: 'left',
                      item_id: :payment_for,
                      columns: 1,
                      items: [
                          {
                              xtype: 'radiofield',
                              name: "payment_for",
                              inputValue: "0",
                              checked: true,
                              field_label: "",
                              boxLabel: 'All Outstanding items.'
                          },
                          {
                              xtype: 'radiofield',
                              name: "payment_for",
                              inputValue: "1",
                              field_label: "",
                              boxLabel: 'Selected items.'
                          }
                      ]
                  }
              ]
          },
          :invoice_details.component(
              region: :center
          )
      ]
    )
  end

  component :invoice_details do
    {
      class_name: "InvoiceDetailsForPayment",
      invoice_id: component_session[:invoice_id],
      item_id: :invoice_details_for_payment,
      scope: {invoice_id: component_session[:invoice_id], receivable_status: "I"}
    }
  end

  js_method :on_apply,<<-JS
    function(){
      var formFields = this.getForm().getValues();
      if(formFields.payment_for == '0'){
        this.createInvoicePayment({form_fields: formFields}, function(result){
          Ext.ComponentQuery.query('#invoice_list_grid')[0].store.load();
          Ext.ComponentQuery.query('#invoice_details_grid')[0].store.load();
          Ext.ComponentQuery.query('#invoice_payment_list_grid')[0].store.load();
          this.up('window').close();
        }, this);
      }else{
        var invoiceDetails = this.down('#invoice_details_for_payment');
        records = invoiceDetails.store.getUpdatedRecords();
        if(records.length == 0){
          Ext.MessageBox.alert("Status", "Please select atleast one item for payment.")
        }else{
          invoiceDetails.onApply();
        }
      };
    }
  JS

  endpoint :create_invoice_payment do |params|
    invoice = Invoice.find(config[:invoice_id])
    payment_date = Date.strptime(params[:form_fields][:payment_date], "%m/%d/%Y")
    payment_description = params[:form_fields][:payment_description]
    receivables = invoice.receivables.select{|r| r.invoiced? }
    payment_amount = params[:form_fields][:payment_amount]
    invoice_payment = InvoicePayment.new(:invoice => invoice, :payer => invoice.payer, :org => invoice.org,
                                         :payment_date => payment_date, :payment_amount => payment_amount)
    invoice_payment.payment_reference_number = invoice_payment.next_payment_reference_number(invoice.id)
    invoice_payment.receivables << receivables
    invoice_payment.save!
    {:set_result => true}
  end

end