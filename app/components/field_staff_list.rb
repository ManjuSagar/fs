class FieldStaffList < Mahaswami::GridPanel
  def configuration
    super.merge(
      model: "FieldStaff",
      title: "Field Staff",
      columns: [
        {name: :first_name, header: "First Name", editable: false},
        {name: :last_name, header: "Last Name", editable: false},
        {name: :license_type_description, header: "License Type", editable: false, width: "15%"},
        {name: :email, editable: false, width: "20%"},
        {name: :phone_number, editable: false, width: "20%", header: "Phone Numbers", getter: lambda{|r| r.phone_number_2 ? "#{r.phone_number}, #{r.phone_number_2}" : "#{r.phone_number}"}},
       ],
      scope: :org_scope

    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Field Staff"
  action :edit_in_form, text: "Edit Field Staff"

  add_form_config         class_name: "FieldStaffForm"
  add_form_window_config  title: "Add Field Staff", width: "50%", height: "66%"
  edit_form_config        class_name: "FieldStaffEditForm"
  edit_form_window_config  title: "Edit Field Staff", width: "50%", height: "66%"
  multi_edit_form_config  class_name: "FieldStaffEditForm"

end