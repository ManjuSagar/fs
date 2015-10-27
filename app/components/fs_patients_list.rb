class FsPatientsList < Mahaswami::GridPanel
  def configuration
    s = super
    s.merge(
        title: "Patients",
        model: 'PatientTreatment',
        edit_on_dbl_click: false,
        item_id: :patients_list,
        bbar: [],
        context_menu: [],
        title: (User.current.is_a? FieldStaff) ? "Patients" : "Treatments",
        columns: [{name: :patient__patient_reference, label: "MR#", editable: false, width: "4%"}]+
                  ((User.current.is_a? FieldStaff) ? [{name: :health_agency_name, label: "Agency", editable: false, width: "13%"}] : []) +
                  [{name: :to_s, label: "Patient", editable: false, scope: :org_scope, width: "10%"},
                  {name: :patient__primary_insurance_company_name, label: "Insurance", editable: false, width: "12%"},
                  {name: :certification_period, label: "Episode", editable: false, width: "11%"}]+
                  [{name: :treatment_status, label: "Status", editable: false, :getter => lambda{|l| PatientTreatment::STATUS_DISPLAY[l.treatment_status]}, width: "4%"},
                  {name: :patient__phone_number, label: "Mobile", editable: false, width: "9%"},
                  {name: :patient__phone_number_2, label: "Home", editable: false, width: "9%"},
                  {name: :patient__street_address, label: "Address", editable: false, width: "12%"},
                  {name: :patient__city, label: "City", editable: false, width: "9%"},
                  {name: :patient__zip_code, label: "Zip", editable: false, width: "5%"},
                  {name: :episode_id, hidden: true, getter: lambda{|t| (t.treatment_episodes.size > 0) ? t.treatment_episodes.last.id : nil}},
                  {name: :patient_id, hidden: true}
        ],

    )
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
    var selectedRow = this.getSelectionModel().selected.items[0];
    var treatment_id = selectedRow.get('id');
    var episodeId = selectedRow.get('episode_id');
    var patientId = selectedRow.get('patient_id');
    this.up("#app").setContext({treatment_id: treatment_id, episode_id: episodeId, patient_id: patientId}, function(){
      this.up("#app").loadNetzkeComponent({name: 'p_profile', container: this.up("#main_panel")});
    }, this);
    }
  JS

end

