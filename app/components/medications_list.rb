class MedicationsList < Mahaswami::Panel

  def configuration
    s = super
    component_session[:treatment_id] = s[:treatment_id] if s[:treatment_id]
    component_session[:header] = s[:header]
    s.merge(
        layout: :border,
        header: false,
        items:[
          :active_medications_list.component,
          :discontinued_medications_list.component
        ]
    )
  end

  component :active_medications_list do
    {
        class_name: "TreatmentMedications",
        region: :center,
        title: "Active Medications",
        scope: {treatment_id: component_session[:treatment_id], :medication_status => ['A', 'D']},
        parent_id: component_session[:treatment_id],
        treatment_id: component_session[:treatment_id],
        item_id: :active_medications_list,
        show_tool_bar: true,
        header: component_session[:header]
    }
  end

  component :discontinued_medications_list do
    {
        class_name: "TreatmentMedications",
        region: :south,
        title: "Discontinued Medications",
        height: 200,
        editOnDblClick: false,
        scope: {treatment_id: component_session[:treatment_id], :medication_status => 'F'},
        parent_id: component_session[:treatment_id],
        treatment_id: component_session[:treatment_id],
        bbar: [],
        context_menu: [],
        item_id: :discontinued_medications_list,
        show_tool_bar: false
    }
  end

end