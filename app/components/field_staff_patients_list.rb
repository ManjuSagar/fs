class FieldStaffPatientsList < Mahaswami::GridPanel
  def configuration
    s = super
    s.merge(
        model: "PatientTreatment",
        title: "Patients",
        edit_on_dbl_click: false,
        columns: [
            {name: :patient__full_name, label: "Patient Name", width: "18%", editable: false},
            {name: :patient__street_address, label: "Patient Address", width: "18%", editable: false},
            {name: :patient__city, label: "City", width: "12%", editable: false},
            {name: :patient__zip_code, label: "Zip Code", width: "6%", editable: false},
            {name: :patient__phone_number, label: "Phone", width: "10%", editable: false},
            {name: :primary_physician_name, label: "Physician", width: "15%", editable: false},
            {name: :patient__primary_insurance_company_name, label: "Insurance Company Name", width: "15%", editable: false},
            {name: :episode_id, hidden: true, getter: lambda{|t| (t.treatment_episodes.size > 0) ? t.treatment_episodes.last.id : nil}},

        ],
    scope: ["scope_with_params,os_field_staff_scope"] + [s[:field_staff_id]]
    )

  end

  def default_bbar
	  []
  end

  def default_context_menu
  	[]
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
       this.on('celldblclick', function( view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
          this.fireEvent('itemdblclick', view, record, e);
          return false;
       });
      this.on('itemdblclick', function(view, record, e){
        this.onViewPatientChart();
      }, this);
    }
  JS

  js_method :on_view_patient_chart, <<-JS
    function(){
      var episodeId = this.getSelectionModel().selected.items[0].get('episode_id');
      var app = Ext.ComponentQuery.query('#app')[0];
      this.getPchartRequiredInfo({episode_id: episodeId}, function(res){
        if(res){
          app.setContext(res, function(){
            launchComponent("PProfile", "p_profile");
            this.up('window').close();
          }, this);
        }
      }, this);
    }
  JS

  endpoint :get_pchart_required_info do |params|
    episode = TreatmentEpisode.org_scope.find(params[:episode_id])
    treatment = episode.treatment
    res = if treatment.present? and episode.present?
            {record_type: 1, treatment_id: treatment.id, episode_id: episode.id, patient_id: treatment.patient_id,
                   treatment_request_id: treatment.treatment_request_id}
          else
            false
          end
    {set_result: res}
  end

end