class FieldStaffCredentials < Mahaswami::GridPanel
  # To change this template use File | Settings | File Templates.

  def initialize(conf={}, parent_id = nil)
    super
    components[:add_form][:items].first.merge!(:field_staff_id => component_session[:field_staff_id])
    components[:edit_form][:items].first.merge!(:field_staff_id => component_session[:field_staff_id])
  end
  def configuration
    c = super
    component_session[:field_staff_id] = if User.current.office_staff?
                                           c[:strong_default_attrs][:field_staff_id]
                                         elsif  c[:lite_field_staff_id].present?
                                           c[:lite_field_staff_id]
                                         elsif User.current.field_staff?
                                           User.current.id
                                         end
    c.merge(
        model: "FieldStaffCredential",
        title: "Credentials",
        columns: [
            {name: :field_staff_credential_type__ct_description, header: "Type", editable: false, width: "20%"},
            {name: :attachment_file_name, header: "File Name", width: "25%", editable: false},
            {name: :expiry_date, header: "Expiration Date", editable: false},
           {name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

        ],
        strong_default_attrs: (c[:strong_default_attrs].nil? ? {field_staff_id: User.current.id} :
                                c[:strong_default_attrs]),
        scope: (c[:scope].nil? ? :field_staff_scope : c[:scope]),

    )
  end

  action :add_in_form, text: "", tooltip: "Add Credential"
  add_form_config class_name: "FieldStaffCredentialForm", mode: :new
  add_form_window_config width:"30%", height:"40%", title: "Add Credential"
  action :edit_in_form, text: "", tooltip: "Edit Credential"
  edit_form_config class_name: "FieldStaffCredentialForm", mode: :edit
  edit_form_window_config width:"30%", height:"40%", title: "Edit Credential"
  action :print, text: "Print All", tooltip: 'Print All Credentials', cls: "blue-color-button"

  def default_bbar
     [:add_in_form.action, :edit_in_form.action, :print.action, :del.action]
   end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :print.action, :del.action]
  end
  js_method :on_print, <<-JS
    function(){
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




end
