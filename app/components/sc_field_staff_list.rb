class ScFieldStaffList < Mahaswami::GridPanel

  def initialize(conf={}, parent_id=nil)
    @org_id = conf[:parent_id]
    super
  end


  def configuration
    c = super
    component_session[:org_id] = c[:parent_id] if c[:parent_id]
    c.merge(
        model: 'StaffingCompanyUser',
        title: 'Field Staff',
        columns: [{name: :first_name, editable: false, width: 160, field_label: "First Name", getter: lambda{|r| r.user.first_name}},
                  {name: :last_name, editable: false, field_label: "Last Name", getter: lambda{|r| r.user.last_name}},
                  {name: :license_type_description,  header: "License Type", width: "25%", getter: lambda{|r| r.user.license_type_description}}
        ],
        scope: "user_id IN (SELECT id FROM users WHERE user_type IN  ('LiteFieldStaff', 'FieldStaff')) AND org_id = #{component_session[:org_id]}",
        strong_default_attrs: {org_id: component_session[:org_id], :user_type => 'LiteFieldStaff'}
    )
  end

  action :credentials, text: "Credentials", icon: false, disabled: true
  action :add_in_form, text: "", tooltip: "Add Field Staff"
  action :edit_in_form, text: "", tooltip: "Edit Field Staff"
  add_form_window_config title: "Add Field Staff"
  edit_form_window_config title: "Edit Field Staff"

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :credentials.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action,  :del.action]
  end

  component :field_staff_credentials do
    {
        class_name: "FieldStaffCredentials",
        header: false,
        width: "50%",
        height: "50%",
        lite_field_staff_id: component_session[:field_staff_id],
        strong_default_attrs: {:field_staff_id => component_session[:field_staff_id]},
        scope: ["field_staff_id = ?", component_session[:field_staff_id]],
        lazy_loading: true
    }
  end

  js_method :on_credentials, <<-JS
    function(){
      var w = new Ext.window.Window({
      title: "Credentials",
       modal: true,
       layout: 'fit',
       width: "50%",
       height: "30%",
      });
      w.show();
      this.loadNetzkeComponent({name: "field_staff_credentials", container:w, callback: function(w){
        w.show();
      }});

     w.on('close', function(){
        if (w.closeRes === "ok") {
          this.store.load();
        }
      }, this);
  }
  JS



  endpoint :select_record do |params|
    component_session[:field_staff_id] = Org.current.org_users.unscoped.find(params[:org_user_id]).user.id
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
          this.selectRecord({org_user_id: record.get('id')});
     }, this);
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.credentials.setDisabled(selModel.getCount() != 1);
      }, this);
     }
  JS


  add_form_config class_name: "ScFieldStaffForm"
  edit_form_config class_name: "ScFieldStaffForm"


end