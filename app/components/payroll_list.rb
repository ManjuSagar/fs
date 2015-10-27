class PayrollList < Mahaswami::GridPanel
  def configuration
    c = super
      c.merge(
      model: 'Payroll',
      title: 'Payroll',
      item_id: :payroll_grid,
      editOnDblClick: false,
      columns: (User.current.office_staff? ? [{name: :payee_field_staff_name, editable: false, label: "Field Staff", width: 160, addHeaderFilter: true},
               {name: :staff_type, editable: false, label: "Staff Type", width: 120, filter1: {xtype: 'combo', store:
                [["", "---"], ["User", "Field Staff"], ["Org", "Staffing Company"]]}}] :
               [{name: :health_agency, label: "Health Agency", editable: false, width: 140, addHeaderFilter: true}]) +
          [{name: :payroll_date, editable: false, label: "Paid Date", width: 100, addHeaderFilter: true},
          {name: :number_of_visits, editable: false, label: "# of Visits", align: :right, width: 80},
          {name: :payroll_amount, editable: false, label: "Amount", align: :right, width: 80, renderer: :payroll_amount_renderer, xaddHeaderFilter: true},
          {name: :office_staff__full_name, editable: false, label: "Agency Staff", width: 140, addHeaderFilter: true}
				],
        scope: payroll_scope(c[:scope])
    )
  end

  def payroll_scope(scope)
    scope.nil?? ((User.current.field_staff?) ? :fs_scope : :org_scope) : scope
  end

  def default_bbar
    User.current.office_staff? ? [:del.action, :print.action] : []
  end

  def default_context_menu
    []
  end

  action :del, text: "UNDO PAYROLL", tooltip: "UNDO PAYROLL", icon: false
  action :print, text: "", tooltip: "Print", icon: :print

  js_method :payroll_amount_renderer, <<-JS
    function(value){
      return value.toFixed(2);
    }
  JS
  
 js_method :on_del, <<-JS
   function() {
    Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
      if (btn == 'yes') {
        var records = [];
        this.getSelectionModel().selected.each(function(r){
          if (r.isNew) {
            // this record is not know to server - simply remove from store
            this.store.remove(r);
          } else {
            records.push(r.getId());
          }
        }, this);

        if (records.length > 0){
          if (!this.deleteMask) this.deleteMask = new Ext.LoadMask(this.getEl(), {msg: this.deleteMaskMsg});
          this.deleteMask.show();
          // call API
          this.deleteData({records: Ext.encode(records)}, function(){
            this.up('panel').down('#payroll_details_grid').store.load();
            this.deleteMask.hide();
          }, this);
        }
      }
    }, this);
  }
 JS

  js_method :on_print, <<-JS
    function() {
      var recordId = this.getSelectionModel().selected.first().getId();
      this.viewReport({payroll_id: recordId});
      this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
    }
  JS

  endpoint :view_report do |params|
    payroll = Payroll.find(params[:payroll_id])
    payroll.actual_payroll_ids = [payroll]
    payroll.report_context = payroll.set_report_context
    payroll.payroll_individual_print = true
    session[:pre_generated_file_name] = payroll.fs_sc_payroll_pdf(payroll)
    {:set_result => true}
  end

  component :launch_report do
    {
        class_name: "LaunchReport",
        width: '60%',
        height: '90%',
        url: "/reports/pre_generated"
    }
  end

  def perform_event(comp_name, record, event)
    if event == :mark_as_paid
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        var w = new Ext.window.Window({
          width: "25%",
          height: "17%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "",
              tooltip: "OK",
              iconCls: "ok_icon",
              listeners: {
                click: function(){
                var paid_date = w.down('#date').value;
                var created_date  = "#{record.payroll_date}";
                g.compareDate({paid_date : paid_date, created_date : created_date},function(result){
                  if(result){
                  Ext.MessageBox.alert("Failure", "Paid date should not be earlier than created date.");
                  }else{
                  g.sendPaidDate(w, "#{record.id}")
                  }
                }, g);
                
                }
              }
            },
            {
              text: "",
              tooltip: "Cancel",
              iconCls: "cancel_icon",
             listeners: {
                click: function(){w.close();}
              }
            }
          ],
            title: "Payroll Paid Date",
        });
        w.show();
        g.loadNetzkeComponent({name: "date_component", container:w, callback: function(w){
          w.show();
        }});
      JS
    else
      super
    end
  end

  component :date_component do
    {
      class_name: "Netzke::Basepack::Panel",
      title: false,
      header: false,
      items:[{name: :paid_date, field_label: "Paid Date", xtype: "datefield", item_id: :date, value: Date.current, margin: 5, allowBlank: false, dateFormat: 'Y-m-d', labelWidth: 150}]
    }
  end
  
  js_method :send_paid_date, <<-JS
    function(w, record_id){
       var paidDate = w.down('#date');
       var date = paidDate.value;
       this.updatePaidDate({payroll_id: record_id, paid_date: date});
       w.close();
    }
   JS
   
   endpoint :compare_date do |params|
     result = params[:created_date] < params[:paid_date] ? false : true
     {:set_result => result}
   end
   
   endpoint :update_paid_date do |params|
    ActiveRecord::Base.transaction do
     payroll = Payroll.find(params[:payroll_id])
     date = params[:paid_date].to_date if params[:paid_date]
     payroll.paid_date = date
     payroll.save!
     payroll.mark_as_paid!
    end
    {:refresh_referral_grid => true}
  end

  js_method :refresh_referral_grid, <<-JS
    function(args){
      this.store.load();
    }
  JS
end
