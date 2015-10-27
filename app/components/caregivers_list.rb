class CaregiversList < Mahaswami::HasManyCollectionList
  association "patient_caregivers"
  title "Caregivers"
  parent_model "Patient"


    def configuration
      super.merge(
          columns: [{name: :caregiver__full_name, label: 'Name'},
                    {name: :relation_to_patient, label: 'Relationship', width: 130},
                    {name: :caregiver__phone_number, label: "Phone Number",width: 150}
          ]
      )
    end

    action :add_in_form, text: "", tooltip: "Add Caregiver"
    action :edit_in_form, text: "", tooltip: "Edit Caregiver"
    add_form_config class_name: "CaregiverForm"
    edit_form_config class_name: "CaregiverForm"
    add_form_window_config width:"25%", height: "30%", title: "Add Caregiver"
    edit_form_window_config width:"25%", height: "30%", title: "Edit Caregiver"


    def default_bbar
      [:add_in_form.action, :edit_in_form.action, :del.action]
    end

    def default_context_menu
      [:add_in_form.action, :edit_in_form.action, :del.action]
    end
end