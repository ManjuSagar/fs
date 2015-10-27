class Languages < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'Language',
        title: 'Languages',
        columns: [{name: :language_code, label: "Code", editable: false},
                  {name: :language_description, label: "Description", editable: false, width: "60%"}]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Language"
  action :edit_in_form, text: "Edit Language"
end