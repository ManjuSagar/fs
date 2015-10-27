class EpisodesListExplorer < Netzke::Basepack::Panel

  def configuration
    s = super
    component_session[:treatment_status_arr] ||= ['P', 'A']
    s.merge({
                title: "Patients",
                layout: :border,
                item_id: :episodes_list_explorer,
                items: [
                    :search_panel.component,
                    :episodes_list.component
                ]
            })
  end

  component :search_panel do
    {
        class_name: "Mahaswami::Panel",
        region: :north,
        border: false,
        header: false,
        layout: :hbox,
        items: [
            {
                class_name: "PatientsListFilter",
                border: false,
                header: false,
                item_id: :patients_list_filter,
                flex: 1,
                treatment_status_arr: component_session[:treatment_status_arr]
            },
            {
                class_name: "PatientsListButtons",
                flex: 1,
                border: false,
                header: false
            }
        ]
    }
  end

  component :episodes_list do
    {
        class_name: "EpisodesList",
        region: :center,
        item_id: :episodes_list,
        border: false,
        header: false,
        show_not_admitted: display_not_admitted_records?,
        show_pending_patient_and_referral: display_pending_patients_and_referral?,
        scope: episodes_list_scope(component_session[:treatment_status_arr])
    }
  end

  def display_pending_patients_and_referral?
    return true unless component_session[:treatment_status_arr]
    component_session[:treatment_status_arr].include?('P')
  end

  def display_not_admitted_records?
    return false unless component_session[:treatment_status_arr]
    component_session[:treatment_status_arr].include?('N')
  end

  def episodes_list_scope(treatment_status_arr)
    treatment_status_arr = (treatment_status_arr and treatment_status_arr.include?("display_none"))? [] : treatment_status_arr
    treatment_status_arr = ['P', 'A'] if treatment_status_arr.nil?
    #Its patch added for scope: it will skip word 'scope_with_params' and uses filter_based_on_treatment_status as scope name
    # and remaining items as parameters
    ["scope_with_params,denormalize_filter"] + treatment_status_arr
  end

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      //this.resetSessionContext();
      checkBoxList = this.down("#patients_list_filter").query("checkboxfield");
      Ext.each(checkBoxList, function(checkBox, index){
        checkBox.on('change', function(ele){
          var treatmentStatus = checkBox.up('checkboxgroup').getValue().treatment_status;
          this.setTreatmentStatus({treatment_status: treatmentStatus});
        }, this);
      }, this);
    }
  JS

  endpoint :reset_session_context do |params|
    component_session[:treatment_status_arr] = ['P', 'A']
    {}
  end

  endpoint :set_treatment_status do |params|
    treatment_status_arr = if params[:treatment_status].nil?
                             ["display_none"]
                           elsif params[:treatment_status].is_a? String
                             [params[:treatment_status]]
                           else
                             params[:treatment_status]
                           end
    component_session[:treatment_status_arr] = treatment_status_arr
    {refresh_grids: true}
  end

  js_method :refresh_grids,<<-JS
    function(){
      this.down("#episodes_list").store.load();
    }
  JS

end