class StaffingCompanyCredentialTypeForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: 'StaffingCompanyCredentialType',
        title:  "Staffing Company Credential Types",
        items: [
            {name: :ct_code, field_label: "Code"},
            {name: :ct_description, field_label: "Description"},
            {name: :expiry_flag, width: 90, field_label: "Will Expire?", editable: false, renderer: "uppercase" }
        ]
    )
  end
end
