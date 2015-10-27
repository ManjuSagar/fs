class FieldStaffDetails < Mahaswami::Panel

  def configuration
    c = super
    c.merge(
			header: false,
			border: false,
            items: [
                        {
                            xtype: 'panel',
                            layout: {
                                columns: 3,
                                type: 'table'
                            },
                            collapsed: false,
							collapsible: false,
                            border: false,
                            header: false,
                            items: [
                                {
                                    xtype: 'textfield',
                                    fieldLabel: 'Field Staff Name',
                                    name: "field_staff_name",
                                    editable: false,
                                    readOnly: true,
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'datefield',
                                    fieldLabel: 'VIsit Date:',
                                    name: "visit_date",
                                    editable: false,
                                    readOnly: true,
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'datefield',
                                    fieldLabel: 'Approved Date:',
                                    name: "approved_date",
                                    editable: false,
                                    readOnly: true,
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    fieldLabel: 'Time In',
                                    format: "H:i",
                                    name: "time_in",
                                    editable: false,
                                    readOnly: true,
                                    labelAlign: 'right'
                                },
                                {
                                    xtype: 'timefield',
                                    fieldLabel: 'Time Out',
                                    format: "H:i",
                                    name: "time_out",
                                    editable: false,
                                    readOnly: true,
                                    labelAlign: 'right'
                                }
                            ]
                        }
                    ]
    )

  end
  end
