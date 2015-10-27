class CostReportForm < Mahaswami::Panel
  def configuration
    c = super
    c.merge(
         title: "Cost Report",
         bbar: ["->", :ok.action],
         items: [
              {
                xtype: "borderlessFormPanel",
                layout: {
                    type: "vbox",
                    align: 'stretch'
                },
                margin: "5 5 0 0",
                items: [
                  {
                      name: :cost_report_year, editable: false, field_label: "Year", labelAlign: "right", item_id: 'cost_report_id',
                      xtype: 'combo', store: year_data_store, allowBlank: false
                  }
                ]

              }
         ]

    )
  end

  def year_data_store
    org_created_date = Org.current.created_at
    org_created_date.year.upto(Date.today.year).collect{|x| x}
  end

  action :ok, text: "Submit", icon: false

  js_method :on_ok,<<-JS
    function(){
      var date = Ext.ComponentQuery.query("#cost_report_id")[0].value;
      if (date == undefined){
        Ext.MessageBox.alert("Status", "Year can't be blank.");
      }else{
        this.setLoading(true);
        this.reportFilterOptions({date: date},function(res){
          this.setLoading(false);
          if(res)
             this.loadNetzkeComponent({name: "launch_cost_report", callback: function(w){w.show();}});
          else
            Ext.MessageBox.alert("Status", "No Records Found.");
        }, this);
      }
    }
  JS

  endpoint :report_filter_options do |params|
    date = Date.parse("'#{params[:date]}'")
    cost_report_obj = CostReportDataSource.new({:date => date})
    res = cost_report_obj.to_pdf
    session[:pre_generated_file_name] = res
    {:set_result => res}
  end

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  component :launch_cost_report do
    {
        class_name: "LaunchReport",
        title: "Cost Report",
        width: '70%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

end