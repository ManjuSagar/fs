class HealthAgencyGrid < Mahaswami::GridPanel

  def configuration
    super.merge(
      model: 'HealthAgency',
      add_form_window_config:{
        title: "Add Health Agency",
        header: false,
        autoWidth: false,
        autoHeight: false,
        width: 1100,
        height: 600,
        items: [{
          :class_name => 'HealthAgencyForm'
       }]

    },
      edit_form_window_config:{
        title: "Edit Health Agency",
        header: false,
        autoWidth: false,
        autoHeight: false,
        width: 1100,
        height: 600,
        items: [{
          :class_name => 'HealthAgencyForm'
        }]

    },
    columns: [
        {name: :agency_name, header: "Name"},
        {name: :agency_type, renderer: "uppercase", header: "Type"},
        {name: :provider_number, header: "Provider #"},
        :email,
        :contact
                ]
    )
  end

end
