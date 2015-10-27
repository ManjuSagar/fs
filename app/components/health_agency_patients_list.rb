class HealthAgencyPatientsList < Mahaswami::HasManyCollectionList
  parent_model "HealthAgency"
  association "patients"
  parent_id  Org.last.id

  def configuration
    super.merge(
        columns: [
            {name: :first_name, header: "First Name", editable: false},
            {name: :last_name, header: "Last Name", editable: false}

        ]
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Medication"
  action :edit_in_form, text: "Edit Medication"

end