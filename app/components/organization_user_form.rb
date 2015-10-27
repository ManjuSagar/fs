class OrganizationUserForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "OrgStaff",
        items: (c[:login_user_is_admin]? [{name: :role_type, field_label: "Role Type", mode: 'local', store: OrgUser::ROLE_TYPES, xtype: 'combo'}] : []) +
            [{name: :first_name, field_label: "First Name"},
        {name: :last_name, field_label: "Last Name"},
        :email,
        {name: :password, inputType: 'password', allow_blank: false},
        {name: :password_confirmation, inputType: 'password', field_label: "Confirm Password", allow_blank: false},
        {name: :user_status, field_label: "Active?"}
        ],
        strong_default_attrs: (c[:strong_default_attrs].nil?? {org_id: c[:org_id]} : c[:strong_default_attrs].merge({org_id: c[:org_id]}))
   )
  end

end