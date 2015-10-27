class CaseManagers < Mahaswami::HasManyCollectionList

  def configuration
    c = super
    debug_log c
    c.merge(
        model: "InsuranceCaseManager",
        title: "Case Managers",
        columns: [
            {name: :first_name, label: "First Name"},
            {name: :last_name, label: "Last Name"},
            {name: :email, label: "Email"},
            {name: :phone_number, label: "Phone Number", input_mask: '(999) 999-9999'},
        ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form,  text: "", tooltip: "Add", icon: :add_new
  action :edit_in_form,  text: "", tooltip: "Edit", icon: :edit

  add_form_window_config title: "Add Insurance Case Manager"
  edit_form_window_config title: "Edit Insurance Case Manager"

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end
  
end