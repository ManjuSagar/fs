class InvoiceDetailsForPayment < Mahaswami::GridPanel

  def configuration
    c = super
    c.merge(
      model: "Receivable",
      editOnDblClick: false,
      title: "Invoice Details",
      height: 200,
      itemId: :invoice_details_for_payment,
      enable_pagination: false,
      autoScroll: true,
      columns: [
          {name: :selected, label: "", editable: true},
          {name: :receivable_date, label: "Date", editable: false, width: 80},
          {name: :purpose, width: 160, editable: false},
          {name: :receivable_amount, label: "Amount", align: "right", editable: false, renderer: :render_receivable_amount},
          {name: :receivable_status, label: "Status", editable: false, getter: lambda{|r| r.receivable_status.to_s.titleize}}
      ]
    )
  end

  def default_bbar
    []
  end

  def default_context_menu
    []
  end

  js_method :render_receivable_amount,<<-JS
    function(value){
      return value.toFixed(2);
    }
  JS

  def post_data_endpoint(params)
    invoice = Invoice.find(config[:invoice_id])
    modified_data = ActiveSupport::JSON.decode(params["#{:update}d_records"]) if params["#{:update}d_records"]
    selected_receivables = modified_data.collect{|data| invoice.receivables.find(data["id"]) }.select{|r| r.invoiced? }
    receivable_ids = selected_receivables.map(&:id)
    {:set_payment_amount_and_receivable_ids => receivable_ids}
  end

  js_method :set_payment_amount_and_receivable_ids,<<-JS
    function(result){
      var paymentForm = this.up('#invoice_payment_form');
      this.createInvoicePayment({form_fields: paymentForm.getForm().getValues(), receivable_ids: result}, function(result){
        Ext.ComponentQuery.query('#invoice_list_grid')[0].store.load();
        Ext.ComponentQuery.query('#invoice_details_grid')[0].store.load();
        Ext.ComponentQuery.query('#invoice_payment_list_grid')[0].store.load();
        this.up('window').close();
      }, this);
    }
  JS

  endpoint :create_invoice_payment do |params|
    invoice = Invoice.find(config[:invoice_id])
    payment_date = Date.strptime(params[:form_fields][:payment_date], "%m/%d/%Y")
    payment_description = params[:form_fields][:payment_description]
    payment_amount = params[:form_fields][:payment_amount]
    receivables = params[:receivable_ids].collect{|r_id| invoice.receivables.find(r_id) }
    invoice_payment = InvoicePayment.new(:invoice => invoice, :payer => invoice.payer, :org => invoice.org,
                      :payment_date => payment_date, :payment_amount => payment_amount)
    invoice_payment.payment_reference_number = invoice_payment.next_payment_reference_number(invoice.id)
    invoice_payment.receivables << receivables
    invoice_payment.save!
    {:set_result => true}
  end


end