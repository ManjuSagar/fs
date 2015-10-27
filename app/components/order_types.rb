class OrderTypes < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'OrderType',
        title: 'Order Types',
        enable_pagination: false,
        rows_per_size: 500,
        columns: [
            {name: :type_code, label: "Code", width: "15%", editable: false},
            {name: :type_description, label: "Description", width: "15%", editable: false},
            {name: :type_status, editable: false, label: 'Status', getter: lambda{|r| r.type_status.to_s.titleize}},
            action_column("order_types")
        ],
        scope: :org_scope,
        strong_default_attrs: {:org_id => Org.current.id, system_required: false},
    )
  end



  action :add_in_form, text: "", tooltip: "Add"
  action :edit_in_form, text: "", tooltip: "Edit", icon: :edit

  add_form_window_config title: "Add Order Type"
  edit_form_window_config title: "Edit Order Type"

  def default_bbar
    [:add_in_form.action, :edit_in_form.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action]
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.checkTypeIsSystemRequired({type_id: record.get("id")}, function(res){
          this.actions.editInForm.setDisabled(res);
        }, this);
      }, this);
    }
  JS

  endpoint :check_type_is_system_required do |params|
    res = OrderType.find(params[:type_id]).system_required
    {set_result: res}
  end

  def default_fields_for_forms
    [
        {name: :type_code, field_label: 'Code'},
        {name: :type_description, label: 'Description'}
    ]
  end

  def perform_event(comp_name, record, event)
    if event == :disable
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        var w = new Ext.window.Window({
          width: "25%",
          height: "18%",
          modal: true,
          layout:'fit',
          buttons: [
            {
              text: "",
              tootlip: "OK",
              iconCls: "ok_icon",
              listeners: {
                click: function(){
                  g.sendUpdatedOrderTypeDisabledDate(w, "#{record.id}")
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
            title: "Order Type Disabled Date",
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
        items:[{name: :date, field_label: "Disabled Date", xtype: "datefield", item_id: :date,  margin: 5, allowBlank: false, value: Date.current, dateFormat: 'Y-m-d', labelWidth: 150}]
    }
  end

  js_method :send_updated_order_type_disabled_date, <<-JS
      function(w, record_id){
        var refDate = w.down('#date');
        var date = refDate.value;
        this.updateOrderTypeDisabledDate({order_type_id: record_id, disabled_date: date}, function(result){
          if(result){
            w.close();
            this.store.load();
          }
          else{
            Ext.MessageBox.alert("Status", "Invalid Date. Please try again.");
          }
        }, this);
    }
  JS

  endpoint :update_order_type_disabled_date do |params|
    result = false
    unless params[:disabled_date].nil?
      date =  params[:disabled_date].to_date
      ActiveRecord::Base.transaction do
        order_type = OrderType.find(params[:order_type_id])
        order_type.disabled_date = date
        order_type.save!
        order_type.disable!
        result = true
      end
    end
    {:set_result => result}
  end

  js_method :refresh_referral_grid, <<-JS
    function(args){
      this.store.load();
    }
  JS

end