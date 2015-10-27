/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.AdliadLs2M1840M1860', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.adliadLs2M1840M1860',
    border: false,
    items: [

        {
            xtype: 'radiogroup',
            fieldLabel: "(M1840) Toilet Transferring: Current ability to get to and from the toilet or bedside commode safely and transfer on and off toilet/commode",
            cls: 'oasis_pink',
            item_id: 'toilet_trnsfr',
            width: "92%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to get to and from the toilet and transfer independently with or without a device'
                },
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - When reminded, assisted, or supervised by another person, able to get to and from the toilet and transfer'
                },
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Unable to get to and from the toilet but is able to use a bedside commode (with or without assistance)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Unable to get to and from the toilet or bedside commode but is able to use a bedpan/urinal independently'
                },
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Is totally dependent in toileting'
                }
            ]
        },

        {
            xtype: 'radiogroup',
            fieldLabel: "(M1850) Transferring: Current ability to move safely from bed to chair, or ability to turn and position self in bed if patient is bedfast",
            cls: 'oasis_pink',
            item_id: 'ability_move_safe',
            width: "92%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1850_crnt_trnsfrng",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to independently transfer'
                },
                {
                    xtype: 'radiofield',
                    name: "m1850_crnt_trnsfrng",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - Able to transfer with minimal human assistance or with use of an assistive device'
                },
                {
                    xtype: 'radiofield',
                    name: "m1850_crnt_trnsfrng",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Able to bear weight and pivot during the transfer process but unable to transfer self'
                },
                {
                    xtype: 'radiofield',
                    name: "m1850_crnt_trnsfrng",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Unable to transfer self and is unable to bear weight or pivot when transferred by another person'
                },
                {
                    xtype: 'radiofield',
                    name: "m1850_crnt_trnsfrng",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Bedfast, unable to transfer but is able to turn and position self in bed'
                },
                {
                    xtype: 'radiofield',
                    name: "m1850_crnt_trnsfrng",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - Bedfast, unable to transfer and is unable to turn and position self'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1860) Ambulation/Locomotion: Current ability to walk safely, once in a standing position, or use a wheelchair, once in a seated position, on a variety of surfaces",
            cls: 'oasis_pink',
            item_id: 'walk_safe',
            width: "92%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to independently walk on even and uneven surfaces and negotiate stairs with or without railings (specifically: needs no human assistance or assistive device)'
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: '1 - With the use of a one-handed device (for example. cane, single crutch, hemi-walker), able to independently walk on even and uneven surfaces and negotiate stairs with or without railings'
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Requires use of a two-handed device (for example. walker or crutches) to walk alone on alevel surface and/or requires human supervision or assistance to negotiate stairs or steps or uneven surfaces'
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Able to walk only with the supervision or assistance of another person at all times'
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Chairfast, unable to ambulate but is able to wheel self independently'
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - Chairfast, unable to ambulate and is unable to wheel self'
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "06",
                    margin: 5,
                    boxLabel: '6 - Bedfast, unable to ambulate or be up in a chair'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();

        m1840Field = main.down('radiofield[name=m1840_crnt_toiltg]').getGroupValue();
        m1850Field = main.down('radiofield[name=m1850_crnt_trnsfrng]').getGroupValue();
        m1860Field = main.down('radiofield[name=m1860_crnt_ambltn]').getGroupValue();
        if(m1840Field == null){
            errs.push(['M1840', "Select the patient's current ability of Toilet Transferring. "]);
        }
        if(m1850Field == null){
            errs.push(['M1850', "Select the patient's current ability of self Transferring."]);
        }
        if(m1860Field == null){
            errs.push(['M1860', "Select the patient's current ability of Ambulation/Locomotion."]);
        }

        return errs;
    }
})
