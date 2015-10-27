class LaunchReport < Netzke::Basepack::Window
  def configuration
    s = super
    s.merge(
        layout: 'fit',
        items: [{
                  xtype: "component",
                  id: 'myIframe',
                  autoEl: {
                    tag: "iframe",
                    href: ""
                  }
        }]
    )
  end

  js_method :after_render, <<-JS
    function() {
      this.callParent();
      reportUrl = window.location.protocol + "//" + window.location.host + this.url;
      Ext.getDom('myIframe').src = reportUrl;
    }
  JS

end