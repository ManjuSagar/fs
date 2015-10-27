class StaffingCompanyCredentialTypeList < Mahaswami::GridPanel
  def configuration
    super.merge(
      model: 'StaffingCompanyCredentialType',
      title:  "Staffing Company Credential Types",
      columns: [
        {name: :ct_description, header: "Description", width: 170, editable: false},
        {name: :expiry_flag, width: 75, header: "Will Expire?", editable: false, renderer: "uppercase"}
      ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Credential"
  action :edit_in_form, text: "Edit Credential"
  
  add_form_config class_name: "StaffingCompanyCredentialTypeForm"
  add_form_window_config title: "Add Credential Type", width: "30%", height: "25%"
  edit_form_config class_name: "StaffingCompanyCredentialTypeForm"
  edit_form_window_config title: "Edit Credential Type", width: "30%", height: "25%"

end
