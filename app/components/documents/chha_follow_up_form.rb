# Custom user form (predefined model and layout)
class Documents::CHHAFollowUpForm < Documents::AbstractDocumentForm

  def configuration
    c = super
    @corresponding_eval = PatientTreatment.find(c[:treatment_id]).documents.find_all_by_document_type('ChhaCarePlan').last if c[:treatment_id]
    c.merge(
        model: "CHHAFollowup",
        freeFormTemplate: false,
        items:[
            {
                xtype: 'container',
                height: 768,
                width: 1024,
                layout: {
                    type: 'fit'
                },
                items: [
                    {
                        xtype: 'borderlessFormPanel',
                        style: 'color:green;',
                        layout: {
                            type: 'border'
                        },
                        bodyPadding: 10,
                        manageHeight: false,
                        title: '',
                        items: [
                            {
                                xtype: 'panel',
                                region: 'north',
                                border: 0,
                                layout: {
                                    type: 'fit'
                                },
                                items: [
                                    :patient_details.component
                                ]
                            },
                            {
                                xtype: 'tabpanel',
                                region: 'center',
                                margin: '5px',
                                activeTab: 0,
                                plain: true,
                                items: [
                                    {
                                        xtype: 'panel',
                                        height: 707,
                                        margin: '3px',
                                        layout: {
                                            type: 'anchor'
                                        },
                                        title: 'Activities',
                                        items: [                                            
                                                    {
                                                        xtype: 'panel',
                                                        border: 0,
                                                        height: 15,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'hbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'label',
                                                                weight: 2,
                                                                width: 51,
                                                                text: 'DONE'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                margin: '',
                                                                width: 283,
                                                                text: 'ASSIST WITH/PERFORM'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 25,
                                                                margin: '0 0 0 175px',
                                                                width: 51,
                                                                text: 'DONE'
                                                            },
                                                            {
                                                                xtype: 'label',
                                                                height: 25,
                                                                width: 200,
                                                                text: 'ASSIST WITH/PERFORM'
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: 0,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'hbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                margin: '0 0 0 0',
                                                                width: 508,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: 0,
                                                                        height: 492,
                                                                        width: 50,
                                                                        items: [
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                margin: '10px 0 0 0',
                                                                                width: 255,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'temp_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'pulse_rate_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        margin: '0 0 0 5px',
                                                                                        minHeight: 20,
                                                                                        name: 'respiratory_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        margin: '0 0 0 5px',
                                                                                        minHeight: 20,
                                                                                        name: 'blood_pressure_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        margin: '0 0 0 5px',
                                                                                        minHeight: 20,
                                                                                        name: 'toileting_activities_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        margin: '0 0 0 5px',
                                                                                        minHeight: 20,
                                                                                        name: 'shower_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'tub_bath_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'bed_bath_partial_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'bed_bath_complete_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'bed_bath_sponge_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'deodorant_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'dressing_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'denture_care_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'oral_care_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'hair_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'shave_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'makeup_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'nail_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'foot_care_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        flex: 1,
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'skin_care_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: 0,
                                                                        height: 639,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                margins: '10px 0 0 0',
                                                                                height: 20,
                                                                                width: 325,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                fieldLabel: 'Check Temperature',
                                                                                labelWidth: 125,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'temp',
                                                                                        boxLabel: 'Oral',
                                                                                        inputValue: 'Oral'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        margin: '0 2px 0 3px',
                                                                                        name: 'temp',
                                                                                        boxLabel: 'Axiliary',
                                                                                        inputValue: 'Axiliary'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        name: 'temp',
                                                                                        labelWidth: 120,
                                                                                        boxLabel: 'Rectal ',
                                                                                        inputValue: 'Rectal'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                margin: '0px 0 0 0',
                                                                                text: 'Check Pulse'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                margin: '0 0 3px 0',
                                                                                text: 'Check Respiration'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                margin: '0 0 4px 0',
                                                                                text: 'Check Blood Pressure'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                margin: '0 0 3px 0',
                                                                                text: 'Toileting Activities'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                margin: '0 0 4px 0',
                                                                                text: 'Bathing: Shower (please use a shower chair)'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Bathing: Tub'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Bathing: Bed Partial '
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                margin: '0 0 1px 0',
                                                                                text: 'Bathing: Bed Complete '
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Bathing: Bed Sponge '
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Appling Deodorant'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Dressing and Undressing'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Denture Care'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Brushing Teeth'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Brushing/Combing Hair'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 20,
                                                                                text: 'Shaving'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Appling Makeup'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Nail Hygiene'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                width: 269,
                                                                                text: 'Foot Care'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Skin Care'
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'panel',
                                                                border: 0,
                                                                width: 535,
                                                                layout: {
                                                                    align: 'stretch',
                                                                    type: 'hbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: 0,
                                                                        height: 495,
                                                                        width: 51,
                                                                        items: [
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                height: 25,
                                                                                margin: '',
                                                                                width: 245,
                                                                                autoScroll: true,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 20,
                                                                                        margin: '3px 0 0 5px',
                                                                                        name: 'back_rub_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                height: 24,
                                                                                width: 270,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 24,
                                                                                        margin: '5px 0 0 5px',
                                                                                        name: 'grocery_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        margin: '5px 0 0 5px',
                                                                                        name: 'meal_preparation_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '2px 0 0 5px',
                                                                                        name: 'ast_feeding_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'self_medications_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'cha_bed_linen_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'laundry_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'cln_liv_area_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 30,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'amb_assist_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                margin: '0 0 0 0',
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'transfers_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'rom_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 214,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'excercise_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                width: 225,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'positioning_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                margin: '25px 0 0 0 ',
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 22,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'infection_control_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                height: 22,
                                                                                margin: '18px 0 0 0 ',
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'clr_path_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                height: 25,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 20,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'othr_text1_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 30,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'othr_text2_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 25,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'othr_text3_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        height: 30,
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'othr_text4_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'panel',
                                                                                border: 0,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        margin: '0 0 0 5px',
                                                                                        name: 'othr_text5_done',
                                                                                        fieldLabel: '',
                                                                                        boxLabel: ''
                                                                                    }
                                                                                ]
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: 0,
                                                                        height: 630,
                                                                        margin: '7px 0 0 0',
                                                                        width: 279,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 23,
                                                                                margin: '0 0 2px 0',
                                                                                text: 'Back Rub'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                margin: '0 0 3px 0',
                                                                                height: 20,
                                                                                text: 'Grocery Shopping'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                margin: '0 0 3px 0',
                                                                                height: 22,
                                                                                text: 'Meal Preparation'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                margin: '0 0 3px 0',
                                                                                text: 'Feeding'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Self-Administaration of Medications'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Changing Bed Linens'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Laundry'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 22,
                                                                                text: 'Cleaning Living Areas'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxgroup',
                                                                                fieldLabel: 'Amb. Assist',
                                                                                labelWidth: 80,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'amb_assist',
                                                                                        boxLabel: 'W/c',
                                                                                        inputValue: 'W/C'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'amb_assist',
                                                                                        boxLabel: 'Walker',
                                                                                        inputValue: 'Walker'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'amb_assist',
                                                                                        boxLabel: 'Cane',
                                                                                        inputValue: 'Cane'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 18,
                                                                                margin: '0 0 3px 0',
                                                                                text: 'Transfers'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxgroup',
                                                                                height: 20,
                                                                                fieldLabel: 'ROM',
                                                                                labelWidth: 50,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'rom',
                                                                                        boxLabel: 'Active',
                                                                                        inputValue: 'Active'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'rom',
                                                                                        boxLabel: 'Passive',
                                                                                        inputValue: 'Passive'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 18,
                                                                                width: 315,
                                                                                text: 'PT/OT Ordered Exercises'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxgroup',
                                                                                width: 279,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                fieldLabel: 'Positioning: Turn each hour',
                                                                                labelAlign: 'top',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: "position",
                                                                                        boxLabel: 'Encourage',
                                                                                        inputValue: 'Encourage'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: "position",
                                                                                        margin: '0 0 10px 2px',
                                                                                        boxLabel: 'Assist',
                                                                                        inputValue: 'Assist'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxgroup',
                                                                                height: 40,
                                                                                width: 276,
                                                                                layout: {
                                                                                    align: 'stretch',
                                                                                    type: 'hbox'
                                                                                },
                                                                                fieldLabel: 'Infection Control',
                                                                                labelAlign: 'top',
                                                                                labelPad: 1,
                                                                                labelWidth: 50,
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'infection_control',
                                                                                        boxLabel: 'Hand washing ',
                                                                                        inputValue: 'Hand Washing'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        margin: '0 2px 0 2px',
                                                                                        name: 'infection_control',
                                                                                        boxLabel: 'Gloves',
                                                                                        inputValue: 'Gloves'
                                                                                    },
                                                                                    {
                                                                                        xtype: 'checkboxfield',
                                                                                        name: 'infection_control',
                                                                                        boxLabel: 'Mask',
                                                                                        inputValue: 'Mask'
                                                                                    }
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 25,
                                                                                margin: "5 0 0 0",
                                                                                text: 'Clear Pathways'
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 27,
                                                                                item_id: :other1_text,
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 27,
                                                                                item_id: :other2_text,
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 27,
                                                                                item_id: :other3_text,
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 27,
                                                                                item_id: :other4_text,
                                                                            },
                                                                            {
                                                                                xtype: 'label',
                                                                                height: 27,
                                                                                item_id: :other5_text,
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        height: 300,
                                        itemId: 'notes_and_comments_panel',
                                        margin: '7px',
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Notes and Comments',
                                        items: [
                                            {
                                                xtype: 'textareafield',
                                                margins: '5px 5px 0 0 ',
                                                height: 58,
                                                name: 'notes_and_comments',
                                                fieldLabel: 'Notes and Comments',
                                                labelAlign: 'right',
                                                cols: 100
                                            }]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    )
  end

  def fields
    itms = super
    itms.each_pair do |k, v|
      field_prefix = k.to_s.gsub('_done', '')
      if (field_prefix != k.to_s and @corresponding_eval)
        result = @corresponding_eval.assist_enabled?(field_prefix)
        itms[k][:disabled] = !result
      end
    end
    itms
  end



  js_method :init_component, <<-JS
    function(){
      this.callParent();
      this.getOtherTextValues({}, function(values){        
        Ext.each(values, function(value, index){
          this.down("#other"+(index+1)+"_text").setText(value);
        }, this);
      }, this);
    }
  JS

  endpoint :get_other_text_values do |params|
    values = []
    5.times.each{|i|
      values << @corresponding_eval.send("other#{i+1}_text")
    }
    {set_result: values}
  end

end
