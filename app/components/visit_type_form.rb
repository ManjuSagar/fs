class VisitTypeForm < Mahaswami::FormPanel

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
            :license_types.component
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
