class PatientSchedulesWithPatientDetails < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        header: false,
        layout: :border,
        items: [:patient_info.component,
                :schedules.component]
    )
  end

  component :patient_info do
    {
        class_name: "Netzke::Basepack::Panel",
        region: :north,
        layout: :fit,
        header: false,
        items: [
            {class_name: "PatientInfo",
             treatment_id: config[:treatment_id],
             treatment_request_id: config[:treatment_request_id],
             margin: 10,
             frame: false,
             header: false,
             border: false
            }
        ]
    }
  end

  component :schedules do
    {
        class_name: "Schedules",
        region: :center,
        treatment_id: config[:treatment_id],
        episode_id: config[:episode_id],
        header: false,
    }
  end

end