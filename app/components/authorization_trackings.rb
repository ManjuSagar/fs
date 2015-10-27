class AuthorizationTrackings < Mahaswami::GridPanel

  def configuration
    s = super
    s.merge(
      model: "AuthorizationTracking",
      title: "Authorization Management",
      auto_scroll: true,
      editOnDblClick: false,
      item_id: "authorization_tracking",
      infinite_scroll: false,
      enable_pagination: false,
      border: false,
      context_menu: false,
      columns: [
        {name: :patient_full_name, editable: false, label: "Patient", width: '12%', addHeaderFilter: true},
        {name: :insurance_company_code, editable: false, label: "Insurance", width: '8%', addHeaderFilter: true},
        {name: :insurance_case_manager_name, renderer: :tooltip_renderer, editable: false, label: "Case Manager",
          width: '10%', addHeaderFilter: true},
        {name: :discipline_display, editable: false, label: "Discipline", width: '6%', filter1: {xtype: 'combo', editable: false,
          store: Discipline::COMBO_STORE_DISPLAY},
          addHeaderFilter: true},
        {name: :field_staff_display, editable: false, label: "Staff", width: '12%', addHeaderFilter: true},
        {name: :start_date, editable: false, label: "Start", width: '8%', filter1: {xtype: 'datefield'},
          addHeaderFilter: true},
        {name: :end_date, editable: false, label: "End", width: '8%', filter1: {xtype: 'datefield'},
          addHeaderFilter: true},
        {name: :visit_count, editable: false, label: "Visits", width: '6%', addHeaderFilter: true},
        {name: :reported, editable: true, label: "Reported", width: '7%', renderer: :authorization_status_renderer,
          filter1: {xtype: 'combo', store: AuthorizationTracking::FLAG_COMBO_STORE, editable: false},
          addHeaderFilter: true},
        {name: :evaluation_sent, editable: true, label: "Eval Sent", renderer: :authorization_status_renderer,
          width: '7%', filter1: {xtype: 'combo', store: AuthorizationTracking::FLAG_COMBO_STORE, editable: false},
          addHeaderFilter: true},
        {name: :approval_received, editable: true, label: "Approved", renderer: :authorization_status_renderer,
          width: '7%', filter1: {xtype: 'combo', store: AuthorizationTracking::FLAG_COMBO_STORE, editable: false},
          addHeaderFilter: true},
        {name: :visit_done, header: "Done", width: '7%', renderer: :authorization_status_renderer,
          filter1: {xtype: 'combo', store: AuthorizationTracking::FLAG_COMBO_STORE, editable: false},
          editable: true},
        {name: :insurance_case_manager_phone, hidden: true }
      ],
      scope: :sort_filter_scope
    )
  end

  def default_bbar
    [:add_tracking_form.action, :edit_tracking_form.action, :apply.action]
  end

  action :add_tracking_form, text: "Add", cls: "drug_interactions_button", icon: ''
  action :edit_tracking_form, text: "Edit", cls: "drug_interactions_button", icon: ''

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.actions.editTrackingForm.setDisabled(true);
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.editTrackingForm.setDisabled(selModel.getCount() != 1);
        var record = selModel.selected.first();
        if(record){
          this.setSelectedRecordId({record_id: record.getId()});
        }
        else{
          this.actions.editTrackingForm.setDisabled(true);
        }
      },this);
    }
  JS

  js_method :authorization_status_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store){
      metadata.style="text-align:center";
      if (value == true)
        return "<img class='checked_image_class'>";
      if (value == false)
        return "<img class='cross_image_class'>";
    }
  JS

  js_method :tooltip_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store)
    {
      var phone_no = record.get('insurance_case_manager_phone');
      metadata.tdAttr = 'data-qtip="' + phone_no + '"';
        return value;
    }
  JS

  js_method :on_add_tracking_form, <<-JS
    function(){
      this.formDisplayComponent('authorization_form', 'authorization_new_form', 'Add Authorization Tracking');
    }
  JS

  js_method :on_edit_tracking_form, <<-JS
    function(){
      this.formDisplayComponent("authorization_edit_form", 'authorization_edit_form', 'Edit Authorization Tracking');
    }
  JS

  js_method :form_display_component,<<-JS
    function(comp_name, item_id, title){
      var g = this;
      var buttons = [];
      var deleteButton = [{xtype: 'button', text: "Delete", cls: "blue-color-button",
        listeners: {
          click: function(){
            g.deleteRecord(g,w);
          }
        }
      }];
      var basicButtons = [
        {xtype: 'button', text: "Orders", itemId: 'view_orders', cls: "blue-color-button"},
        {xtype: 'button', text: "Save", cls: "blue-color-button",
          listeners: {
            click: function(){
              var form = Ext.ComponentQuery.query('#'+item_id)[0];
                form.on("submitsuccess", function(){ w.closeRes = "ok"; g.store.load();
                  g.destroyCurrentForm(form); w.close();
                }, w);
              form.onApply();
            }
          }
        },
        {xtype: 'button', text: "Close",cls: "blue-color-button",
          listeners: {
            click: function(){
              w.close();
            }
          }
        }
      ];
      if(comp_name == 'authorization_form'){
        buttons = basicButtons;
      }else{
        buttons = deleteButton.concat(basicButtons);
      }
      var w = new Ext.window.Window({
        width: '75%',
        height: '80%',
        bbar: false,
        buttons: buttons,
        modal: true,
        border: false,
        layout:'fit',
        title: title
      });
      w.show();
      this.loadNetzkeComponent({name: comp_name, container:w, callback: function(w){
        w.show();
      }});
    }
  JS

  endpoint :set_tracking_id do |params|
    component_session[:tracking_id] = params[:tracking_id]
  end

  js_method :destroy_current_form,<<-JS
    function(currentForm){
      currentForm.clearStateOnDestroy = false;
      currentForm.unloadNetzkeComponentInServer();
    }
  JS

  js_method :delete_record,<<-JS
    function(g,w){
      this.getRecordId({},function(res){
      var msg = "Are you sure you want to permanently delete this authorization?";
        Ext.Msg.confirm(this.i18n.confirmation, msg, function(btn){
          if(btn == 'yes') {
            g.deleteRecordItem({records: Ext.encode(res)},function(){
              w.close();
              Ext.Msg.alert('Status', 'Deleted the Record(s) successfully.');
              g.store.load();
            },g);
          }
        });
      },this);
    }
  JS

  endpoint :delete_record_item do |params|
    return unless params[:records]
    authorization = AuthorizationTracking.find(params[:records])
    authorization.delete
    {:set_result => true}
  end

  endpoint :set_selected_record_id do |params|
    component_session[:tracking_id] = params[:record_id]
  end

  endpoint :get_record_id do |params|
    {:set_result => component_session[:tracking_id]}
  end

  component :authorization_form do
    {
      :lazy_loading => true,
      :class_name => "AuthorizationTrackingForm",
      :auto_height => true,
      :header => false,
      :button_align => "right",
      :bbar => false,
      :fbar => false
    }
  end

  component :authorization_edit_form do
    {
      :lazy_loading => true,
      :class_name => "AuthorizationTrackingEditForm",
      record_id: (component_session[:tracking_id] if component_session[:tracking_id]),
      :header => false,
      :button_align => "right",
      :bbar => false,
      :fbar => false
    }
  end

end
