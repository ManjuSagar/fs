class RcDcPlanningFilterForm < Mahaswami::Panel

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
                    { boxLabel: 'PE', item_id: 'pending', xtype: :checkboxfield, input_value: "P", field_label: "", name:"treatment_status_filter" },
                    { boxLabel: 'AC', item_id: 'active', xtype: :checkboxfield, input_value: "A", field_label: "", name:"treatment_status_filter", checked: true},
                    { boxLabel: 'HD', item_id: 'held', xtype: :checkboxfield, input_value: "O", field_label: "", name:"treatment_status_filter" }
                ]
            },
            {
                xtype: 'radiogroup',
                field_label: "Filter By",
                name: 'filter_by_group',
                margin: "10px",
                columns: 4,
                items: [
                    {xtype: :radiofield, boxLabel: "Current Month", name: "filter_by", input_value: "CM", checked: true},
                    {xtype: :radiofield, boxLabel: "Previous Month", name: "filter_by", input_value: "PM"},
                    {xtype: :radiofield, boxLabel: "Next Month", name: "filter_by", input_value: "NM"},
                    {xtype: :radiofield, boxLabel: "Custom", name: "filter_by", input_value: "CU", item_id: :custom_dates}
                ]
            },
            {
                xtype: :label,
                text: "Episode End Date:",
                margin: "10 10 10 60",
            },
            {
                xtype: :datefield,
                margin: "10px",
                item_id: "episode_end_from_date",
                disabled: true,
                field_label: "From Date <span style='color:red'><b>*</b></span>"
            },
            {
                xtype: :datefield,
                margin: "10px",
                item_id: "episode_end_to_date",
                disabled: true,
                field_label: "To Date <span style='color:red'><b>*</b></span>"
            },
            {
                xtype: :combo,
                margin: "10px",
                store: Org.current.field_staff_store(true),
                item_id: 'search_by_cm',
                field_label: 'Case Manager'
            }

        ] ,
        fbar: [:ok.action]
    )
  end

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.statusLastValue = 'A';
      this.treatment_status = this.down("checkboxgroup[fieldLabel=Status]");
      this.filterBy = this.down("[name=filter_by_group]");
      this.customDates = this.down("#custom_dates");
      this.fromDate = this.down("#episode_end_from_date");
      this.toDate = this.down("#episode_end_to_date");
      this.caseManager = Ext.ComponentQuery.query("#search_by_cm")[0];
      this.customDates.on('change', function(ele){
        this.fromDate.setDisabled(!ele.checked);
        this.toDate.setDisabled(!ele.checked);
        this.fromDate.reset();
        this.toDate.reset();
      }, this);

      this.treatment_status.on('change', function(ele){
        var treatment_status_arr = this.treatment_status.getValue().treatment_status_filter;
        if(treatment_status_arr == undefined){
          this.treatment_status.setValue({treatment_status_filter: this.statusLastValue});
          Ext.MessageBox.alert("Alert", "Select atleast one status.");
        } else
          this.statusLastValue = treatment_status_arr;
      }, this);
    }
  JS

  js_method :on_ok,<<-JS
    function(){
      var filterBy = this.filterBy.lastValue.filter_by;
      if (filterBy == "CU") {
        if (this.fromDate.value == null && this.toDate.value == null){
          Ext.MessageBox.alert("Status", "From Date and To Date can't be blank.");
         }
        else if(this.fromDate.value == null){
          Ext.MessageBox.alert("Status", "From Date can't be blank.");
          }
        else if(this.toDate.value  == undefined){
          Ext.MessageBox.alert("Status", "To Date can't be blank.");
          }
        else if (new Date(this.fromDate.value) > new Date(this.toDate.value)){
          Ext.MessageBox.alert("Status", "Invalid date range.");
        } else if (!(this.fromDate.validateValue() && this.toDate.validateValue())) {
          Ext.MessageBox.alert("Status", "Invalid date(s)");
        } else {
          this.setValuesAndGenerateReport();
        }
      } else {
        this.setValuesAndGenerateReport();
      }

    }
  JS

  js_method :set_values_and_generate_report,<<-JS
    function(){
      var treatmentStatus = this.treatment_status.getValue().treatment_status_filter;
      var filterBy = this.filterBy.lastValue.filter_by;
      this.setLoading(true);
      this.reportFilterOptions({treatment_status_arr: treatmentStatus, filter_by: filterBy,
                from_date: this.fromDate.value, to_date: this.toDate.value,
                case_manager: this.caseManager.getValue()},function(res){
      this.setLoading(false);
      if(res)
        this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
      else
        Ext.MessageBox.alert("Status", "No Records Found.");
      }, this);
    }
  JS

  endpoint :report_filter_options do |options|
    episode = RcDcPlanReportDataSource.new options
    if episode.episode_empty?
      {:set_result => false}
    else
      res = episode.to_pdf
      session[:pre_generated_file_name] = res
      {:set_result => res}
    end
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "RC/DC Planning Report",
        width: '80%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

end