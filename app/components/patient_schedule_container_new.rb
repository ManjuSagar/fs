class PatientScheduleContainerNew < Mahaswami::Panel
  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    s.merge(
        title: "Schedule: #{treatment.patient}",
        border: false,
        layout: "fit",
        items: [:patient_schedules.component]
    )
  end

  component :patient_schedules do
    {
        class_name: "PatientSchedulesNew",
        treatment_id: config[:treatment_id],
        episode_id: config[:episode_id],
        header: false,
    }
  end

  def episode_list
    return unless treatment
    treatment.treatment_episodes.collect{|e|[e.id, e.certification_period]}
  end

  def treatment
    @treatment ||= PatientTreatment.find(component_session[:treatment_id]) if component_session[:treatment_id]
  end

end