class ReportsFilterOptions < Mahaswami::Panel
  def configuration
    s = super
    s.merge(
      layout: {
        type: 'vbox',
        align: :stretch,
      },
      title: s[:title],
      defaults: {
        labelAlign: "right",
        labelWidth: 120
      },
      items: [

        {
          xtype: 'checkboxgroup',
          field_label: 'Status',
          margin: "10px",
          columns: 5,
          items: [
            { boxLabel: 'AC', item_id: 'active', xtype: :checkboxfield, checked: true, field_label: "", input_value: "A", name:"treatment_status_filter"}]+
            (s[:missing_frequency] ? [{ boxLabel: 'PE', item_id: 'pending', xtype: :checkboxfield, input_value: "P", field_label: "", name:"treatment_status_filter" }] : [])+
            [
              { boxLabel: 'DC', item_id: 'discharge', xtype: :checkboxfield, input_value: "D", field_label: "", name:"treatment_status_filter" },
              { boxLabel: 'HD', item_id: 'held', xtype: :checkboxfield, input_value: "O", field_label: "", name:"treatment_status_filter" }
            ]
        },
        {
          xtype: 'radiogroup',
          field_label: "FilterBy",
          name: 'filter_by_group',
          margin: "10px",
          columns: 4,
          items: [
            {xtype:'radiofield', boxLabel: 'Field Staff', item_id: 'field_staff', name: 'filter_by', input_value: "FS"},
            {xtype:'radiofield', width: 200, boxLabel: 'Staffing Company', item_id: 'staffing_company', input_value: "SC", name: 'filter_by'},
            {xtype:'radiofield', boxLabel: 'Patient', item_id: 'patient', input_value: "PATIENT", name: 'filter_by'},
            {xtype:'radiofield', boxLabel: 'All', item_id: 'all', input_value: "All", name: 'filter_by', checked: true}
          ]
        },
        {
          xtype: :combo,
          margin: "10px",
          store: FieldStaff.field_staff_list(s[:missing_frequency]),
          item_id: 'search_by_fs',
          disabled: true,
          field_label: 'Field Staff'
        },
        {
          xtype: :combo,
          margin: "10px",
          store: StaffingCompany.org_scope.collect{|sc| [sc.id, sc.full_name]},
          item_id: 'search_by_sc',
          disabled: true,
          field_label: 'Staffing Company'
        },
        {
          xtype: :combo,
          margin: "10px",
          store: Patient.patients_list(['A']),
          field_label: "Patient",
          item_id: 'search_by_patient',
          disabled: true
        }

      ] ,
      fbar: [:ok.action]
    )
  end
  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      this.statusLastValue = 'A';
      this.fs = Ext.ComponentQuery.query('#field_staff')[0];
      this.sc = Ext.ComponentQuery.query('#staffing_company')[0];
      this.fs_and_sc = Ext.ComponentQuery.query('#all')[0];
      this.search_by_fs = Ext.ComponentQuery.query("#search_by_fs")[0];
      this.search_by_sc = Ext.ComponentQuery.query("#search_by_sc")[0];
      this.search_by_patient = Ext.ComponentQuery.query("#search_by_patient")[0];
      this.filterBy = Ext.ComponentQuery.query('[name=filter_by_group]')[0]
      this.treatment_status = Ext.ComponentQuery.query("checkboxgroup[fieldLabel=Status]")[0];
      this.filterBy.on('change', function(){
        var filterValue = this.filterBy.lastValue.filter_by;
        if(filterValue == 'All'){
          var treatment_status_arr = this.treatment_status.getValue().treatment_status_filter
          this.search_by_fs.setDisabled(true)
          this.search_by_fs.reset();
          this.search_by_sc.setDisabled(true)
          this.search_by_sc.reset();
          this.search_by_patient.setDisabled(true)
          this.search_by_patient.reset();
        }else if(filterValue == 'FS'){
          this.search_by_fs.setDisabled(false)
          this.search_by_sc.setDisabled(true);
          this.search_by_sc.reset();
          this.search_by_patient.setDisabled(true)
          this.search_by_patient.reset();
        }else  if(filterValue == 'SC'){
          this.search_by_fs.setDisabled(true);
          this.search_by_sc.setDisabled(false)
          this.search_by_fs.reset();
          this.search_by_patient.setDisabled(true)
          this.search_by_patient.reset();
        }else if(filterValue == 'PATIENT'){
          this.search_by_fs.setDisabled(true);
          this.search_by_fs.reset();
          this.search_by_sc.setDisabled(true);
          this.search_by_sc.reset();
          this.search_by_patient.setDisabled(false);
        }
        this.search_by_patient.reset();
      },this);
      this.treatment_status.on('change', function(ele){
        var treatment_status_arr = this.treatment_status.getValue().treatment_status_filter;
        this.search_by_fs.reset();
        this.search_by_sc.reset();
        this.search_by_patient.reset();
        if(treatment_status_arr == undefined){
          this.treatment_status.setValue({treatment_status_filter: this.statusLastValue});
          Ext.MessageBox.alert("Alert", "Select atleast one status.");
        } else
          this.statusLastValue = treatment_status_arr;
        this.patientList({treatment_status_arr: treatment_status_arr}, function(res){
          this.search_by_patient.bindStore(res);
      },this);
    }, this);

    }
  JS


  endpoint :patient_list do |params|
    treatment_status_arr = params[:treatment_status_arr]
    {:set_result => Patient.patients_list(treatment_status_arr)}
  end

  js_method :on_ok,<<-JS
    function(){
      var treatment_status_arr = this.treatment_status.getValue().treatment_status_filter;
      this.setLoading(true);
      this.reportFilterOptions({field_staff_id: this.search_by_fs.getValue(), staffing_company_id: this.search_by_sc.getValue(), patient_id: this.search_by_patient.getValue(),
                           treatment_status_arr: treatment_status_arr},function(res){
        this.setLoading(false);
        if(res)
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        else
          Ext.MessageBox.alert("Status", "No Records Found.");
        }, this);
      }
  JS

  endpoint :report_filter_options do |options|
    options.merge!({missing_frequency: config[:missing_frequency]})
    res = Patient.report_url(options)
    session[:pre_generated_file_name] = res
    {:set_result => res}
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: (config[:missing_frequency] ? "Missing Frequencies" : "Therapy Re Evaluations"),
        width: '60%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

end