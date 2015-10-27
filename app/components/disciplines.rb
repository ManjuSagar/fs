class Disciplines < Mahaswami::GridPanel

  def configuration
    super.merge(
        model: 'Discipline',
        title: 'Disciplines',
        columns: [{name: :discipline_code, label: "Code", editable: false},
                  {name: :discipline_description, label: "Description", editable: false, width: "20%"},
                  {name: :sort_order, label: "Sort Order", editable: false, width: "20%"}
                 ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Discipline"
  action :edit_in_form, text: "Edit Discipline"
end