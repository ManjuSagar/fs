class SuperAdminForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: "SuperAdmin",
        items: [
            {name: :first_name, field_label: "First Name"},
            {name: :last_name, field_label: "Last Name"},
            :email,
            {name: :password, inputType: 'password', allow_blank: false},
            {name: :password_confirmation,
             inputType: 'password',
             field_label: "Confirm Password", allow_blank: false}
        ]
    )
  end

end