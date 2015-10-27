class FieldStaffVisitEditForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "TreatmentVisit",
        items: [
            {name: :discipline__to_s, field_label: "Patient & Discipline", read_only: true},
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
            },


    :details.component(
                :name => :details,
                :title => "Details",
                :height => 240,
                :class_name => "Netzke::Basepack::TabPanel",
                :items => [
                    :visit_docs.component(
                        height: 300,
                        class_name: "Mahaswami::HasManyCollectionList",
                        association: "documents",
                        parent_model: "TreatmentVisit",
                        parent_id: c[:visit_id],
                        item_id: :field_staff_visit_docs_grid,
                        columns: [{name: :document_date, label: "Date"},
                                  {name: :document_definition__document_name, label: "Name"},
                                  {name: :status, label: "Status", editable: false, :getter => lambda {|l|l.status.to_s.titleize}},
                                  action_column("field_staff_visit_docs_grid")],
                        bbar: [:add_in_form.action,:edit_in_form.action, :del.action],
                        context_menu: [:add_in_form.action,:edit_in_form.action, :del.action]
                    ),
                    :visit_attachments.component(
                        height: 300,
                        class_name: "Mahaswami::HasManyCollectionList",
                        association: "attachments",
                        parent_model: "TreatmentVisit",
                        parent_id: c[:visit_id],
                        columns: [ {name: :attachment_name, label: "Type"},
                                   {name: :attachment_file_name, label: "File Name"},
                                   { name: :attachment, label: "", getter: lambda{ |r| link_to("Download", r.attachment.url, :target => "_blank")}},

                        ],
                        add_form_config: {
                            file_upload: true,
                            class_name: "Mahaswami::FormPanel",
                            items:[
                                {name: :attachment_name, field_label: "Name"},
                                {name: :attachment, field_label: "Upload", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true}
                            ]},
                        bbar: [:add_in_form.action,:edit_in_form.action, :del.action],
                        context_menu: [:add_in_form.action,:edit_in_form.action, :del.action]
                    )],
                :width => "70%",
                :border => true,
                :active_tab => 0
            )
        ]
    )

  end
end
