class VisitListReportForm < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        title: "Visit List",
        autoScroll: true,
        item_id: "visit_list_report_form",
        items: [
            {
                xtype: "form",
                border: false,
                layout: {type: 'vbox', align: "stretch"},
                items: [
                    {
                        xtype: 'checkboxgroup',
                        field_label: 'Status',
                        label_align: "right",
                        allow_blank: false,
                        columns: 5,
                        items: [
                            {
                                boxLabel: 'PE',
                                item_id: 'pending',
                                xtype: :checkboxfield,
                                input_value: "P",
                                name: 'treatment_status_filter'
                            },{
                                boxLabel: 'AC',
                                item_id: 'active',
                                xtype: :checkboxfield,
                                checked: true,
                                input_value: "A",
                                name: 'treatment_status_filter'
                            },{
                                boxLabel: 'HD',
                                item_id: 'held',
                                xtype: :checkboxfield,
                                name: 'treatment_status_filter',
                                input_value: "O"
                            },{
                                boxLabel: 'DC',
                                item_id: 'discharge',
                                xtype: :checkboxfield,
                                input_value: "D",
                                name: 'treatment_status_filter'
                            }
                        ]
                    },{
                        border: false,
                        header: false,
                        layout: {type: 'vbox', align: "stretch"},
                        items: [
                            {
                                field_label: "From Date",
                                item_id: 'from_date',
                                xtype: :datefield,
                                allow_blank: false,
                                name: 'from_date',
                                label_align: "right",
                                margin: 5
                            },{
                                field_label: "To Date",
                                item_id: 'to_date',
                                xtype: :datefield,
                                name: 'to_date',
                                allow_blank: false,
                                label_align: "right",
                                margin: 5
                            }
                        ]
                    },{
                        xtype: 'checkboxgroup',
                        field_label: 'Discipline',
                        label_align: "right",
                        columns: 5,
                        items: discipline_list
                    },{
                        xtype: 'checkboxgroup',
                        field_label: 'Visit Status',
                        label_align: "right",
                        columns: 5,
                        items: [
                            {
                                boxLabel: "Scheduled",
                                item_id: "scheduled",
                                xtype: :checkboxfield,
                                input_value: "Scheduled",
                                name: "visit_status"
                            },
                            {  boxLabel: "Pending",
                                item_id: "pending",
                                xtype: :checkboxfield,
                                input_value: "Pending",
                                name: "visit_status"
                            },{
                                boxLabel: "Completed",
                                item_id: "completed",
                                xtype: :checkboxfield,
                                input_value: "Completed",
                                name: "visit_status"
                            }
                        ]
                    },{
                        xtype: :combo,
                        margin: "5px",
                        name: "patient_id",
                        store: Patient.patients_list,
                        field_label: "Patient",
                        item_id: 'filter_by_patient'
                    },{
                        xtype: :combo,
                        margin: "5px",
                        name: "field_staff_id",
                        store: FieldStaff.field_staff_list(true),
                        item_id: 'filter_by_fs',
                        field_label: 'Field Staff'
                    },{
                        xtype: :combo,
                        margin: "5px",
                        name: "insurance_company_id",
                        store: InsuranceCompany.insurance_company_list,
                        item_id: 'filter_by_insurance',
                        field_label: 'Insurance'
                    },{
                        xtype: :combo,
                        margin: "5px",
                        name: "visit_type_id",
                        store: VisitType.visit_type_list,
                        item_id: 'filter_by_visit_type',
                        field_label: 'Visit Type'
                    }
                ]
            }
        ],
        fbar: [:ok.action]
    )
  end

  def discipline_list
    Discipline.all.collect do |d|
        {
            boxLabel: d.discipline_code,
            item_id: d.discipline_code.downcase,
            xtype: :checkboxfield,
            input_value: d.id,
            name: "disciplines"
        }
    end
  end

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  js_method :on_ok,<<-JS
    function(){
      var form = this.down("form");
      var fromDate = this.down("#from_date");
      var toDate = this.down("#to_date");
      var values = form.getValues();
      var msg = "";
      if (fromDate.isValid() && toDate.isValid()) {
        this.setLoading(true);
        this.getVisitList(values, function(res){
          this.setLoading(false);
          if(res)
            this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
          else
            Ext.MessageBox.alert("Status", "No Records Found.");
        }, this);
      } else {
        if (fromDate.isValid() == false) {
          msg += "From date is invalid.<br/>"
        }
        if (toDate.isValid() == false) {
          msg += "To date is invalid."
        }
        Ext.MessageBox.alert("Status", msg);
      }
    }
  JS

  endpoint :get_visit_list do |params|
    data_source = ReportDataSource::VisitListReport.new params
    if data_source.visits.empty?
      {:set_result => false}
    else
      res = data_source.to_pdf
      session[:pre_generated_file_name] = res
      {:set_result => res}
    end
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "Visit List",
        width: '85%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      this.statusLastValue = 'A';
      this.treatment_status = this.down("checkboxgroup[fieldLabel=Status]");

      this.treatment_status.on('change', function(ele){
        var treatment_status_arr = this.treatment_status.getValue().treatment_status_filter;
        if(treatment_status_arr == undefined){
          this.treatment_status.setValue({treatment_status_filter: this.statusLastValue});
          Ext.MessageBox.alert("Alert", "At least one status should be selected.");
        } else
          this.statusLastValue = treatment_status_arr;
      }, this);
    }
  JS

end