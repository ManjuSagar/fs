/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.AdlIadls3M1880M1890', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.adlIadls3M1880M1890',
    items: [
        {
            xtype: 'panel',
            border: 0,
            margin: 5,
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            items: [
                {
                    xtype: 'radiogroup',
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    fieldLabel: '(M1880) Current Ability to Plan and Prepare Light Meals (for example, cereal, sandwich) or reheat delivered meals'+
                    ' safely. ',
                    cls: 'oasis_blue',
                    itemId: 'plan_prep_meals',
                    width: "90%",
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            height: 30,
                            name: 'm1880_crnt_prep_lt_meals',
                            boxLabel: '0 - a) Able to independently plan and prepare all light meals for self or reheat delivered meals; OR (b) Is physically, cognitively, and mentally able to prepare light meals on a regular basis but has not routinely performed light meal preparation in the past (specifically: prior to this home care admission).',
                            inputValue: '00'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1880_crnt_prep_lt_meals',
                            boxLabel: '1 - Unable to prepare light meals on a regular basis due to physical, cognitive, or mental limitations.',
                            inputValue: '01'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1880_crnt_prep_lt_meals',
                            boxLabel: '2 - Unable to prepare any light meals or reheat any delivered meals.',
                            inputValue: '02'
                        }
                    ]
                },
                {
                    xtype: 'radiogroup',
                    layout: {
                        align: 'stretch',
                        type: 'vbox'
                    },
                    fieldLabel: '(M1890) Ability to Use Telephone: Current ability to answer the phone safely, including dialing numbers, and effectively using the telephone to communicate.',
                    cls: 'oasis_blue',
                    item_id: 'telephone_use',
                    width: "90%",
                    labelAlign: 'top',
                    items: [
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: '0 - Able to dial numbers and answer calls appropriately and as desired.',
                            inputValue: '00'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: '1 - Able to use a specially adapted telephone (for example, large numbers on the dial, teletype phone for the deaf) and call essential numbers.',
                            inputValue: '01'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: '2 - Able to answer the telephone and carry on a normal conversation but has difficulty with placing calls.',
                            inputValue: '02'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: '3 - Able to answer the telephone only some of the time or is able to carry on only a limited conversation.',
                            inputValue: '03'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: '4 - Unable to answer the telephone at all but can listen if assisted with equipment.',
                            inputValue: '04'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: '5 - Totally unable to use the telephone.',
                            inputValue: '05'
                        },
                        {
                            xtype: 'radiofield',
                            name: 'm1890_crnt_phone_use',
                            boxLabel: 'NA - Patient does not have a telephone.',
                            inputValue: 'NA'
                        }
                    ]
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();

        m1880Value = main.down("#adl_iadls3_m1880_m1890").query("[xtype=radiogroup]")[0];
        m1890Value = main.down("#adl_iadls3_m1880_m1890").query("[xtype=radiogroup]")[1];

        if(m1880Value.down("[name = m1880_crnt_prep_lt_meals]").getGroupValue() == null){
            errs.push(['M1880', "Select patient's ability to Plan and Prepare Light Meals also reheat delivered meals safely."]);
        }

        if(m1890Value.down("[name = m1890_crnt_phone_use]").getGroupValue() == null){
            errs.push(['M1890', "Select patient's current ability to Use Telephone."]);
        }

        return errs;
    }
})
