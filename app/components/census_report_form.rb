class CensusReportForm < Mahaswami::FormPanel
  def configuration
    s = super
    disp = Discipline.all
    s.merge(
        title: s[:title],
        autoScroll: true,
        model: 'ProspectivePaymentSystem::Icd9DiagnosticCode',
        item_id: "census_report",
        border: false,
        reports_page: s[:reports_page],
        layout: (s[:reports_page].present? ? {type: 'vbox', align: "stretch"} : nil),
        items: [
            {
                xtype: 'panel',
                layout: 'hbox',
                border: false,
                margin: '20 20 0 10',
                items: [
                    {
                        xtype: 'combobox',
                        field_label: 'Date',
                        store: group_by_date_source,
                        item_id: :filter_by_date_source
                    },
                    {
                        xtype: :datefield,
                        empty_text: 'From',
                        margin: '0 10 0 40',
                        item_id: :from_date
                    },
                    {
                        xtype: :datefield,
                        empty_text: 'To',
                        margin: '0 10 0 10',
                        item_id: :to_date
                    }
                ]
            },
            {
                xtype: 'panel',
                layout: 'hbox',
                border: false,
                margin: '20 20 0 10',
                items:[
                    {
                        xtype: 'combobox',
                        field_label: "Filter",
                        store: group_by_filter,
                        margin: '0 20 0 0',
                        item_id: 'group_by_filter'
                    },
                    {
                        xtype: 'combobox',
                        margin: '0 0 0 20',
                        item_id: 'group_by_filter_store',
                        store: empty_store
                    },
                    {
                        xtype: 'netzkeremotecombo',
                        width: 160,
                        parent_id: self.global_id,
                        field_label: '',
                        emptyText: 'Enter ICD Code',
                        item_id: "icd_9_code",
                        margin: '0 0 0 20',
                    },
                    {
                        xtype: 'datefield',
                        width: 160,
                        hidden: true,
                        item_id: :date_field_section,
                        margin: '0 0 0 20',
                    }
                ]
            },
            {
                xtype: 'combobox',
                field_label: "Group",
                store: group_by_filter,
                margin: '20 50 0 10',
                item_id: :group_by
            },
            {
                xtype: 'checkboxgroup',
                field_label: 'Status',
                label_align: "right",
                width: 300,
                margin: '20',
                columns: 5,
                items: [
                    { boxLabel: 'AC', item_id: 'active', xtype: :checkboxfield, input_value: "A"},
                    { boxLabel: 'PE', item_id: 'pending', xtype: :checkboxfield, input_value: "P"},
                    { boxLabel: 'NA', item_id: 'na', xtype: :checkboxfield, input_value: "N"},
                    { boxLabel: 'DC', item_id: 'discharge', xtype: :checkboxfield, input_value: "D"},
                    { boxLabel: 'HD', item_id: 'held', xtype: :checkboxfield, input_value: "O"},
                ]},
            {
                xtype: 'checkboxgroup',
                field_label: 'Discipline',
                label_align: "right",
                margin: '20',
                width: 300,
                columns: 5,
                items: disp.collect{|d| { boxLabel: d.discipline_code, xtype: :checkboxfield, input_value: d.id}}
            },
            {
                xtype: :checkboxfield,
                boxLabel: 'Print Unduplicated Census',
                item_id: 'unduplicated_census',
                input_value: "unduplicated",
                margin: '20 0 0 130'
            }
        ],
      fbar: (s[:reports_page].present? ? [:ok.action]: [])
    )
  end

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  action :apply, text: "", tooltip: "", item_id: :apply_action

  js_method :after_render, <<-JS
    function(){
     this.callParent();
     var g = this;
     var action = Ext.ComponentQuery.query('#apply_action')[0];
     var icd = Ext.ComponentQuery.query('#icd_9_code')[0];
     action.hide();
     icd.hide();
     var groupByFilter = Ext.ComponentQuery.query('#group_by_filter')[0];
     var FilterCombo = Ext.ComponentQuery.query('#group_by_filter_store')[0];
     var groupStore = Ext.ComponentQuery.query('#group_by')[0].store;
     var group = Ext.ComponentQuery.query('#group_by')[0];
     var dateField = Ext.ComponentQuery.query('#date_field_section')[0];

     Ext.each(this.query('combo'), function(cmp){
       cmp.setValue("");
     }, this);

     groupByFilter.on('change', function(ele){
        FilterCombo.setValue("");
        groupStore.removeAll();
        dateField.setValue("");
       if(ele.value == 'PrimaryDiagnosis'){
         FilterCombo.hide();
         icd.setValue("");
         icd.show();
         dateField.hide();
       }else if(ele.value == 'SOC'){
         dateField.show();
         FilterCombo.hide();
         icd.hide();
       }else{
         FilterCombo.show();
         icd.hide();
         dateField.hide();
         g.preFillComboValue({value: ele.value}, function(res){
           FilterCombo.store.removeAll();
           FilterCombo.store.add(res);
       },g);
       }
     groupStore.reload();
     group.setValue("");
     hash = {"Physician": 1, "InsuranceCompany": 2, "SOC": 3, "PrimaryDiagnosis": 4, "FieldStaff": 5, "Acuity": 6};
     r = hash[ele.value];
     groupStore.removeAt(r);
     });
    }
  JS

  js_method :on_ok,<<-JS
    function(){
      this.runCensusReport();
    }
  JS

  endpoint :pre_fill_combo_value do |params|
    value = params["value"]
    res = []
    case value
      when 'Acuity'
       res = Patient::ACUITY_TYPES
      when 'Physician'
        res = Physician.physician_agency_specific.collect{|x| [x.id, x.full_name]}
      when 'InsuranceCompany'
        res = InsuranceCompany.org_scope.collect{|x| [x.id, x.full_name]}
      when 'FieldStaff'
        res = FieldStaff.org_scope.collect{|x| [x.id, x.full_name]}
    end
    {:set_result => res}
  end

  js_method :run_census_report,<<-JS
    function(w, grid){
      var fromDate = Ext.ComponentQuery.query("#from_date")[0].value;
      var dateSource = Ext.ComponentQuery.query("#filter_by_date_source")[0].value;
      var toDate = Ext.ComponentQuery.query("#to_date")[0].value;
      var filterBy = Ext.ComponentQuery.query('#group_by_filter')[0].value;
      var icd_9_code = Ext.ComponentQuery.query('#icd_9_code')[0].value;
      var filterByName = Ext.ComponentQuery.query('#group_by_filter_store')[0].value;
      var dateFiltered = Ext.ComponentQuery.query('#date_field_section')[0].value;
      var groupBy = Ext.ComponentQuery.query('#group_by')[0].value;
      var disciplines = Ext.ComponentQuery.query("checkboxgroup[fieldLabel=Discipline]")[0].getValue();
      var unDuplicated = Ext.ComponentQuery.query("#unduplicated_census")[0].value;
      var treatment_status = Ext.ComponentQuery.query("checkboxgroup[fieldLabel=Status]")[0].getValue();
      var g = ((this.reportsPage == true) ? this : grid);
      filterValue = (filterByName || icd_9_code || dateFiltered);
           console.log(filterValue);
           console.log(filterBy);
      if(filterBy != "" && (filterValue == undefined || filterValue == null)){
         Ext.MessageBox.alert("Warning", "Please select the Filter Value.")
       }else{
        g.setLoading(true);
        this.filterPatientsWithEpisode({selected_filter: filterBy, selectd_filter_value: filterByName, selected_status: treatment_status,
            from_date: fromDate, to_date: toDate, group_by_md: groupBy, unduplicated: unDuplicated, date_source: dateSource, icd_code: icd_9_code,
            selected_disciplines: disciplines, date_filter: dateFiltered}, function(res){
          g.setLoading(false);
          if(res){
            this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
          }else{
            Ext.MessageBox.alert("Status", "No Records Found.");
          }
        }, this);
       if (w) w.close();
      }
    }
  JS


  endpoint :filter_patients_with_episode do |params|
    census_report = CensusReport.new
    census_report.set_dates_for_census_report(params)
    if census_report.records_for_census_report.empty? == false
      session[:pre_generated_file_name] = census_report.to_pdf
      {:set_result => true}
    else
      {:set_result => false}
    end
  end


  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "Census Report" ,
        width: '90%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

  def group_by_filter
    [["", "---"],["Physician", "MD"], ["InsuranceCompany", "Primary Insurance"], ["SOC", "SOC Date"], ["PrimaryDiagnosis", "Primary Diagnosis"],
     ["FieldStaff", "Assigned Field Staff (Including Staffing Company Staff)"], ["Acuity", "Acuity"]]
  end

  def group_by_date_source
    [["", "---"],['SOC','SOC'],['Discharge','Discharge'],['EpisodeStart','Episode Start'],['EpisodeEnd','Episode End'],['ActiveDuring','Active During']]
  end

  def empty_store
    [['','---']]
  end

  def get_combobox_options_endpoint(params)
    OasisEvaluation.netzke_combo_options_for_census_report({query: params["query"]}) if params["query"].present?
  end
end