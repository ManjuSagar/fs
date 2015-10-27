class ReceivableList < Mahaswami::GridPanel

  def configuration
    s  = super
    is_editable = false
    if s[:invoice_id]
      is_editable = Invoice.find(s[:invoice_id]).draft? ? true : false
    end
      s.merge(
      model: "Receivable",
      editOnDblClick: false,
      columns: [{name: :receivable_date, editable: false, label: "Date", width: 100},
                {name: :purpose, width: 180, editable: false},
                {name: :receivable_amount, label: "Billed Amount", align: "right", editable: is_editable, renderer: :formattedAmount, width: 100},
                {name: :receivable_paid_amount, label: "Paid Amount", align: "right", editable: is_editable, renderer: :formattedAmount, width: 100},
                {name: :receivable_status, label: "Status", editable: false, getter: lambda{|r| r.receivable_status.to_s.titleize}, width: 120},
                {name: :hcpcs_code, label: "HCPCS", width: 80, editable: is_editable},
                {name: :revenue_code, label: "Rev Code", width: 70, editable: is_editable},
                {name: :service_units, label: "Service Units", align: 'center', editable: is_editable},
                {name: :invoice_payment__payment_reference_number, label: "Payment Ref. #", editable: false, width: 120},
                action_column(s[:item_id])
      ],
      scope: (s[:scope] || :org_scope)
    )
  end

  def default_bbar
    [:add_in_form.action, :edit.action, :apply.action, :del.action]
  end

  def default_context_menu
    [:del.action]
  end
  action :add_in_form, text: "", tooltip: "Add Item"
  add_form_config class_name: "ReceivableForm", mode: :add
  add_form_window_config width: 500, title: "Add Item"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('beforeedit', function( editor, e, eOpts ){
        if(e.record.get('receivable_status') != "Invoiced"){
          return false;
        }
      }, this);
      this.on('itemclick',function(view, record){
        this.checkStatusToEditAndDelete({receivable_id : record.get('id')}, function(result){
          this.actions.edit.setDisabled(!result);
          this.actions.del.setDisabled(!result);
        }, this);
      });

    }
  JS

  js_method :refresh_invoice_grid,<<-JS
    function(r){
      var grid_scope = this;
      var res = grid_scope.store.data.length;
      grid_scope.store.load();
      if(res == 1){
        this.up("#invoices_grid").down('#invoice_payment_list_grid').store.load();
        this.up("#invoices_grid").down('#invoice_list_grid').store.load();
      }
    }
  JS

  def delete_data_endpoint(params)
    super
    {:refresh_invoice_grid => true}
  end

  endpoint :check_status_to_edit_and_delete do |params|
    receivable = Receivable.find(params[:receivable_id])
    result = (receivable.invoiced? and receivable.invoice.draft?)
    {:set_result => result}
  end

end