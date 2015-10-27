class ReportsFilterForm < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        layout: {
            type: 'vbox',
            align: :stretch,
        },
        title: s[:title],
        defaults: {
            labelAlign: "right",
            labelWidth: 120
        },
        fbar: [:ok.action]
    )
  end

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

end