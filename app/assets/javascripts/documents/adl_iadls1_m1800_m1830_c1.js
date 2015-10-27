/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.AdlIadls1M1800M1830C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.adlIadls1M1800M1830C1',
    items: [
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1800) Grooming: Current ability to tend safely to personal hygiene needs (specifically: washing face and hands,'+
            ' hair care, shaving or make up, teeth or denture care, or fingernail care).',
            cls: 'oasis_blue',
            itemId: 'grooming1',
            width: "90%",
            labelAlign: 'top',
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1800_crnt_grooming',
                    boxLabel: '0 - Able to groom self unaided, with or without the use of assistive devices or adapted methods.',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1800_crnt_grooming',
                    boxLabel: '1 - Grooming utensils must be placed within reach before able to complete grooming activities.',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1800_crnt_grooming',
                    boxLabel: '2 - Someone must assist the patient to groom self.',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1800_crnt_grooming',
                    boxLabel: '3 - Patient depends entirely upon someone else for grooming needs.',
                    inputValue: '03'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1810) Current Ability to Dress Upper Body safely (with or without dressing aids) including undergarments, pullovers, front-opening shirts and blouses, managing zippers, buttons, and snaps',
            cls: 'oasis_pink',
            itemId: 'dress_upr_body',
            width: "90%",
            labelAlign: 'top',
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1810_crnt_dress_upper',
                    boxLabel: '0 - Able to get clothes out of closets and drawers, put them on and remove them from the upper body without assistance.',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1810_crnt_dress_upper',
                    boxLabel: '1 - Able to dress upper body without assistance if clothing is laid out or handed to the patient.',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1810_crnt_dress_upper',
                    boxLabel: '2 - Someone must help the patient put on upper body clothing.',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1810_crnt_dress_upper',
                    boxLabel: '3 - Patient depends entirely upon another person to dress the upper body.',
                    inputValue: '03'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M1820) Current Ability to Dress Lower Body safely (with or without dressing aids) including undergarments, slacks, socks or nylons, shoes',
            cls: 'oasis_pink',
            itemId: 'dress_lwr_body',
            width: "90%",
            labelAlign: 'top',
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1820_crnt_dress_lower',
                    boxLabel: '0 - Able to obtain, put on, and remove clothing and shoes without assistance.',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1820_crnt_dress_lower',
                    boxLabel: '1 - Able to dress lower body without assistance if clothing and shoes are laid out or handed to the patient.',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1820_crnt_dress_lower',
                    boxLabel: '2 - Someone must help the patient put on undergarments, slacks, socks or nylons, and shoes.',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1820_crnt_dress_lower',
                    boxLabel: '3 - Patient depends entirely upon another person to dress lower body. ',
                    inputValue: '03'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'

            },
            fieldLabel: '(M1830) Bathing: Current ability to wash entire body safely. Excludes grooming (washing face, washing hands, and shampooing hair).',
            cls: 'oasis_pink',
            itemId: 'wash_body',
            width: "90%",
            labelAlign: 'top',
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm1830_crnt_bathg',

                    boxLabel: '0 - Able to bathe self in shower or tub independently, including getting in and out of tub/shower.',
                    inputValue: '00'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1830_crnt_bathg',
                    boxLabel: '1 - With the use of devices, is able to bathe self in shower or tub independently, including getting in and out of the tub/shower.',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    height: 30,
                    name: 'm1830_crnt_bathg',
                    boxLabel: '2 - Able to bathe in shower or tub with the intermittent assistance of another person: (a) for intermittent supervision or encouragement or reminders, OR (b) to get in and out of the shower or tub, OR (c) for washing difficult to reach areas.',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1830_crnt_bathg',
                    boxLabel: '3 - Able to participate in bathing self in shower or tub, but requires presence of another person throughout the bath for assistance or supervision.',
                    inputValue: '03'

                },
                {
                    xtype: 'radiofield',
                    name: 'm1830_crnt_bathg',
                    boxLabel: '4 - Unable to use the shower or tub, but able to bathe self independently with or without the use of devices at the sink, in chair, or on commode.',
                    inputValue: '04'
                },
                {
                    xtype: 'radiofield',
                    height: 30,
                    name: 'm1830_crnt_bathg',
                    boxLabel: '5 - Unable to use the shower or tub, but able to participate in bathing self in bed, at the sink, in bedside'+
                        ' chair, or on commode, with the assistance or supervision of another person.',
                    inputValue: '05'
                },
                {
                    xtype: 'radiofield',
                    name: 'm1830_crnt_bathg',
                    boxLabel: '6 - Unable to participate effectively in bathing and is bathed totally by another person.',
                    inputValue: '06'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1800Grooming = main.down('radiofield[name=m1800_crnt_grooming]').getGroupValue();
        m1810Upper = main.down('radiofield[name=m1810_crnt_dress_upper]').getGroupValue();
        m1820Lower = main.down('radiofield[name=m1820_crnt_dress_lower]').getGroupValue();
        m1830Bathing = main.down('radiofield[name=m1830_crnt_bathg]').getGroupValue();
        if(m1800Grooming == null){
            errs.push(['M1800', "Select the patient's dependency or Level of Grooming."]);
        }
        if(m1810Upper == null){
            errs.push(['M1810', "Select the patient's current ability to dress upper body safely."]);
        }
        if(m1820Lower == null){
            errs.push(['M1820', "Select the patient's current ability to dress lower body safely."]);
        }
        if(m1830Bathing == null){
            errs.push(['M1830', "Select the patient's current ability to wash entire body safely(Bathing)."]);
        }
        return errs;
    }
})
