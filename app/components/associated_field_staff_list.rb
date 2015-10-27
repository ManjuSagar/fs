  class AssociatedFieldStaffList < Mahaswami::HasManyCollectionList
  association "org_users"
  parent_model "Org"
  parent_id Org.current.id

  def initialize(conf = {}, parent = nil)
    super
    return unless component_session[:associated_fs_id]
    components[:edit_form][:items].first.merge!(:parent_id => component_session[:associated_fs_id])
  end


  def configuration
    super.merge(
        title: "Field Staff",
        item_id: :associated_field_staff_grid,
        editOnDblClick: false,        
        columns: [
            {name: :user__first_name, header: "First Name", editable: false, width: "10%", addHeaderFilter: true},
            {name: :user__last_name, header: "Last Name", editable: false, width: "10%", addHeaderFilter: true},
            {name: :user__license_type_code, header: "License", editable: false, width: "7%", filter1: {xtype: "combo", store: LicenseType::TYPE_STORE}},
            {name: :user__email, editable: false, width: "20%", header: "Email", addHeaderFilter: true},
            {name: :user__phone_number, editable: false, width: "15%", header: "Phone", getter: lambda{|r| phone_numbers(r) }},
            {name: :user_status, header: "Status", editable: false, width: "10%", :getter => lambda {|l| l.user_status.to_s.titleize},
                            filter1: {xtype: "combo", store: OrgUser::STATUS_STORE}},
            action_column("associated_field_staff_grid")
        ],
        scope: :field_staffs
    )
  end

  def phone_numbers(org_user)
    user = org_user.user
    user.phone_number_2 ? "#{user.phone_number}, #{user.phone_number_2}" : "#{user.phone_number}"
  end

  def perform_event(comp_name, record, event)
    if event == :enter_verification_token
      <<-JS
      var g = Ext.ComponentQuery.query("##{comp_name}")[0];
      Ext.MessageBox.prompt('Verify Token', 'Please enter the Token which you received from Field Staff.', function(btn, text){
          if(btn == "ok"){
            g.checkVerificationCode({org_user_id: "#{record.id}", verification_token: text});
          }
      },this);
      JS
    else
      super
    end
  end

  def current_record(record_id)
    self.config[:model].constantize.field_staffs.find(record_id)
  end

  endpoint :check_verification_code do |params|
    org_user_id = params[:org_user_id].to_i
    org_user = Org.current.org_users.pending_approval.find(org_user_id)
    org_user.activation_token = params[:verification_token]
    if org_user.enter_verification_token!
      {:verification_result => true}
    else
      {:verification_result => false}
    end
  end

  js_method :verification_result, <<-JS
    function(result){
      if(result){
        this.store.load();
      }else{
        Ext.MessageBox.alert("Status", "Invalid token.  Please try again.");
      }
    }
  JS

  def data_adapter
    AssociatedFieldStaffList::MyDataAdapter.new(data_class)
  end

  def default_bbar
    [:add_in_form.action, :add_lite_field_staff.action, :view_details.action, :print.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :add_lite_field_staff.action, :del.action]
  end

  action :add_in_form, text: "", tooltip: "Add Field Staff", icon: :add_new
  add_form_config    class_name: "AssociatedFieldStaffForm", mode: :add
  add_form_window_config width: "30%", height: "25%", title: "Add Field Staff"

  action :view_details, text: "", tooltip: "Edit Field Staff", icon: :edit, disabled: true, item_id: :field_staff_details
  action :add_lite_field_staff, text: "Add Lite Field Staff", icon: false, hidden: true
  action :print, text: "Print All", tooltip: 'Print Credentials', cls: "blue-color-button"

  component :field_staff_details do
    form_config = {
        :class_name => "AssociatedFieldStaffViewDetail",
        :border => true,
        :bbar => false,
        :is_sample_patient => true,
        :prevent_header => true,
        field_staff_id: component_session[:field_staff_id],
        org_user_id: component_session[:associated_fs_id]
    }
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "90%",
        :height => "87%",
        :title => "Field Staff Details",
        :button_align => "right",
        :items => [form_config]
    }
  end

  component :lite_field_staff_form do
    {
        :lazy_loading => true,
        :class_name => "Netzke::Basepack::GridPanel::RecordFormWindow",
        :width => "30%",
        :auto_height => true,
        :title => "Add Field Staff",
        :button_align => "right",
        :items => [:add_form.component(class_name: "AdhocLiteFieldStaffFormPanel")]
    }
  end

  js_method :on_view_details, <<-JS
    function(){
     this.loadNetzkeComponent({name: "field_staff_details", callback: function(w){
        w.show();
        w.on('close', function(){
          if (w.closeRes === "ok") {
            this.store.load();
          }
        }, this);
      }, scope: this});
  }
  JS

  js_method :on_print, <<-JS
    function(){
      if(this.getSelectionModel().getCount() == 1){
         this.setLoading(true);
        this.viewCredentials({}, function(res){
          if(res){
            this.loadNetzkeComponent({name: "launch_report", callback: function(w){w.show();}});
            w.close();
          }else{
            Ext.MessageBox.alert("Status", "No Credentials to print.");
          }
        },this);
        this.setLoading(false);
      }else {
        Ext.MessageBox.alert('Status', 'No Record(s) selected to print Credentials.');
      }
    }
  JS

  js_method :on_add_lite_field_staff, <<-JS
  function(){
    this.loadNetzkeComponent({name: "lite_field_staff_form", callback: function(w){
      w.show();
      w.on('close', function(){
        if (w.closeRes === "ok") {
          this.store.load();
        }
      }, this);
    }, scope: this});
  }
  JS

  endpoint :view_credentials do |params|
    field_staff = FieldStaff.org_scope.where({id: component_session[:field_staff_id]}).first
    fs_credential_data = ReportDataSource::FsCredentialReportDataSource.new(field_staff)
    url = fs_credential_data.combined_reports
    if url
      session[:pre_generated_file_name] = url
      component_session[:title] = "Field Staff Credentials"
      component_session[:report_url] = "/reports/pre_generated"
    end
    {set_result: url.present? }
  end

    component :launch_report do
      {
          class_name: "LaunchReport",
          title: component_session[:title],
          width: '60%',
          height: '90%',
          url: component_session[:report_url]
      }
    end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
          this.selectRecord({associated_fs_id: record.get('id')});
     }, this);
      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.viewDetails.setDisabled(selModel.getCount() != 1);
      }, this);

      this.on('celldblclick', function(view, td, cellIndex, record, tr, rowIndex, e, eOpts){
        this.fireEvent('itemdblclick', view, record, e);
        return false;
      });

      this.on('itemdblclick', function(view, record, e){
        this.selectRecord({associated_fs_id: record.get('id')}, function(result){
          this.onViewDetails();
        }, this);
        return false;
        }, this);
     }
  JS

  endpoint :select_record do |params|
    component_session[:associated_fs_id] = params[:associated_fs_id]
    org_user = Org.current.org_users.unscoped.field_staffs.find(params[:associated_fs_id])
    component_session[:field_staff_id] = org_user.user_id
    {:set_result => org_user.active?}
  end

  class MyDataAdapter < Netzke::Basepack::DataAdapters::ActiveRecordAdapter
    def destroy(ids)
      @model_class.unscoped.destroy(ids)
    end
  end

end


