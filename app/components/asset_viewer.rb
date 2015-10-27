class AssetViewer < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
  end

  def configuration
    s = super
    component_session[:url] = s[:url] if s[:url]
    s.merge({
        layout: :fit,
        height: 200,
        items: [{
             xtype: "component",
             id: 'myIframe',
             autoEl: {
                 tag: "iframe",
                 href: ""
             },
         }]
    })
  end

  js_method :after_render, <<-JS
    function() {
      this.callParent();
      this.getUrl({}, function(url) {
          Ext.getDom('myIframe').src = url;
      });
    }
  JS

  endpoint :get_url do |params|
    {:set_result => component_session[:url]}
  end
end
