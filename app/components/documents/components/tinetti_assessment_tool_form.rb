class Documents::Components::TinettiAssessmentToolForm < Mahaswami::Panel

  def configuration
    super.merge(
                layout: {type: 'fit'},
                items: [
                    {
                        xtype: 'panel',
                        border: 0,
                        autoScroll: true,
                        layout: {
                            type: 'border'
                        },
                        bodyPadding: '10px',
                        items: [
                            {
                                xtype: 'tabpanel',
                                region: 'center',
                                activeTab: 0,
                                deferredRender: false,
                                plain: true,
                                items: [
                                    {
                                        xtype: 'panel',
                                        itemId: 'balance_panel',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Balance',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                padding: '5 5 0 10px',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'label',
                                                        cls: 'heading',
                                                        text: 'BALANCE'
                                                    },
                                                    {
                                                        xtype: 'label',
                                                        text: '(Pt. seated in hard, armless chair. Test the following maneuvers)'
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                autoScroll: true,
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        border: 0,
                                                        height: 520,
                                                        autoScroll: true,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'vbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: '2px',
                                                                autoScroll: false,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '1. Sitting Balance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        autoScroll: false,
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'sitting_balance',
                                                                                boxLabel: 'Leans or slides in chair (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'sitting_balance',
                                                                                boxLabel: 'Steady, Safe (1)',
                                                                                inputValue: 1
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: '2px',
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '2. Arises'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'arises',
                                                                                boxLabel: 'Unable without help (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'arises',
                                                                                boxLabel: 'Able, uses arms to help (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'arises',
                                                                                boxLabel: 'Able without using arms (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margins: '',
                                                                margin: '2px',
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '3. Attempts to Arise'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'attempts_to_arise',
                                                                                boxLabel: 'Unable without help (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'attempts_to_arise',
                                                                                boxLabel: 'Able, requires >1 attempt (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'attempts_to_arise',
                                                                                boxLabel: 'Able to arise, 1 attempt (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: '2px',
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '4. Immediate Standing Balance (first 5 sec.)'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'immediate_standing_balance',
                                                                                boxLabel: 'Unsteady (swaggers, moves feet, trunk sways) (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'immediate_standing_balance',
                                                                                boxLabel: 'Steady, but uses walker or other support (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'immediate_standing_balance',
                                                                                boxLabel: 'Steady without support (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: '2px',
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '5. Standing Balance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'standing_balance',
                                                                                boxLabel: 'Unsteady (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'standing_balance',
                                                                                boxLabel: 'Steady, but wide stance (medial . heels > 4" apart) & uses cane Or other support (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'standing_balance',
                                                                                boxLabel: 'Narrow stance without support (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        border: 0,
                                                        height: 520,
                                                        autoScroll: true,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'vbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '6. Nudged (subject at max position with feet as close together as possible, examiner pushes lightly on pt. sternum with palm of hand 3x)'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'nudged',
                                                                                boxLabel: 'Begins to fall (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'nudged',
                                                                                boxLabel: 'Staggers, grabs, catches self (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'nudged',
                                                                                boxLabel: 'Steady (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '7. Eyes Closed (at max position #6)'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'eyes_closed',
                                                                                boxLabel: 'Unsteady (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'eyes_closed',
                                                                                boxLabel: 'Steady (1)',
                                                                                inputValue: 1
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '8. Turning 360 degrees'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'turning_360_degrees',
                                                                                boxLabel: 'Discontinuous steps (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'turning_360_degrees',
                                                                                boxLabel: 'Continuous (1)',
                                                                                inputValue: 1
                                                                            },


                                                                        ]
                                                                    },{
                                                                    xtype: 'radiogroup',
                                                                    margin: "0 0 0 10px",
                                                                    layout: {
                                                                        type: 'anchor'
                                                                    },
                                                                    fieldLabel: '',
                                                                    labelAlign: 'top',
                                                                    items: [
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            score: 0,
                                                                            name: 'turning_360_degrees_b',
                                                                            boxLabel: 'Unsteady (grabs, staggers) (0)',
                                                                            inputValue: 0,
                                                                        },
                                                                        {
                                                                            xtype: 'radiofield',
                                                                            score: 1,
                                                                            name: 'turning_360_degrees_b',
                                                                            boxLabel: 'Steady (1)',
                                                                            inputValue: 1
                                                                        }
                                                                    ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '9. Sitting Down'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'sitting_down',
                                                                                boxLabel: 'Unsafe (misjudged distance, falls into chair) (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'sitting_down',
                                                                                boxLabel: 'Uses arms or not a smooth motion (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'sitting_down',
                                                                                boxLabel: 'Safe, smooth motion (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
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
                                        itemId: 'gait_panel',
                                        autoScroll: true,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'Gait',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                padding: '5 5 0 10px',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'vbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'label',
                                                        flex: 1,
                                                        cls: 'heading',
                                                        text: 'GAIT'
                                                    },
                                                    {
                                                        xtype: 'label',
                                                        flex: 1,
                                                        text: '(Pt. walks first at usual pace, then back at "rapid, but safe" pace using usual assistive device)'
                                                    }
                                                ]
                                            },
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                itemId: 'gait_panels',
                                                layout: {
                                                    align: 'stretch',
                                                    type: 'hbox'
                                                },
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        border: 0,
                                                        itemId: 'gait_panel1',
                                                        autoScroll: true,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'vbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '10. Initiation of Gait (immediately after told to "go")'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'initiation_of_gait',
                                                                                boxLabel: 'Any hesitancy or multiple attempts to start (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'initiation_of_gait',
                                                                                boxLabel: 'No hesitancy (1)',
                                                                                inputValue: 1
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '11. Step Length and Height'
                                                                    },
                                                                    {
                                                                        xtype: 'fieldset',
                                                                        margin: 2,
                                                                        title: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'label',
                                                                                cls: 'heading',
                                                                                text: 'A. Right swing foot'
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                layout: {
                                                                                    type: 'anchor'
                                                                                },
                                                                                fieldLabel: '',
                                                                                labelAlign: 'right',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 0,
                                                                                        name: 'right_swing_foot',
                                                                                        boxLabel: 'Does not pass left stance foot with step (0)',
                                                                                        inputValue: 0
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 1,
                                                                                        name: 'right_swing_foot',
                                                                                        boxLabel: 'Passes left stance foot (1)',
                                                                                        inputValue: 1
                                                                                    },
                                                                                ]
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                margin: "0 0 0 10px",
                                                                                layout: {
                                                                                    type: 'anchor'
                                                                                },
                                                                                fieldLabel: '',
                                                                                labelAlign: 'right',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 0,
                                                                                        name: 'right_swing_foot_b',
                                                                                        boxLabel: 'Right foot does not clear floor completely with step (0)',
                                                                                        inputValue: 0
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 1,
                                                                                        name: 'right_swing_foot_b',
                                                                                        boxLabel: 'Right foot completely clears floor (1)',
                                                                                        inputValue: 1
                                                                                    }
                                                                                ]
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'fieldset',
                                                                        margin: 2,
                                                                        title: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'label',
                                                                                cls: 'heading',
                                                                                text: 'B. Left swing foot'
                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                layout: {
                                                                                    type: 'anchor'
                                                                                },
                                                                                fieldLabel: '',
                                                                                labelAlign: 'right',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 0,
                                                                                        name: 'left_swing_foot',
                                                                                        boxLabel: 'Does not pass right stance foot with step (0)',
                                                                                        inputValue: 0
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 1,
                                                                                        name: 'left_swing_foot',
                                                                                        boxLabel: 'Passes right stance foot (1)',
                                                                                        inputValue: 1
                                                                                    },
                                                                                 ]

                                                                            },
                                                                            {
                                                                                xtype: 'radiogroup',
                                                                                margin: "0 0 0 10px",
                                                                                layout: {
                                                                                    type: 'anchor'
                                                                                },
                                                                                fieldLabel: '',
                                                                                labelAlign: 'right',
                                                                                items: [
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 0,
                                                                                        name: 'left_swing_foot_b',
                                                                                        boxLabel: 'Left foot does not clear floor completely with step (0)',
                                                                                        inputValue: 0
                                                                                    },
                                                                                    {
                                                                                        xtype: 'radiofield',
                                                                                        score: 1,
                                                                                        name: 'left_swing_foot_b',
                                                                                        boxLabel: 'Left foot completely clears floor (1)',
                                                                                        inputValue: 1
                                                                                    }
                                                                                ]
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '12. Step symmetry'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        labelAlign: 'top',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'step_symmetry',
                                                                                boxLabel: 'Right and left step length not equal(estimate) (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'step_symmetry',
                                                                                boxLabel: 'Right and left step appear equal (1)',
                                                                                inputValue: 1
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        flex: 1,
                                                        border: 0,
                                                        itemId: 'gait_panel2',
                                                        autoScroll: true,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'vbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '13. Step Continuity'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'step_continuity',
                                                                                boxLabel: 'Stopping or discontinuity between steps (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'step_continuity',
                                                                                boxLabel: 'Steps appear continuous (1)',
                                                                                inputValue: 1
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '14. Path (estimated in relation to floor tiles, 12" diameter, observe excursion of 1\' over about 10\' of the course)'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'path',
                                                                                boxLabel: 'Marked deviation (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'path',
                                                                                boxLabel: 'Mid/moderate deviation or uses walking aid (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'path',
                                                                                boxLabel: 'Straight without walking aid (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '15. Trunk'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'trunk',
                                                                                boxLabel: 'Marked sway or uses walking aid (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'trunk',
                                                                                hideLabel: false,
                                                                                boxLabel: 'No sway but flexion of knees or back, or spreads arms out while walking (1)',
                                                                                inputValue: 1
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 2,
                                                                                name: 'trunk',
                                                                                boxLabel: 'No sway, no flexion, no arms, no aid (2)',
                                                                                inputValue: 2
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                margin: 2,
                                                                title: '',
                                                                items: [
                                                                    {
                                                                        xtype: 'label',
                                                                        cls: 'heading',
                                                                        text: '16. Walking Stance'
                                                                    },
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        layout: {
                                                                            type: 'anchor'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 0,
                                                                                name: 'walking_stance',
                                                                                boxLabel: 'Heels apart (0)',
                                                                                inputValue: 0
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                score: 1,
                                                                                name: 'walking_stance',
                                                                                boxLabel: 'Heels almost touching while walking (1)',
                                                                                inputValue: 1
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
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
                                xtype: 'fieldset',
                                region: 'south',
                                height: 143,
                                autoScroll: true,
                                layout: {
                                    align: 'stretch',
                                    type: 'vbox'
                                },
                                title: 'Total Score',
                                items: [
                                    {
                                        xtype: 'panel',
                                        flex: 1,
                                        border: 0,
                                        layout: {
                                            align: 'middle',
                                            type: 'hbox'
                                        },
                                        items: [
                                            {
                                                xtype: 'textfield',
                                                flex: 1,
                                                itemId: 'balance_score',
                                                name: 'balance_score',
                                                readOnly: true,
                                                fieldLabel: 'Balance score',
                                                labelAlign: 'right'
                                            },
                                            {
                                                xtype: 'label',
                                                flex: 0.3,
                                                text: '/16'
                                            },
                                            {
                                                xtype: 'label',
                                                flex: 3,
                                                text: '(11/16 indicates risk for falls on balance subscale).'
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        flex: 1,
                                        border: 0,
                                        layout: {
                                            align: 'middle',
                                            type: 'hbox'
                                        },
                                        items: [
                                            {
                                                xtype: 'textfield',
                                                flex: 1,
                                                itemId: 'gait_score',
                                                name: 'gait_score',
                                                readOnly: true,
                                                fieldLabel: 'Gait score',
                                                labelAlign: 'right'
                                            },
                                            {
                                                xtype: 'label',
                                                flex: 0.3,
                                                text: '/12'
                                            },
                                            {
                                                xtype: 'label',
                                                flex: 3,
                                                text: '(total score <19 high fall risk, 19-24 medium fall risk, 25-28 low fall risk).'
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        flex: 1,
                                        border: 0,
                                        layout: {
                                            align: 'middle',
                                            type: 'hbox'
                                        },
                                        items: [
                                            {
                                                xtype: 'textfield',
                                                flex: 1.3,
                                                itemId: 'total_score',
                                                name: 'total',
                                                readOnly: true,
                                                fieldLabel: 'TOTAL',
                                                labelAlign: 'right'
                                            },
                                            {
                                                xtype: 'label',
                                                flex: 0.3,
                                                text: '/28'
                                            },
                                            {
                                                xtype: 'textfield',
                                                flex: 2,
                                                name: 'rater',
                                                fieldLabel: 'Rater',
                                                labelAlign: 'right'
                                            },
                                            {
                                                xtype: 'label',
                                                flex: 2,
                                                text: ''
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        flex: 1,
                                        border: 0,
                                        items: [
                                            {
                                                xtype: 'button',
                                                itemId: 'calculate_score',
                                                width: 100,
                                                text: 'Calculate Score'
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

end