class FieldStaffCredentialTypeList < Mahaswami::GridPanel

  def configuration
    super.merge(
      model: 'FieldStaffCredentialType',
      title:  "Field Staff Credential Types",
      columns: [
        { name: :ct_description, header: "Description", width: 170, editable: false},
        { name: :discipline__discipline_description, header: "Discipline", editable: false, width: "15%"},
        {name: :expiry_flag, header: "Will Expire?", editable: false, renderer: "uppercase" }
      ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Credential Type"
  action :edit_in_form, text: "Edit Credential Type"

  add_form_config         class_name: "FieldStaffCredentialTypeForm"
  add_form_window_config  title: "Add Credential Type", width: "30%", height: "30%"
  edit_form_config        class_name: "FieldStaffCredentialTypeForm"
  edit_form_window_config  title: "Edit Credential Type", width: "30%", height: "30%"

end