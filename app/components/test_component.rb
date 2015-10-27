class TestComponent < Mahaswami::Panel

  # Initial layout of the app.
  # <tt>status_bar_config</tt>, <tt>menu_bar_config</tt>, and <tt>main_panel_config</tt> are defined in SimpleApp.
  def configuration
    super.merge({
        items:[
            :task_info.component
        ]
    })
  end

  component :task_info do
    {
        class_name: "Netzke::Basepack::Panel",
        header: false,
        border: false,
        region: :center,
        html: "God is Great"
    }
  end
end
