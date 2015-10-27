class BilledClaimsReportFilterOptions < Mahaswami::Panel
  def configuration
    s = super
    s.merge(
        layout: {
            type: 'vbox',
            align: :stretch,
        },
        title: "Billed Claims",
        defaults: {
            labelAlign: "right",
            labelWidth: 120
        },
        items: [

            {
                xtype: 'radiogroup',
                field_label: "FilterBy",
                name: 'filter_by_group',
                margin: "10px",
                columns: 1,
                items: [
                    {xtype:'radiofield', boxLabel: 'Sent Date', item_id: 'sent_date', name: 'filter_by', input_value: "SD", checked: true},
                    {xtype:'radiofield', width: 200, boxLabel: 'Expected Receive Date', item_id: 'expected_receive_date', input_value: "ERD", name: 'filter_by'},
                ]
            },
            {name: :date_from, field_label: "From <span style='color:red'><b>*</b></span>",  item_id: :from_date, xtype: :datefield, margin: "5px", label_align: "right"},
            {name: :date_to, field_label: "To<span style='color:red'><b>*</b></span>", item_id: :to_date, xtype: :datefield, margin: "5px", label_align: "right"},
            {
                xtype: :combo,
                margin: "8px",
                store: [[' ','---'],['C', 'Claim Type'], ['S', 'Sent Date'], ['E', 'Expected Receive Date']],
                field_label: "Group By",
                item_id: 'group_by',
            }

        ] ,
        fbar: [:ok.action]
    )
  end
  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  js_method :on_ok,<<-JS
    function(){
      var filterBy = Ext.ComponentQuery.query('[name=filter_by_group]')[0]
      var filterValue = filterBy.getValue().filter_by;
      var fromDate = Ext.ComponentQuery.query("#from_date")[0].value;
      var toDate = Ext.ComponentQuery.query("#to_date")[0].value;
      var groupBy = Ext.ComponentQuery.query("#group_by")[0];
      var groupByValue = groupBy.getValue();
      if (fromDate == undefined && toDate == undefined){
        Ext.MessageBox.alert("Status", "From Date and To Date can't be blank.");
       }
      else if(fromDate == undefined){
        Ext.MessageBox.alert("Status", "From Date can't be blank.");
        }
      else if(toDate == undefined){
        Ext.MessageBox.alert("Status", "To Date can't be blank.");
        }
      else if(new Date(fromDate) > new Date(toDate)){
        Ext.MessageBox.alert("Status", "Invalid date range.");
        }
      else{
        this.setLoading(true);
        this.reportFilterOptions({filter_value: filterValue, from_date: fromDate, to_date: toDate, group_by_value: groupByValue},function(res){
          this.setLoading(false);
          if(res)
            this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
          else
            Ext.MessageBox.alert("Status", "No Records Found.");
        }, this);
      }
    }
  JS

  endpoint :report_filter_options do |options|
    bc = BilledClaimsReportDataSource.new options
     if bc.empty?
      {:set_result => false}
    else
      res = bc.to_pdf
      session[:pre_generated_file_name] = res
      {:set_result => res}
    end
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "Billed Claim Report",
        width: '60%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end



end