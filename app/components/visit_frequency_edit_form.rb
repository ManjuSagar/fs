class VisitFrequencyEditForm < Mahaswami::FormPanel

  def configuration
    c = super

    c.merge(
        model: "VisitFrequency",
        layout: :border,
        items: [{
            xtype: :fieldset,
            region: :center,
            auto_scroll: true,
            items: [{name: :discipline__to_s, field_label: "Patient & Discipline", read_only: true},
            {name: :treatment_episode__certification_period, field_label: "Episode", editable: false},
            {name: :frequency_string, field_label: "Frequency", read_only: true},
            {name: :frequency_start_date, field_label: "Start Date"},
            {name: :frequency_end_date, field_label: "End Date"}]
                },

:frequency_details.component(
                               class_name: "FrequencyDetails",
                               association: "frequency_details",
                               parent_model: "VisitFrequency",
                               parent_id: c[:record_id],
                               item_id: :frequency_detail_grid,
                               height: 200,
                               region: :south,
                               auto_scroll: true
                           )

        ]
    )

  end
end