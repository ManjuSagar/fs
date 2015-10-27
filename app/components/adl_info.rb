class AdlInfo < Mahaswami::Panel

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
                   html: '<span style=font-size:14px;font-weight:bold>ADL\'s</span>',
                   region: :north,
                   height: 10
               },
               {class_name: "Netzke::Basepack::TabPanel",
                header: false,
                border: false,
                region: :center,
                tab_position: :top,
                active_tab: 0,
                items:[
                    {class_name: "AdlChart", type: "Bathing", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Toileting", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Shopping", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Transfers", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Bed Mobility", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Medication", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Feeding", treatment_id: @treatment.id, episode_id: @episode.id},
                    {class_name: "AdlChart", type: "Ambulation", treatment_id: @treatment.id, episode_id: @episode.id}
                ]
               }
        ]
    )
  end


end