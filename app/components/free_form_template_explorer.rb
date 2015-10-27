class FreeFormTemplateExplorer < Netzke::Basepack::BorderLayoutPanel
  include Mahaswami::NetzkeBase
  def configuration
    super.merge(
      :items => [
        :free_form_component.component(
          :region => :center,
          :title => "Free Form",
          :height => 300,
          :split => true
        ),
        :free_form_details_component.component(
          :region => :south,
          :title => "Details",
          :height => 100,
          :split => true
        )
      ]
    )
  end

  component :free_form_component do
    {
      :class_name => "FreeFormTemplateList",
      :scope => {:org_id => Org.current.id},
      bbar: [],
      context_menu: [],
      header: false
    }
  end

  component :free_form_details_component do
    {
      :class_name => "FreeFormTemplateDetails"
    }
  end

end