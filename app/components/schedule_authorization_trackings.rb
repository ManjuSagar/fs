class ScheduleAuthorizationTrackings < Mahaswami::GridPanel

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:episode_id] = s[:episode_id] if s[:episode_id]
    org = PatientTreatment.find(s[:treatment_id]).patient.org
    office_staff = User.current.office_staff?
    s.merge(
      model: "AuthorizationTracking",
      title: "Authorizations",
      editOnDblClick: false,
      infinite_scroll: false,
      enable_pagination: false,
      border: false,
      context_menu: false,
      item_id: :schedule_authorizations_trackings,
      columns:[
        ((office_staff)?
          {name: :discipline__discipline_code, header: "Discipline",
            width: '17%', editor:{:xtype => :combo, store: disciplines_store}, filter1: {xtype: 'combo', editable: false,
            store: Discipline::COMBO_STORE_DISPLAY}} :
          {name: :discipline__discipline_code, header: "Discipline", width: '17%', editable: false, filter1: {xtype: 'combo',
            editable: false, store: Discipline::COMBO_STORE_DISPLAY}}
        ),
        ((office_staff)?
          {name: :field_staff__full_name, emptyText: '', item_id: :field_staff_user_id, header: "Staff",
            editor: {:xtype => :combo, store: field_staff_list, item_id: :field_staff_store}, width: '30%', editable: true,
            addHeaderFilter: true} : {name: :field_staff__full_name, header: "Staff", width: '30%', editable: false, addHeaderFilter: true}
        ),
          {name: :start_date, addHeaderFilter: true, label: "Start", editable: office_staff, width: '18%', format: 'm/d/y'},
          {name: :end_date, addHeaderFilter: true, label: "End", editable: office_staff, width: '18%', format: 'm/d/y'},
          {name: :visit_count, addHeaderFilter: true, label: "Visits", editable: office_staff, width: '10%'},
          {name: :approval_received, editable: office_staff, width: '17%', label: "Approved", renderer: :authorization_status_renderer,
            filter1: {xtype: 'combo', store: AuthorizationTracking::FLAG_COMBO_STORE, editable: false}},
          {name: :visit_done, label: "Done", width: '15%', renderer: :authorization_status_renderer, editable: office_staff,
            filter1: {xtype: 'combo', store: AuthorizationTracking::FLAG_COMBO_STORE, editable: false}}

      ],
    bbar: ((office_staff)? [:add_tracking_form.action, :edit_tracking_form.action, :apply.action] : false ),
    scope: ["scope_with_params,episode_scope"] + [s[:episode_id],org]
    )
  end

  action :add_tracking_form, text: "Add", cls: "drug_interactions_button", icon: ''
  action :edit_tracking_form, text: "Edit", cls: "drug_interactions_button", icon: ''

  js_method :authorization_status_renderer, <<-JS
    function(value, metadata, record, rowIndex, colIndex, store){
      metadata.style="text-align:center";
      if (value == true)
        return "<img class='checked_image_class'>";
      if (value == false)
        return "<img class='cross_image_class'>";
    }
  JS

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.actions.editTrackingForm.setDisabled(true);
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.editTrackingForm.setDisabled(selModel.getCount() != 1);
        var record = selModel.selected.first();
        if(record){
          this.setSelectedRecordId({record_id: record.getId()});
        }else{
          this.actions.editTrackingForm.setDisabled(true);
        }
      },this);
      this.store.on('load', function(){
        var records = this.store.getNewRecords();
      }, this);
    }
  JS

  endpoint :post_data do |params|
    updated_data = []
    data = ActiveSupport::JSON.decode(params["updated_records"]) if params["updated_records"]
    if !data.nil? && !data.empty? # data may be nil for one of the operations
      data.each do |row|
        updated_data << row
      end
    end
    update_schedule_authorizations(updated_data)
  end

  def update_schedule_authorizations(data)
    errors = []
    records = []
    data.each{|row|
      record = AuthorizationTracking.org_scope.find(row["id"])
      row.each_pair do |k,v|
        record.set_value_for_attribute(columns_hash[k.to_sym].nil? ? {:name => k} : columns_hash[k.to_sym], v)
      end
      record.valid?
      success = record.errors.empty?
      records << record
      record.errors.to_a.each{|msg|
        errors << msg
      }
    }
    if errors.empty?
      records.each do |r|
        r.save!
      end
      {:refresh_grids => 1}
    else
      {:display_error_msgs => errors}
    end
  end

  js_method :refresh_grids, <<-JS
      function(){
        this.store.load();
        this.up("#schedule_visit_explorer_" + this.episodeId).down("#patient_schedules_new_" + this.episodeId).store.load();
      }
  JS

  js_method :display_error_msgs,<<-JS
      function(errors){
        if(errors.length > 0){
          Ext.Msg.alert('Warning', "Since you have changed the discipline, please change the field staff.");
        }
      }
  JS

  js_method :after_render,<<-JS
    function(){
      this.callParent();
      var grid = this;
      grid.on("edit", function(editor, e, options){
        if(e.field == 'discipline__discipline_code'){
          var discipline_code = e.record.data.discipline__discipline_code;
          record = e.record;
          if(record.dirty){record.set('field_staff__full_name', null);}
          this.setDisciplineId({discipline_id: discipline_code}, function(res){
            var fieldStaffStore = Ext.ComponentQuery.query('#field_staff_store')[0].store;
            fieldStaffStore.removeAll();
            fieldStaffStore.add(res);
            });
        }
      });
      grid.on('beforeedit', function(editor, e, options){
        if(e.field == 'field_staff__full_name'){
          var disciplineCode = e.record.data.discipline__discipline_code;
          this.setDisciplineId({discipline_id: disciplineCode}, function(res){
            var fieldStaffStore = Ext.ComponentQuery.query('#field_staff_store')[0].store;
              fieldStaffStore.removeAll();
              fieldStaffStore.add(res);
           }, this);
        }
      });
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
                g.refreshGrids();
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
    authorization = AuthorizationTracking.org_scope.find(params[:records])
    authorization.delete
    {:set_result => true}
  end

  endpoint :get_record_id do |params|
    {:set_result => component_session[:tracking_id]}
  end

  endpoint :set_discipline_id do |params|
    list = []
    discipline_id = params[:discipline_id]
    field_staffs =  FieldStaff.field_staffs_by_discipline(discipline_id)
    list = field_staffs.collect{|s| ["#{s.id}", s.to_s]}
    list.unshift(['0', "Pending Staffing"])
    {set_result: list}
  end

  endpoint :set_selected_record_id do |params|
     component_session[:tracking_id] = params[:record_id]
  end

  def disciplines_store
    values = []
      disciplines = Discipline.all
      values = disciplines.collect{|x| ["#{x.id}", x.discipline_code]}
    values
  end

  def field_staff_list
    unless component_session[:treatment_id].blank?
      treatment = PatientTreatment.find(component_session[:treatment_id])
      staffs = treatment.fs_and_sc_staffs
      values = staffs.collect{|x| ["#{x.id}", x.full_name]}.uniq
    end
  end

  component :authorization_form do
    {
      :lazy_loading => true,
      :class_name => "ScheduleAuthorizationTrackingForm",
      episode_id:  component_session[:episode_id],
      :auto_height => true,
      :header => false,
      :button_align => "right",
      :bbar => false,
      :fbar => false,
    }
  end

  component :authorization_edit_form do
    {
      :lazy_loading => true,
      :class_name => "ScheduleAuthorizationTrackingEditForm",
      :record_id => (component_session[:tracking_id] if component_session[:tracking_id]),
      :episode_id =>  component_session[:episode_id],
      :header => false,
      :button_align => "right",
      :bbar => false
    }
  end

end

