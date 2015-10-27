class FormLibrary < Mahaswami::GridPanel
  def configuration
    super.merge(
      model: "DownloadableForm",
      title: "Uploads",
      columns: [
          {name: :form_name, label: "Name"},
          {name: :form_description, label: "Description"}] +
          ((User.current.is_a? FieldStaff) ? [{name: :agency_name, label: "Agency Name", editable: false, width: "15%"}] : []) +
          [{name: :form_content_updated_at, label: "Added Date",  format: 'm-d-Y'},
          {name: :form_content, label: "", getter: lambda{ |r| link_to("Download", r.form_content.url, :target => "_blank")}},
      ],
      scope: :org_scope
    )
  end
  action :add_in_form, text: "", tooltip: "Add Form", icon: :add_new
  action :edit_in_form, text: "", tooltip: "Edit Form", icon: :edit

  add_form_config class_name: "AddFormLibrary"
  edit_form_config class_name: "AddFormLibrary"

  add_form_window_config title: "Add Form"
  edit_form_window_config title: "Edit Form"

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action] if User.current.office_staff?
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action] if User.current.office_staff?
  end

end