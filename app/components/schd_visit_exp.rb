class SchdVisitExp < Mahaswami::Panel

  def configuration
    s = super
    component_session[:episode_id] = s[:episode_id]
    component_session[:treatment_id] = s[:treatment_id]
    s.merge(
        layout: "border",
        item_id: "schedule_visit_explorer_#{component_session[:episode_id]}",
        header: false,
        items: [
            :schedules.component,
            :visits.component
        ]
    )
  end

  component :schedules do
    {
        region: :center,
        width: "61%",
        class_name: "Schedules",
        treatment_id: config[:treatment_id],
        episode_id: config[:episode_id]
    }
  end

  component :visits do
    {
        class_name: "Netzke::Basepack::TabPanel",
        region: :east,
        collapsible: true,
        collapsed: true,
        item_id: "batch_and_schedule_visits_#{component_session[:episode_id]}",
        title: "Visits",
        width: "39%",
        items: [
            {
                class_name: "BatchVisits",
                episode_id: component_session[:episode_id],
                treatment_id: component_session[:treatment_id],
                parent_id: component_session[:treatment_id],
                episode_based: true
            },
            {
                class_name: "SchdVisits",
                episode_id: component_session[:episode_id],
                treatment_id: component_session[:treatment_id],
                parent_id: component_session[:treatment_id],
                episode_based: true
            },
            {
              class_name: "ScheduleAuthorizationTrackings",
              episode_id: component_session[:episode_id],
              treatment_id: component_session[:treatment_id],
              title: "Authorizations"
            }
        ]
    }
  end

end