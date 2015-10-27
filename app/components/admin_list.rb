class AdminList < Mahaswami::GridPanel
  def configuration
    super.merge(
        model: "SuperAdmin",
        title: "Admins",
        columns: [
            {name: :first_name, header: "First Name", editable: false},
            {name: :last_name, header: "Last Name", editable: false},
            {name: :email, editable: false, width: 165}]

    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Admin"
  action :edit_in_form, text: "Edit Admin"

  add_form_config         class_name: "SuperAdminForm"
  add_form_window_config  title: "Add Admin"
  edit_form_config        class_name: "SuperAdminForm"
  edit_form_window_config  title: "Edit Admin"
  multi_edit_form_config  class_name: "SuperAdminForm"

end