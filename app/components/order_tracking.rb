class OrderTracking < Mahaswami::GridPanel
include ButtonsOfOasisHeader

def initialize(conf = {}, parent_id = nil)
  super
  return unless component_session[:treatment_id]
  components[:edit_form].merge!( header: {
                                     titlePosition: 0,
                                     items:  [{xtype:'button',
                                               text: "View Medications",
                                               item_id: :md_oder_medication,
                                              }]})
  components[:edit_form][:items].first.merge!(:parent_id => component_session[:treatment_id])
end

  def configuration
    s = super
    s.merge(
      model: "MedicalOrder",
      checkboxModel: true,
      infinite_scroll: false,
      enable_pagination: false,
      rowsPerPage: 10000,
      item_id: :order_tracking_grid,
      title: "Order Tracking",
      columns: [{name: :order_date, header: "Order Date", editable: false, width: "8%", addHeaderFilter: true},
        {name: :treatment__to_s, header: "Patient", editable: false, width: "13%", addHeaderFilter: true},
        {name: :created_user__full_name, header: "Staff", editable: false, width: "13%", addHeaderFilter: true},
        {name: :staff_sign_date, header: "Signed", editable: false, width: "8%", filter1: {xtype: 'datefield'}},
        {name: :physician__full_name, header: "Physician", editable: false, width: "13%", addHeaderFilter: true},
        {name: :order_status, header: "Status", editable: false, :getter => lambda{|l| MedicalOrder::STATUS_DISPLAY[MedicalOrder::STATE_MAP[l.order_status]]}, width: "8%", filter1: {xtype: 'combo', store: MedicalOrder::ORDER_TRACKING_STATUS_STORE}},
        {name: :aging, header: "Aging", editable: false, width: "5%"},
        {name: :order_type__type_description, header: "Category", editable: false, width: "8%", filter1: {xtype: 'combo', store: order_type_store}},
        {name: :aged, label: "Aged?", hidden: true, width: "16%"},
        action_column("order_tracking_grid")
      ],
      scope: :not_complete
    )
  end

  edit_form_window_config width: "50%", height: "80%"
  edit_form_config class_name: "MedicalOrderEditForm"

  def action_column(grid_component_name = nil)
    comp_name = grid_component_name || self.class.name.underscore
    {name: :actions, flex: 1, label: "", editable: false,
     :getter => lambda {|x| x.events_for_current_state.collect{|r|
       link_to_function(human_action_name(x, r), perform_event(comp_name, x, r), {id: "record_#{x.id}"})}.join(" | ")
     }
    }
  end

  def order_type_store
    order = OrderType.new
    order.order_type_store
  end

  def human_action_name(mo, event)
    if event.name == :send_to_physician
      mo.physician.default_email? ? "Mark Sent" : "Email Order"
    elsif event.name == :mark_order_received
      "Receive"
    else
      event.title
    end
  end

  def default_bbar
    [:print.action, :send_to_physician.action, :download.action]
  end

  action :print, text: "", icon: :print, tooltip: "Print orders"
  action :send_to_physician, text: "", icon: :email_send, tooltip: "Email orders to Physician"
  action :download, text: "", icon: :download, tooltip: "Download orders"

  def default_context_menu
    []
  end

  def perform_event(comp_name, record, event)
    if event == :mark_order_received
      <<-JS
      var g = Ext.ComponentQuery.query("##{comp_name}")[0];
      g.selectMoId({mo_id: "#{record.id}"});
      g.loadNetzkeComponent({name: "signed_order_upload", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            g.performAction(#{record.id}, "#{event.name}");
          }
        }, this);
      }, scope: g});
      JS
    elsif event == :sign
      <<-JS
        var g = Ext.ComponentQuery.query("##{comp_name}")[0];
        g.selectMoId({mo_id: "#{record.id}"}, function(){
          var w1 = new Ext.window.Window({
            width: "25%",
            height: "25%",
            modal: true,
            layout:'fit',
            title: "Electronic Signature",
          });
          w1.show();
          g.loadNetzkeComponent({name: "verify_user_authentication", container:w1, callback: function(w){
            w.show();
            w.on('close', function(){
              if (w.signRes === true) {
                g.performAction(#{record.id}, "#{event.name}");
                g.store.load();
                w1.close();
              }
            }, this);
          }});
        }, this);
      JS
    else
      super
    end
  end

  component :verify_user_authentication do
    {
        class_name: "VerifyUserAuthentication",
        record_klass: "MedicalOrder",
        record_id: component_session[:selected_mo_id]
    }
  end

  js_method :refresh_grids, <<-JS
    function(){
      this.store.load();
    }
  JS

  endpoint :select_mo_id do |params|
    component_session[:selected_mo_id] = params[:mo_id].to_i
  end

  component :signed_order_upload do
    form_config = {
        class_name: "MedicalOrderUploads",
        record_id: component_session[:selected_mo_id],
        bbar: false,
        header: false,
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :auto_width => true,
        :auto_height => true,
        :title => "Upload File",
        :button_align => "right",
        :items => [form_config]
    }
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.setTreatmentId({treatment_id: record.get('treatment__to_s')});
      });
      //this.getView().on('refresh', function(){
        //this.addRowColor();
      //}, this);
    //HACK:: After reloading a store we are setting the same url for the purpose of after load complete download will start
      this.store.on('load', function(){
        if(this.url) window.location = this.url;
        this.url = null;
      }, this);
    }
  JS

  endpoint :set_treatment_id  do |params|
    component_session[:treatment_id] = params[:treatment_id]
  end
  
  js_method :add_row_color, <<-JS
    function(){
      Ext.each(this.store.data.items, function(item, index){
				if (item.data.aged == "true"){
          var row = $('#app__order_tracking-body tr:nth-child(' + (index + 1) + ')')[0];
          if(row)
					 row.style.color = 'red';
				}
			});
		}
  JS

  js_method :on_print,<<-JS
    function(){
       if (this.selectedRecordIds.length > 0) {
          this.setLoading(true);
          this.printMedicalOrders({records: this.selectedRecordIds}, function(){
            this.afterActionResetSelection();
            this.setLoading(false);
          }, this);
       }else{
          Ext.MessageBox.alert("Status", "No order(s) selected to print.");
       }
    }
  JS

  js_method :on_send_to_physician,<<-JS
    function(){
       if (this.selectedRecordIds.length > 0) {
          this.setLoading(true);
          this.sendOrdersToPhysician({records: this.selectedRecordIds}, function(){
            this.afterActionResetSelection();
            this.setLoading(false);
          }, this);
       }else{
          Ext.MessageBox.alert("Status", "No order(s) selected to send to physician.");
       }
    }
  JS

  js_method :on_download,<<-JS
    function(){
      if (this.selectedRecordIds.length > 0) {
        this.setLoading(true);
        this.downloadOrdersZip({records: this.selectedRecordIds}, function(url){
          if(url){
            this.url = window.location.protocol + "//" + window.location.host + url + "?target=_blank";
            this.doNotRememberAfterStoreReload = true;
            this.store.load();
            this.doNotRememberAfterStoreReload = false;
            this.setLoading(false);
          }else{
             this.afterActionResetSelection();
             this.setLoading(false);
             Ext.MessageBox.alert("Status", "No order(s) ready to download.");
           }
        }, this);
      }else {
        Ext.MessageBox.alert("Status", "No order(s) selected to download.");
      }
    }
  JS

  endpoint :download_orders_zip do |params|
    mo_order =  MedicalOrder.new
    reference_name = mo_order.generate_zip_file(params[:records])
    if reference_name
      url = Rails.application.routes.url_helpers.export_orders_zip_file_path(reference_name)
      {set_result: url}
    else
      {:set_result => false}
    end
  end


  js_method :after_action_reset_selection, <<-JS
    function(){
       this.doNotRememberAfterStoreReload = true;
       this.store.load();
       this.doNotRememberAfterStoreReload = false;
    }
  JS

  endpoint :send_orders_to_physician do |params|
    mo_order =  MedicalOrder.new
    records_processed = mo_order.send_selected_orders_to_physician(params[:records])
    unless records_processed
      {:display_no_orders_send => true}
    end
  end

  js_method :display_no_orders_send, <<-JS
    function(res){
       Ext.MessageBox.alert("Status", "No order(s) ready to send.");
    }
  JS


  endpoint :print_medical_orders do |params|
    mo_order =  MedicalOrder.new
    selected_orders = mo_order.get_selected_orders(params[:records])
    if selected_orders.present?
      session[:pre_generated_file_name] = mo_order.combine_selected_orders(selected_orders)
      {:launch_medical_order_report => ["/reports/pre_generated", "Order Details"]}
    else
      {:display_no_orders_signed => true}
    end
  end

  js_method :display_no_orders_signed, <<-JS
    function(res){
       Ext.MessageBox.alert("Status", "No order(s) signed.");
    }
  JS

  js_method :launch_medical_order_report, <<-JS
    function(res) {
      var reportUrl = res[0];
      reportUrl = window.location.protocol + "//" + window.location.host + res[0];
      var reportTitle = "Medical Order";
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            itemId: 'print_orders',
            items : [{
                xtype : "component",
                id: 'myIframe',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();
        Ext.getDom('myIframe').src = reportUrl
      }
    }
  JS

end
