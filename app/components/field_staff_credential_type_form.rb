class FieldStaffCredentialTypeForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: 'FieldStaffCredentialType',
        title:  "Field Staff Credential Types",
        items: [
            {name: :ct_code, field_label: "Code"},
            {name: :ct_description, field_label: "Description"},
            {name: :discipline__discipline_description, field_label: "Discipline"},
            {name: :expiry_flag, width: 90, field_label: "Will Expire?", editable: false, renderer: "uppercase" }
        ]
    )
  end
end