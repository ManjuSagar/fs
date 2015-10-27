class OasisDocuments < Mahaswami::Panel
  def configuration
    s = super
    s.merge(
        header: false,
        border: false,
        layout: :fit,
        items: [{
                    xtype: :tabpanel,
                    items: [:medicare.component,:private.component],
                    title: "OASIS Export",
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

  component :private do
    {
        class_name: "PrivateInsuranceExports",
        scope: :private_scope,
        title: "Private"
    }
  end

  component :medicare do
    {
        class_name: "MedicareInsuranceExports",
        scope: :medicare_scope,
        title: "Medicare"
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
