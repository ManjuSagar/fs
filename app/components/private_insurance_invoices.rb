class PrivateInsuranceInvoices < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        header: false,
        border: false,
        layout: :fit,
        items: [{
                    xtype: :tabpanel,
                    item_id: 'private_invoices',
                    items: [:pending_billing_invoice.component, :pending_payment_invoice.component, :received_payment_invoice.component],
                    title: "Invoices",
                    tools: [
                        {
                            xtype: 'tool',
                            type: 'refresh',
                            item_id: :refresh_tool
                        }
                    ]
                }
        ]
    )
  end

  component :pending_billing_invoice do
    {
        class_name: "PendingBillingInvoices",
        title: "Pending Billing"
    }
  end

  component :pending_payment_invoice do
    {
        class_name: "PendingPaymentInvoices",
        title: "Pending Payment",
    }
  end

  component :received_payment_invoice do
    {
        class_name: "ReceivedPaymentInvoices",
        title: "Received Payment",
    }
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var privateInvoices = Ext.ComponentQuery.query('#private_invoices')[0];
      privateInvoices.on('tabchange', function(tabPanel, tab){
        tab.store.reload();
      });
    }
  JS
  
  js_method :after_render, <<JS
   function(){
      this.callParent();
      var refreshTool = this.down("#refresh_tool");
      refreshTool.on('click', function(){
        var grids = this.query('grid');
        Ext.each(grids, function(grid, index){
          grid.store.load();
        }, this);
       },this);
    }
JS

end