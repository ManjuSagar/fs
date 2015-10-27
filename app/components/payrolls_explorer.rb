class PayrollsExplorer < Mahaswami::Panel
  #include Mahaswami::NetzkeBase
  def configuration
    s = super
    s.merge(
        header: false,
        border: false,
        layout: :fit,
        items: [{
                    xtype: :tabpanel,
                    items: [:pending_payrolls.component,
                    :processed_payrolls.component],
                    title: "Payroll",
                    tools: [
                        {
                            xtype: 'tool',
                            type: 'refresh',
                            item_id: :refresh_tool
                        }
                    ],
                }
        ]
    )
  end

  component :pending_payrolls do
    {
        class_name: "PendingPayrolls"
    }
  end

  component :processed_payrolls do
    {
        class_name: "ProcessedPayrolls"
    }
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var refreshTool = this.down("#refresh_tool");
      refreshTool.on('click', function(){
        var grids = this.query('grid');
        Ext.each(grids, function(grid, index){
          grid.store.load();
        }, this);
      }, this);
    }
  JS

end