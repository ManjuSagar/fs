class LicenseTypesList < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'LicenseType',
        title: 'License Types',
        columns: [{name: :license_type_code, label: "Code", editable: false},
                  {name: :license_type_description, label: "Description", editable: false, width: "20%"},
                  {name: :independent_flag, label: "Is Independent?", editable: false, width: "10%"},
                  {name: :discipline__discipline_description, label: "Discipline", editable: false, width: "20%"}]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add License Type"
  action :edit_in_form, text: "Edit License Type"


end