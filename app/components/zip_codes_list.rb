class ZipCodesList < Mahaswami::GridPanel

  def configuration
    super.merge(
      model: 'ZipCode',
      title:  'Zip Codes',
        columns: [
          {name: :locality, header: "Locality", editable: false},
          {name: :zip_code, header: "Zip Code", editable: false}

        ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Zip Code"
  action :edit_in_form, text: "Edit Zip Code"
end