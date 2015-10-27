class ConsltntProfExplr < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        title: "Profile",
        border: false,
        frame: false,
        autoScroll: true,
        item_id: :consultant_profile_explorer,
        items: [
            :consltng_compny_prof.component,
            {
                xtype: :fieldset,
                header: false,
                frame: false,
                border: false,
                componentCls: 'consultant-profile-explore-without-border',
                collapsible: true,
                title: "Current Clients",
                items: [
                    :current_clients.component,
                ]
            },
            {
                xtype: :fieldset,
                header: false,
                frame: false,
                border: false,
                collapsible: true,
                componentCls: 'consultant-profile-explore-without-border',
                title: "Pending Clients",
                items: [
                    :pending_clients.component,
                ]
            }
        ]
    )
  end

  component :consltng_compny_prof do
    {
      class_name: "ConsltngCompnyProf"
    }
  end

  component :current_clients do
    {
        class_name: "CurntClnts",
        bbar: [],
        header: false,
        context_menu: [],
        height: 200,
        item_id: :current_client_list,
        scope: :active_health_agencies
    }
  end

  component :pending_clients do
    {
        class_name: "PendngClnts",
        bbar: [],
        header: false,
        context_menu: [],
        margin: '0 100 0 100',
        item_id: :pending_client_list,
        height: 200,
        scope: :pending_health_agencies
    }
  end
end