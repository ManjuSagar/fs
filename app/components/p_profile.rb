class PProfile < Mahaswami::Panel

  def initialize(conf = {}, parent = nil)
    super
  end


  def configuration
    s = super
    @treatment = s[:treatment_id] ? PatientTreatment.find(s[:treatment_id]) : nil
    s.merge(
        border: false,
        layout: :border,
        title: "Patient Profile",
        height: 900,
        item_id: :patient_profile,
        items: [:p_chart.component,
                {region: :center, border: false, layout: :border, items:

                    [
                        {
                            region: 'north',
                            collapsible: false,
                            frame: true,
                            height: "200",
                            border: false,
                            margin: 0,
                            layout: :fit,
                            items: [:patient_container.component]
                        },
                        {
                            region: :center,
                            item_id: :main_panel,
                            frame: true,
                            border: false,
                            margin: 0,
                            layout: :fit,
                            items: inital_components(s[:record_type])
                        }
                    ]
                }]
    )
  end

  def inital_components(record_type)
    if record_type == 2
      [:patient_edit_form.component]
    elsif record_type == 3
      [:referral_edit_form.component]
    else
      [:patient_dashboard.component]
    end
  end

  component :p_chart do
    {
        region: :west,
        border: false,
        split: true,
        tools: [:refresh],
        header: true,
        collapsible: true,
        title: "Patient Chart",
        layout: :fit,
        frame: true,
        margin: 0,
        class_name: "PChart",
        treatment_id: config[:treatment_id],
        episode_id: config[:episode_id],
        patient_id: config[:patient_id],
        record_type: config[:record_type],
        treatment_request_id: config[:treatment_request_id]
    }
  end

  component :patient_container do
    {
        class_name: "Mahaswami::Panel",
        layout: :fit,
        header: false,
        border: false,
        items: [
            {class_name: "PatientInfo",
             treatment_id: config[:treatment_id],
             episode_id: config[:episode_id],
             patient_id: config[:patient_id],
             treatment_request_id: config[:treatment_request_id],
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
        treatment_id: config[:treatment_id],
        episode_id: config[:episode_id]
    }
  end

  component :patient_edit_form do
    {
        class_name: "PatientEditForm",
        record_id: config[:patient_id],
        title: "Patient Information",
        bbar: ["->", :delete_patient.action, :apply.action]
    }
  end

  component :referral_edit_form do
    {
        class_name: "ReferralEditForm",
        record_id: config[:treatment_request_id],
        title: "Referral"
    }
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.createAudit({patient_id: this.patientId});
    }
  JS

  endpoint :create_audit do |params|
    p = Patient.find(params[:patient_id])
    return {} if p.nil?
    p.user_viewing_changed_attr_value = p.current_sign_in_at
    # For logging user view audit log
    p.current_sign_in_at = Time.now
    p.audit_comment = "User View"
    p.save!
    {}
  end
end
