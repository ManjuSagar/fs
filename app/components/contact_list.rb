class ContactList < Mahaswami::HasManyCollectionList
  association 'contacts'
  parent_model 'Org'

  def configuration
    super.merge(
      model: 'OrgContact',
      title: 'Contacts',
      columns: [
        {name: :contact_first_name, header: 'First Name', editable: false},
        {name: :contact_last_name, header: 'Last Name', editable: false},
        {name: :phone_number, header: 'Phone Number', editable: false},
        {name: :extension, editable: false},
        {name: :email, editable: false, width: 165}
      ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "", tooltip: "Add Contact"
  action :edit_in_form, text: "", tooltip: "Edit Contact"

  add_form_config         class_name: "OrgContactForm"
  edit_form_config        class_name: "OrgContactForm"
  multi_edit_form_config  class_name: "OrgContactForm"

end