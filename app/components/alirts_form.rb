class AlirtsForm < Mahaswami::Panel
  def configuration
    c = super
    c.merge(
        title: "ALIRTS Report",
        bbar: ["->", :ok.action],
        items: [
            {
                xtype: 'borderlessFormPanel',
                layout: {
                    type: "vbox",
                    align: 'stretch'
                },
                margin: '5 5 0 0',
                items: [
                    {name: :alirts_year, editable: false, field_label: "Year", labelAlign: "right", item_id: 'alirts_id', xtype: 'combo', store: year_data_store, allowBlank: false}
                ]

            },
        ]
    )
  end

  def year_data_store
    years = []
    first_patient = Patient.org_scope.first.created_at
    first_patient.year.upto(Date.today.year).each{|x| years << x}
    years
  end

  action :ok, text: "Submit", icon: false

  action :ok do
    { :text => I18n.t('netzke.basepack.grid_panel.record_form_window.actions.ok'), icon: :save_new}
  end

  js_method :on_ok,<<-JS
    function(){
      var date = Ext.ComponentQuery.query("#alirts_id")[0].value;
      if (date == undefined){
        Ext.MessageBox.alert("Status", "Year can't be blank.");
      }else{
        this.setLoading(true);
        this.reportFilterOptions({date: date},function(res){
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
    date = Date.parse("'#{options[:date]}'")
    bc = ReportDataSource::AlirtsDataSource.new({:date => date})
    res = bc.to_pdf
    session[:pre_generated_file_name] = res
    {:set_result => res}
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        title: "Alirts Report",
        width: '60%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

end