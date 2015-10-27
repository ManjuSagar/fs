class PatientProfile < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
    config[:treatment_id] = component_session[:treatment_id]
  end


  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    @treatment = PatientTreatment.find(component_session[:treatment_id])
    s.merge(
        layout: :border,
        title: "Patient Profile",
        height: 900,
        items: [{class_name: "Netzke::Basepack::Panel", region: :west, border: false, item_id: "navigation_container", split: true, tools: [:refresh], header: true, collapsible: true, title: "Patient Chart",
                 layout: :fit, frame: true, margin: 0,
                 items:[    {
                                class_name: "PatientProfileTree",
                                header: false,
                                border: false,
                                treatment_id: @treatment.id
                            }
                 ]
                },
                {region: :center, border: false, layout: :border, items:

                    [
                        {
                            region: 'north',
                            collapsible: false,
                            frame: true,
                            height: "200",
                            margin: 0,
                            layout: :fit,
                            items: [:patient_container.component]
                        },
                        {
                            region: :center,
                            item_id: :main_panel,
                            frame: true,
                            border: true,
                            margin: 0,
                            layout: :fit,
                            items: [:patient_dashboard.component]
                        }
                    ]
                }]
    )
  end

  component :patient_container do
    {
        class_name: "Netzke::Basepack::Panel",
        layout: :fit,
        header: false,
        items: [
            {class_name: "PatientInfo",
             treatment_id: @treatment.id,
             margin: 10,
             frame: false,
             header: false,
             border: false
            }
        ]
    }
  end

  component :patient_dashboard do
    {
        class_name: "PatientDashboard",
        treatment_id: @treatment.id
    }
  end


  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.createAudit({});
    }
  JS

  endpoint :create_audit do |params|
    @treatment.user_viewing_changed_attr_value = @treatment.treatment_status
    @treatment.treatment_status = "Z"
    @treatment.audit_comment = "User View"
    @treatment.save!
    {}
  end
end
