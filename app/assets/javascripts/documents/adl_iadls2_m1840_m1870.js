/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.AdlIadls2M1840M1870', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.adlIadls2M1840M1870',
    items: [
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1840) Toilet Transferring: Current ability to get to and from the toilet or bedside commode " +
                "safely and transfer on and off toilet/commode",
            cls: 'oasis_pink',
            itemId: 'toilet_transfer',
            width: "98%",
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
                    boxLabel: "1 - When reminded, assisted, or supervised by another person, able to get to and from " +
                    "the toilet and transfer"
                },
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: "2 - Unable to get to and from the toilet but is able to use a bedside commode (with or " +
                    "without assistance)"
                },
                {
                    xtype: 'radiofield',
                    name: "m1840_crnt_toiltg",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: "3 - Unable to get to and from the toilet or bedside commode but is able to use a " +
                    "bedpan/urinal independently"
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
            fieldLabel: "(M1845) Toileting Hygiene: Current ability to maintain perineal hygiene safely, adjust clothes " +
                "and/or incontinence pads before and after using toilet, commode, bedpan, urinal. If managing " +
                "ostomy, includes cleaning area around stoma, but not managing equipment",
            cls: 'oasis_blue',
            itemId: 'toileting_hyg',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1845_crnt_toiltg_hygn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to manage toileting hygiene and clothing management without assistance'
                },
                {
                    xtype: 'radiofield',
                    name: "m1845_crnt_toiltg_hygn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: "1 - Able to manage toileting hygiene and clothing management without assistance if " +
                        "supplies/implements are laid out for the patient"
                },
                {
                    xtype: 'radiofield',
                    name: "m1845_crnt_toiltg_hygn",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Someone must help the patient to maintain toileting hygiene and/or adjust clothing'
                },
                {
                    xtype: 'radiofield',
                    name: "m1845_crnt_toiltg_hygn",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: '3 - Patient depends entirely upon another person to maintain toileting hygiene'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1850) Transferring: Current ability to move safely from bed to chair, or ability to turn " +
                "and position self in bed if patient is bedfast",
            cls: 'oasis_pink',
            itemId: 'move_safely',
            width: "98%",
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
            fieldLabel: "(M1860) Ambulation/Locomotion: Current ability to walk safely, once in a standing position, " +
                "or use a wheelchair, once in a seated position, on a variety of surfaces",
            cls: 'oasis_pink',
            itemId: 'ambulation_loco',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: "0 - Able to independently walk on even and uneven surfaces and negotiate stairs with " +
                        "or without railings (specifically: needs no human assistance or assistive device)"
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: "1 - With the use of a one-handed device (for example, cane, single crutch, hemi-walker), able to " +
                        "independently walk on even and uneven surfaces and negotiate stairs with or without railings"
                },
                {
                    xtype: 'radiofield',
                    name: "m1860_crnt_ambltn",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: "2 - Requires use of a two-handed device (for example, walker or crutches) to walk alone on a " +
                        "level surface and/or requires human supervision or assistance to negotiate stairs or " +
                        "steps or uneven surfaces"
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
        },
        {
            xtype: 'radiogroup',
            fieldLabel: "(M1870) Feeding or Eating: Current ability to feed self meals and snacks safely. Note: This " +
                "refers only to the process of eating, chewing, and swallowing, not preparing the food to be " +
                "eaten",
            cls: 'oasis_blue',
            itemId: 'feeding_or_eating',
            width: "98%",
            labelAlign: 'top',
            columns: 1,
            margin: "10 5",
            items: [
                {
                    xtype: 'radiofield',
                    name: "m1870_crnt_feeding",
                    inputValue: "00",
                    margin: 5,
                    boxLabel: '0 - Able to independently feed self'
                },
                {
                    xtype: 'radiofield',
                    name: "m1870_crnt_feeding",
                    inputValue: "01",
                    margin: 5,
                    boxLabel: "1 - Able to feed self independently but requires:<br /> " +
                        "(a) meal set-up; OR<br /> " +
                        "(b) intermittent assistance or supervision from another person; OR<br /> " +
                        "(c) a liquid, pureed or ground meat diet"
                },
                {
                    xtype: 'radiofield',
                    name: "m1870_crnt_feeding",
                    inputValue: "02",
                    margin: 5,
                    boxLabel: '2 - Unable to feed self and must be assisted or supervised throughout the meal/snack'
                },
                {
                    xtype: 'radiofield',
                    name: "m1870_crnt_feeding",
                    inputValue: "03",
                    margin: 5,
                    boxLabel: "3 - Able to take in nutrients orally and receives supplemental nutrients through a nasogastric tube or gastrostomy"
                },
                {
                    xtype: 'radiofield',
                    name: "m1870_crnt_feeding",
                    inputValue: "04",
                    margin: 5,
                    boxLabel: '4 - Unable to take in nutrients orally and is fed nutrients through a nasogastric tube or gastrostomy'
                },
                {
                    xtype: 'radiofield',
                    name: "m1870_crnt_feeding",
                    inputValue: "05",
                    margin: 5,
                    boxLabel: '5 - Unable to take in nutrients orally or by tube feeding'
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();

        m1840Field = main.down("#adl_iadls2_m1840_m1870").query("[xtype=radiogroup]")[0];
        m1845Field = main.down("#adl_iadls2_m1840_m1870").query("[xtype=radiogroup]")[1];
        m1850Field = main.down("#adl_iadls2_m1840_m1870").query("[xtype=radiogroup]")[2];
        m1860Field = main.down("#adl_iadls2_m1840_m1870").query("[xtype=radiogroup]")[3];
        m1870Field = main.down("#adl_iadls2_m1840_m1870").query("[xtype=radiogroup]")[4];

        if(m1840Field.down("[name = m1840_crnt_toiltg]").getGroupValue() == null){
            errs.push(['M1840', "Select the patient's current ability of Toilet Transferring."]);
        }

        if(m1845Field.down("[name = m1845_crnt_toiltg_hygn]").getGroupValue() == null){
            errs.push(['M1845', "Select the patient's current ability of Toileting Hygiene."]);
        }

        if(m1850Field.down("[name = m1850_crnt_trnsfrng]").getGroupValue() == null){
            errs.push(['M1850', "Select the patient's current ability of self Transferring."]);
        }

        if(m1860Field.down("[name = m1860_crnt_ambltn]").getGroupValue() == null){
            errs.push(['M1860', "Select the patient's current ability of Ambulation/Locomotion."]);
        }

        if(m1870Field.down("[name = m1870_crnt_feeding]").getGroupValue() == null){
            errs.push(['M1870', "Select the patient's current ability of self Feeding or Eating."]);
        }

        return errs;
    }
})
