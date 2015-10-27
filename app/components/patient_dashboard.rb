class PatientDashboard < Mahaswami::Panel
  def initialize(conf = {}, parent = nil)
    super
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id])
    @episode = @treatment.treatment_episodes.where(id: component_session[:episode_id]).first if component_session[:episode_id]
    @patient = @treatment.patient
    s.merge(
    {
        header: false,
        border: false,
        layout: :border,
        items: [
                  {
                      region: 'north',
                      height: 130,
                      header:false,
                      margin:5,
                      class_name: "Netzke::Basepack::TabPanel",
                      items: [{class_name: "PatientBasicInfo", treatment_id: @treatment.id},
                              {class_name: "PatientNetworkInfo", treatment_id: @treatment.id, episode_id: component_session[:episode_id]},
                              {class_name: "PatientFinancialInfo", treatment_id: @treatment.id}]
                  },
                  {
                      region: 'center',
                      baseCls: 'x-box',
                      margin:5,
                      border: false,
                      layout: {
                          align: 'stretch',
                          type: 'hbox'
                      },
                      title: '',
                      items: [{layout: :border, border: false, flex: 1, frame: false, items:[:task_info.component]},
                              {layout: :border, border: false, flex: 1, frame: false, items:[:billing_info.component]}]
                  },
                  {
                      region: 'south',
                      baseCls: 'x-box',
                      margin:5,
                      height: "40%",
                      border: false,
                      layout: {
                          align: 'stretch',
                          type: 'hbox'
                      },
                      title: '',
                      items: [:patient_vitals_charts.component,
                              :adl_info.component]
                  }
        ]
    })
  end

  component :task_info do
    {
        class_name: "Netzke::Basepack::Panel",
        border: false,
        header: false,
        layout: :fit,
        region: :center,
        frame: true,
        autoScroll: true,
        :items => [{
          xtype:'panel', 
          border: false,
          margin: 0,
          layout: {
            type: 'table',
            columns: 2,
            table_attrs: {
                style: {width: "100%", "font-size" => "14px", "border-collapse" => "collapse"}
            },
            td_attrs: {
                style: {
                    padding: "1px"
                    
                }
            }
         },
         :items => [{
            
                xtype: 'label',
                margin: 6,
                colspan: 2,
                html: '<b>Tasks</b></br>'
            }
           ]
           }
      ]
      }     
    
  end
  component :billing_info do
    {
        class_name: "Netzke::Basepack::Panel",
        border: false,
        header: false,
        layout: :fit,
        region: :center,
        frame: true,
        autoScroll: true,
        :items => [
        {
          xtype:'panel', 
          border: false,
          margin: 0,
          layout: {
            type: 'table',
            columns: 4,
            table_attrs: {
                style: {width: "100%", "font-size" => "14px"}
            },
            td_attrs: {
                style: {
                    padding: "1px"
                    
                }
            }
         },
         :items => [{
                xtype: 'label',
                colspan: 4,
                margin: 6,
                html: '<b>Billing</b>'
            }
           ]
         }
        ] 
    }
    
  end

  component :patient_vitals_charts do
    {
        class_name: "PatientVitalsCharts",
        border: false,
        treatment_id: @treatment.id,
        episode_id: (@episode.id if @episode)
    }
  end

  component :adl_info do
    {
        class_name: "AdlInfo",
        border: false,
        treatment_id: @treatment.id,
        episode_id: (@episode.id if @episode)
    }
  end

end
