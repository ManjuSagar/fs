class OrganizationUsersList < Mahaswami::GridPanel

  def configuration
    c = super
    login_user_is_admin =  (c[:facility_owner_login] == true)? true : OrgUser.unscoped.find_by_user_id_and_org_id(User.current.id, c[:org_id]).admin?
      c.merge(
      login_user_is_admin: login_user_is_admin,
      model: 'OrgStaff',
      title: 'Users',
      editOnDblClick: false,
      columns: [{name: :first_name, header: "First Name", editable: false, width: 160},
                {name: :last_name, header: "Last Name", editable: false},
                {name: :email, editable: false, width: 165},
                {name: :role_type, header: "Role Type", getter: lambda{|r| OrgUser::ROLE_TYPE_HASH[r.role_type]}},
                {name: :user_status, header: "Active?", editable: false, width: 165}
                ],
      scope: (c[:scope].nil?? :org_scope : c[:scope]),
      add_form_config: {class_name: "OrganizationUserForm", org_id: c[:org_id], login_user_is_admin: login_user_is_admin},
      edit_form_config: {class_name: "OrganizationUserForm", org_id: c[:org_id], login_user_is_admin: login_user_is_admin}
    )
  end

  add_form_window_config title: "Add User"
  edit_form_window_config title: "Edit User"

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add User"
  action :edit_in_form, text: "Edit User"

  js_method :init_component,<<-JS
    function(){
      this.callParent();
      this.on('itemclick', function(view, record){
        this.checkUserIsAdmin({user_id: record.get('id')}, function(result){
          this.actions.editInForm.setDisabled(result);
          this.actions.del.setDisabled(result);
        }, this);
      }, this);

      this.on('celldblclick', function( view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
        this.checkUserIsAdmin({user_id: record.get('id')}, function(result){
          if(!result){
            this.fireEvent('itemdblclick', view, record, e);
            return false;
          }
        }, this);
      });

      this.on('itemdblclick', function(view, record, e){
        this.checkUserIsAdmin({user_id: record.get('id')}, function(result){
          if(!result){
            this.onEditInForm();
          }
        }, this);
      }, this);
    }
  JS

  endpoint :check_user_is_admin do |params|
    result = false
    unless config[:login_user_is_admin]
      org_user = OrgUser.unscoped.find_by_user_id_and_org_id(params[:user_id], config[:org_id])
      result = org_user.admin? if org_user.present?
    end
    debug_log result
    {set_result: result}
  end

end