class StaffingMastersForm < Mahaswami::FormPanel
  # To change this template use File | Settings | File Templates.

  def configuration
    super.merge(
        model: "StaffingMaster",
        title: "Add Staffing",
        strong_default_attrs: {:staffable_type => "TreatmentRequest"},
        items: [
            {name: :staffable_id, field_label: "Patient", xtype: 'combo', store: PatientTreatment.all.collect{|x|[x.id, x.to_s ]}},
            :disciplines.component,
            :visit_types.component

    ]
    )
  end

  component :disciplines do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :disciplines,
        columns: 2
    }
  end

  component :visit_types do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        association: :visit_types,
        scope: :without_discipline
    }
  end
end