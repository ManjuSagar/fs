class Grouper < Netzke::Base
  js_base_class "grouper"
  def configuration
    s = super
    params = s[:strong_default_attrs]
    s.merge(
         data: params,
         border: false,
         layout: 'fit',
         width: "80%",
         height: 150,
         header: false,
         margin: '10px'
    )
  end

js_method :after_render, <<-JS
  function(){
    this.callParent();
    this.drawStuff();
  }
JS


end