class PatientVitalsCharts < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id])
    @episode =  TreatmentEpisode.find(component_session[:episode_id])
    @patient = @treatment.patient
    s.merge(
        layout: :border, flex: 1, frame: true, header:false,
        items:[{
                   xtype: 'label',
                   colspan: 4,
                   margin: 6,
                   html: '<span style=font-size:14px;font-weight:bold>Vitals</span>',
                   region: :north,
                   height: 10
               },
            {class_name: "Netzke::Basepack::TabPanel",
             header: false,
             border: false,
             region: :center,
             tab_position: :top,
             active_tab: 0,
             items: [{class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "BP", minimum_y_value: VitalBp::MIN_VALID_VALUE, maximum_y_value: VitalBp::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "RR", minimum_y_value: VitalRr::MIN_VALID_VALUE, maximum_y_value: VitalRr::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "HR", minimum_y_value: VitalHr::MIN_VALID_VALUE, maximum_y_value: VitalHr::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "FBS", minimum_y_value: VitalFastingBloodSugar::MIN_VALID_VALUE, maximum_y_value: VitalFastingBloodSugar::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "RBS", minimum_y_value: VitalRandomBloodSugar::MIN_VALID_VALUE, maximum_y_value: VitalRandomBloodSugar::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "O2", minimum_y_value: VitalOxygen::MIN_VALID_VALUE, maximum_y_value: VitalOxygen::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "TEMP", minimum_y_value: VitalTemp::MIN_VALID_VALUE, maximum_y_value: VitalTemp::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "WEIGHT", minimum_y_value: VitalWeight::MIN_VALID_VALUE, maximum_y_value: VitalWeight::MAX_VALUE_VALUE},
                     {class_name: 'VitalChart', treatment_id: @treatment.id, episode_id: @episode.id, vital_parameter: "PAIN", minimum_y_value: VitalPain::MIN_VALID_VALUE, maximum_y_value: VitalPain::MAX_VALUE_VALUE},
                  ]
            }
        ]
    )
  end

end