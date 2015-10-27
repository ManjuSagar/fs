class VisitTypeEditForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "VisitType",
        items: [
             {name: :visit_type_code, field_label: "Code"},
             {name: :visit_type_description, field_label: "Description"},
             {name: :discipline__discipline_description, field_label: "Discipline", editable: false},
             {name: :payable_rate, field_label: "Payable Rate"},
             {name: :optional_flag, field_label: "Optional?"},
             {name: :sort_order, field_label: "Sort Order"},
             :license_types.component,
             :details.component(
                 :name => :details,
                 :title => "Details",
                 :height => 240,
                 :class_name => "Netzke::Basepack::TabPanel",
                 :items => [
                   :document_definitions.component(
                       class_name: "Mahaswami::HasManyCollectionList",
                       association: "visit_type_document_definitions",
                       parent_model: "VisitType",
                       parent_id: session[:selected_visit_type_id],
                       columns: [{name: :document_definition__document_name, label: "Document Definition", editable: false, width: "50%", scope: :org_scope},
                                 {name: :mandatory_flag, label: "Mandatory?", editable: false, width: "25%"}],
                       bbar: [:add_in_form.action, :edit_in_form.action, :del.action],
                       context_menu: [:add_in_form.action, :edit_in_form.action, :del.action],
                       height: 300
                   ),
                   :state_transitions.component(
                       class_name: "Mahaswami::HasManyCollectionList",
                       association: "state_transitions",
                       parent_model: "VisitType",
                       edit_on_dbl_click: false,
                       parent_id: session[:selected_visit_type_id],
                       columns: [{name: :from_state, label: "From State", editable: true,  getter: lambda{|x| x.from_state.to_s.titleize}, editor: {store:VisitTypeStateTransition.states, xtype: :combo, mode: :local}},
                                 {name: :to_state, label: "To State", editable: true,  getter: lambda{|x| x.to_state.to_s.titleize}, editor: {store:VisitTypeStateTransition.states, xtype: :combo, mode: :local}}],
                       bbar: [:add_in_form.action, :edit_in_form.action, :del.action,:search.action],
                       xcontext_menu: [:add_in_form.action, :edit_in_form.action, :del.action],
                       height: 300
                   )

                 ]
              )
        ]
    )

  end
  component :license_types do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        columns: 2,
        association: :license_types
    }
  end

end
