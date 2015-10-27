/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.LivingArrangementsPoc', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.livingArrangementsPoc',
    layout: "hbox",
    items: [
        {
            flex: 1,
            xtype: "fieldset",
            minWidth: 400,
            title: "Caregiver(s)",
            height: 650,
            margin: 5,
            items: [
                {
                    xtype: "textfield",
                    labelAlign: "top",
                    isHeader: false,
                    name: "living_arrangement_caregiver_name",
                    fieldLabel: "Primary Caregiver (name)"
                },
                {
                    xtype: "textfield",
                    labelAlign: "top",
                    isHeader: false,
                    name: "living_arrangement_caregiver_phone_number",
                    fieldLabel: "Phone Number (if different from patient)"
                },
                {
                    xtype: "textfield",
                    labelAlign: "top",
                    isHeader: false,
                    name: "living_arrangement_relationship",
                    fieldLabel: "Relationship"
                },
                {
                    xtype: "textarea",
                    labelAlign: "top",
                    isHeader: false,
                    cols: 50,
                    name: "living_arrangement_other_caregivers",
                    fieldLabel: "List name/relationship of other caregiver(s) (other than home health staff)" +
                        " and the specific assistance they give with medical cares, ADLs, and/or IADLs"
                },
                {
                    xtype: 'checkboxgroup',
                    labelAlign: "top",
                    isHeader: false,
                    fieldLabel: "Able to safely care for patient",
                    items: [
                        {
                            xtype: 'checkboxfield',
                            name: "living_arrangement_safely_care",
                            boxLabel: 'Yes',
                            inputValue: 'Y'
                        },
                        {
                            xtype: 'checkboxfield',
                            name: "living_arrangement_safely_care",
                            boxLabel: 'No',
                            inputValue: 'N'
                        }
                    ]
                },
                {
                    xtype: "textarea",
                    labelAlign: "top",
                    cols: 50,
                    isHeader: false,
                    name: "living_arrangement_comments",
                    fieldLabel: "Comments"
                },
                {
                    xtype: "textarea",
                    labelAlign: "top",
                    cols: 50,
                    isHeader: false,
                    name: "living_arrangement_other_agencies",
                    fieldLabel: "Other agencies/co-ordination of care"
                }
            ]
        },
        {
            margin: 5,
            flex: 1,
            minWidth: 700,
            height: 650,
            border: false,
            items: [
                {
                    header: false,
                    layout: "hbox",
                    border: false,
                    items: [
                        {
                            xtype: "fieldset",
                            title: "Safety Measures",
                            flex: 1,
                            margin: 3,
                            items: [
                                {
                                    xtype: 'checkboxgroup',
                                    fieldLabel: "",
                                    labelAlign: "top",
                                    flex: 1,
                                    columns: 2,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "1 - Bleeding precautions",
                                            inputValue: "1"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "2 - O2 precautions",
                                            inputValue: "2"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "3 - Seizure precautions",
                                            inputValue: "3"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "4 - Fall precautions",
                                            inputValue: "4"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "5 - Aspiration precautions",
                                            inputValue: "5"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "6 - Siderails up",
                                            inputValue: "6"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "7 - Elevate head of bed",
                                            inputValue: "7"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "8 - 24 hr. supervision",
                                            inputValue: "8"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "9 - Clear pathways",
                                            inputValue: "9"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "10 - Lock w/c with transfers",
                                            inputValue: "10"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "11 - Walker",
                                            inputValue: "11"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "12 - Infection control measures",
                                            inputValue: "12"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "13 - cane",
                                            inputValue: "13"
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: "safety_measures",
                                            boxLabel: "14 - Other",
                                            inputValue: "14"
                                        },
                                        {
                                            xtype: "textfield",
                                            fieldLabel: "Other",
                                            labelWidth: 40,
                                            isHeader: false,
                                            name: "other_safety_measures"
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            flex: 1,
                            xtype: "fieldset",
                            margin: 3,
                            title: "Emergency planning/fire safety",
                            layout: {type: "vbox", align: "stretch"},
                            items: [
                                {
                                    xtype: "label",
                                    text: ""
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Fire extinguisher",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_fire_extinguisher",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_fire_extinguisher",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Smoke detectors on all levels of home",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_smoke_detectors",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_smoke_detectors",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Tested and functioning",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_tested_and_functioning",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_tested_and_functioning",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "More than one exit",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_more_than_one_exit",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_more_than_one_exit",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Plan for exit",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_plan_for_exit",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_plan_for_exit",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Plan for power failure",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_plan_for_power_failure",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "emergency_plan_for_power_failure",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    header: false,
                    layout: "hbox",
                    border: false,
                    items: [
                        {
                            flex: 1,
                            xtype: "fieldset",
                            layout: {type: "vbox", align: "stretch"},
                            title: "Safety hazards in the home",
                            margin: 3,
                            items: [
                                {
                                    xtype: "label",
                                    text: ""
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Unsound structure",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "unsound_structure",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "unsound_structure",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Inadequate heating/cooling/electricity",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_heating_cooling_electricity",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_heating_cooling_electricity",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Inadequate sanitation/plumbing",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_plumbing",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_plumbing",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Inadequate refrigeration",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_refrigeration",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_refrigeration",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Unsafe gas/electrical appliances or outlets",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "unsafe_gas_electrical_outlets",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "unsafe_gas_electrical_outlets",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Inadequate running water",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_running_water",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "inadequate_running_water",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Unsafe storage of supplies/equipment",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "unsafe_storage_of_equipment",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "unsafe_storage_of_equipment",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "No telephone available and/or unable to use phone",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "unable_to_use_phone",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "unable_to_use_phone",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Insects/rodents",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "insects",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "insects",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Medications stored safely",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "medications_stored_safely",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "medications_stored_safely",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            flex: 1,
                            xtype: "fieldset",
                            title: "Oxygen Use",
                            layout: {type: "vbox", align: "stretch"},
                            margin: 3,
                            items: [
                                {
                                    xtype: "label",
                                    text: ""
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Signs posted",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "oxygen_use_sign_posted",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "oxygen_use_sign_posted",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'radiogroup',
                                    labelWidth: 200,
                                    fieldLabel: "Handles smoking/flammables safely",
                                    isHeader: false,
                                    layout: "hbox",
                                    items: [
                                        {
                                            xtype: 'radiofield',
                                            name: "oxygen_use_handles_smoing_safely",
                                            boxLabel: "Y",
                                            margin: "0 5 0 0",
                                            inputValue: 'Y'
                                        },
                                        {
                                            xtype: 'radiofield',
                                            name: "oxygen_use_handles_smoing_safely",
                                            boxLabel: 'N',
                                            margin: "0 0 0 5",
                                            inputValue: 'N'
                                        }
                                    ]
                                },
                                {
                                    xtype: 'checkboxgroup',
                                    fieldLabel: "Oxygen back-up",
                                    isHeader: false,
                                    labelAlign: "top",
                                    columns: 3,
                                    items: [
                                        {
                                            xtype: 'checkboxfield',
                                            name: "living_arrangement_oxygen_backup",
                                            boxLabel: 'Available',
                                            inputValue: '1'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'living_arrangement_oxygen_backup',
                                            boxLabel: 'Knows how to use',
                                            inputValue: '2'
                                        },
                                        {
                                            xtype: 'checkboxfield',
                                            name: 'living_arrangement_oxygen_backup',
                                            boxLabel: 'Electrical /fire safety',
                                            inputValue: '3'
                                        }
                                    ]
                                },
                                {
                                    xtype: "textarea",
                                    cols: 50,
                                    isHeader: false,
                                    labelAlign: "top",
                                    fieldLabel: "Plan/Comments",
                                    name: "oxygen_use_plan_comments"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ]
})
