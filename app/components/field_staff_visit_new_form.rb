class FieldStaffVisitNewForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "TreatmentVisit",
        title: "New Visit",
            items: [
            {name: :discipline__to_s, field_label: "Patient & Discipline"},
            {name: :treatment_episode__certification_period, field_label: "Episode"},
            {name: :visit_type__visit_type_description, field_label: "Visit Type"},
            {name: :visit_start_time, field_label: "Start Time"},
            {name: :visit_end_time, field_label: "End Time"},
            {name: :frequency_string, field_label: "Frequency"},

                {
                    xtype: 'panel',
                    autoScroll: true,
                    border: false,
                    layout: {
                       type: 'accordion',
                       fill: false,
                    },
                    items: [
                        {
                            xtype: 'panel',
                            title: "Vitals",
                            border: false,
                            collapsed: true,
                            items: [
                            {name: :systolic_bp, field_label: "Systolic BP", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false, margin: '5 0 5 0'},
                            {name: :diastolic_bp, field_label: "Diastolic BP", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :bp_read_location,  field_label: 'BP Read Location', xtype: :combo, store: TreatmentVital::BP_LOCATION, editable: false},
                            {name: :bp_read_position, field_label: 'BP Read Position', xtype: :combo, store: TreatmentVital::BP_POSITION, editable: false },
                            {name: :heart_rate, field_label: "Heart Rate", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :respiration_rate, field_label: "Respiration Rate", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :temperature_in_fht, field_label: "Temperature(&degF)", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :blood_sugar, field_label: "Blood Sugar", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :sugar_read_period, field_label: "Sugar Read Period", xtype: :combo, store:TreatmentVital::SUGAR_READ_PERIOD, editable: false },
                            {name: :weight_in_lbs, field_label: "Weight(lbs)", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :oxygen_saturation, field_label: "Oxygen Saturation", xtype: 'numberfield', hideTrigger: true, mouseWheelEnabled: false},
                            {name: :pain, field_label: "Pain", xtype: 'numberfield'},

                            ]
                            }
                     ]
                }



        ],
        strong_default_attrs: {visited_user_id: User.current.id}
    )

  end

  def get_combobox_options_endpointx(params)
  end
end
