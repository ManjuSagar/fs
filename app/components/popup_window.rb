class PopupWindow < Netzke::Basepack::Window

  def initialize(conf={}, parent_id = nil)
    self.class.component :custom_component do
      {class_name: conf[:comp_name], params: conf[:params]}.merge(conf[:params])
    end
    super
  end

  def configuration
    s = super
    s.merge(
        layout: 'fit',
        items: [
            :custom_component.component
        ]
    )
  end

end