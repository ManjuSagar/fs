class UnverifiedMedicationFilterForm < ReportsFilterForm

  def configuration
    s = super
    s.merge(
        items: [
            {
                xtype: 'radiogroup',
                field_label: "Filter By",
                name: 'filter_by_group',
                margin: "10px",
                columns: 3,
                items: [
                    {xtype: :radiofield, boxLabel: "MD", item_id: "md_filter", name: 'filter_by', input_value: "MD", checked: true},
                    {xtype: :radiofield, boxLabel: "Field Staff", item_id: "staff", input_value: "ST", name: 'filter_by'},
                    {xtype: :radiofield, boxLabel: "Patient", item_id: "patient", input_value: "PA", name: 'filter_by'},
                ]
            },
            {
                xtype: :combo,
                margin: "10px",
                store: Physician.physician_list_store,
                item_id: 'search_by_md',
                field_label: 'MD'
            },
            {
                xtype: :combo,
                margin: "10px",
                store: Org.current.field_staff_store,
                item_id: 'search_by_staff',
                disabled: true,
                field_label: 'Field Staff'
            },
            {
                xtype: :combo,
                margin: "10px",
                store: Patient.patient_list_store,
                field_label: "Patient",
                item_id: 'search_by_patient',
                disabled: true
            }

        ]
    )
  end

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      this.mdFilter = this.down('#md_filter');
      this.staffFilter = this.down('#staff');
      this.patientFilter = this.down('#patient');
      this.mdSearch = this.down("#search_by_md");
      this.staffSearch = this.down("#search_by_staff");
      this.patientSearch = this.down("#search_by_patient");
      this.filterBy = this.down('[name=filter_by_group]');

      this.filterBy.on('change', function(){
        var filterValue = this.filterBy.lastValue.filter_by;
        this.enableOrDisableFields(filterValue);
      },this);
    }
  JS

  js_method :enable_or_disable_fields,<<-JS
    function(value){
      this.staffSearch.setDisabled(value != "ST");
      this.staffSearch.reset();
      this.patientSearch.setDisabled(value != "PA");
      this.patientSearch.reset();
      this.mdSearch.setDisabled(value != "MD");
      this.mdSearch.reset();
    }
  JS

  js_method :on_ok,<<-JS
    function(){
      this.setLoading(true);
      this.reportFilterOptions({field_staff_id: this.staffSearch.getValue(), patient_id: this.patientSearch.getValue(),
                           md_id: this.mdSearch.getValue(), filter_by: this.filterBy.lastValue.filter_by},function(res){
        this.setLoading(false);
        if(res)
          this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
        else
          Ext.MessageBox.alert("Status", "No Records Found.");
      }, this);
    }
  JS

  endpoint :report_filter_options do |options|
    unverified_medication = UnverifiedMedicationsReportDataSource.new options
    if unverified_medication.empty?
      {:set_result => false}
    else
      res = unverified_medication.to_pdf
      session[:pre_generated_file_name] = res
      {:set_result => res}
    end
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "Unverified Medications Report",
        width: '90%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

end