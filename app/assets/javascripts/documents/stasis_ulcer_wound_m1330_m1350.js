/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.StasisUlcerWoundM1330M1350', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.stasisUlcerWoundM1330M1350',
    border: false,
    items: [
        {
            xtype: "panel",
            layout: "hbox",
            width: '98%',
            items: [
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    height: 475,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1330) Does this patient have a Stasis Ulcer?",
                            cls: 'oasis_green',
                            itemId: 'statsis_ulcr',
                            width: '98%',
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1330_stas_ulcr_prsnt",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - No',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1340]</text>'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1330_stas_ulcr_prsnt",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Yes, patient has BOTH observable and unobservable stasis ulcers'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1330_stas_ulcr_prsnt",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Yes, patient has observable stasis ulcers ONLY'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1330_stas_ulcr_prsnt",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - Yes, patient has unobservable stasis ulcers ONLY (known but not observable due to non-removable dressing/device)',
                                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M1340]</text>'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1332) Current Number of (Observable) Stasis Ulcer(s)",
                            cls: 'oasis_green',
                            itemId: 'obs_num_stasis_ulcr',
                            width: '98%',
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1332_nbr_stas_ulcr",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - One'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1332_nbr_stas_ulcr",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Two'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1332_nbr_stas_ulcr",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - Three'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1332_nbr_stas_ulcr",
                                    inputValue: "04",
                                    margin: 5,
                                    boxLabel: '4 - Four or more'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1334)  Status of Most Problematic Stasis Ulcer that is Observable",
                            cls: 'oasis_green',
                            itemId: 'obs_status_stasis_ulcr',
                            width: '98%',
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1334_stus_prblm_stas_ulcr",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - Newly epithelialized'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1334_stus_prblm_stas_ulcr",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Fully granulating'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1334_stus_prblm_stas_ulcr",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Early/partial granulation'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1334_stus_prblm_stas_ulcr",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - Not healing'
                                }
                            ]
                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    height: 450,
                    items: [
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1340) Does this patient have a Surgical Wound?",
                            cls: 'oasis_blue',
                            itemId: 'surg_wound',
                            width: "98%",
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1340_srgcl_wnd_prsnt",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - No',
                                    afterBoxLabelTpl: '<text style="background-color:yellow">[Go to M1350]</text>'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1340_srgcl_wnd_prsnt",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Yes, patient has at least one (observable) surgical wound'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1340_srgcl_wnd_prsnt",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Surgical wound known but not observable due to non-removable dressing',
                                    afterBoxLabelTpl: '<text style="background-color:yellow">[Go to M1350]</text>'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1342) Status of Most Problematic (Observable) Surgical Ulcer",
                            cls: 'oasis_pink',
                            itemId: 'Stat_surg_ulcr',
                            width: '98%',
                            labelAlign: 'top',
                            columns: 1,
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1342_stus_prblm_srgcl_wnd",
                                    inputValue: "00",
                                    margin: 5,
                                    boxLabel: '0 - Newly epithelialized'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1342_stus_prblm_srgcl_wnd",
                                    inputValue: "01",
                                    margin: 5,
                                    boxLabel: '1 - Fully granulating'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1342_stus_prblm_srgcl_wnd",
                                    inputValue: "02",
                                    margin: 5,
                                    boxLabel: '2 - Early/partial granulation'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1342_stus_prblm_srgcl_wnd",
                                    inputValue: "03",
                                    margin: 5,
                                    boxLabel: '3 - Not healing'
                                }
                            ]
                        },
                        {
                            xtype: 'radiogroup',
                            fieldLabel: "(M1350) Does this patient have a Skin Lesion or Open Wound, excluding bowel ostomy, other than those described above that is receiving intervention by the home health agency?",
                            labelAlign: 'top',
                            columns: 1,
                            width: '98%',
                            margin: "10 5",
                            items: [
                                {
                                    xtype: 'radiofield',
                                    name: "m1350_lesion_open_wnd",
                                    inputValue: "0",
                                    margin: 5,
                                    boxLabel: '0 - No'
                                },
                                {
                                    xtype: 'radiofield',
                                    name: "m1350_lesion_open_wnd",
                                    inputValue: "1",
                                    margin: 5,
                                    boxLabel: '1 - Yes'
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        m1330Value = main.down("[name=m1330_stas_ulcr_prsnt]").getGroupValue();
        m1332Value = main.down("[name=m1332_nbr_stas_ulcr]").getGroupValue();
        m1334Value = main.down("[name=m1334_stus_prblm_stas_ulcr]").getGroupValue();
        m1334Value = main.down("[name=m1334_stus_prblm_stas_ulcr]").getGroupValue();
        m1340Value = main.down("[name=m1340_srgcl_wnd_prsnt]").getGroupValue();
        m1342Value = main.down("[name=m1342_stus_prblm_srgcl_wnd]").getGroupValue();
        m1330Stasis = main.down('radiofield[name=m1330_stas_ulcr_prsnt]').getGroupValue();
        m1340surgical = main.down('radiofield[name=m1340_srgcl_wnd_prsnt]').getGroupValue();
        m1350Lesion = main.down('radiofield[name=m1350_lesion_open_wnd]').getGroupValue();
        if(m1330Stasis == null){
            errs.push(['M1330', "Choose (Yes/No), whether patient have a Stasis Ulcer."]);
        }
        if(m1340surgical == null){
            errs.push(['M1340', "Choose (Yes/No) whether the patient have Surgical Wound."]);
        }
        if(m1350Lesion == null){
            errs.push(['M1350', "Choose (Yes/No) whether the patient have Skin Lesion or Open Wound."]);
        }
        if(m1330Value == "01" || m1330Value == "02"){
            if(m1332Value == null || m1334Value == null){
                errs.push(['m1330_1332_1334', "Do not Leave 'Number of Stasis Ulcer(s)' and 'Status of Most Problematic Stasis Ulcer' Empty, since 'Stasis Ulcer' has been selected 'Yes'."]);
            }
        }

        if(m1340Value == "01"){
            if(m1342Value == null){
                errs.push(['m1340_1342', "Do not Leave Problematic Surgical Ulcer empty, since 'Surgical Wound' has been selected 'Yes'."]);
            }
        }
        return errs;
    },
    m1340SrgclWndPrsnt01: function(radioGroups, surgicalWoundRadioButtons){
        surgicalWoundRadioButtons[1].on('change', function(e){
            if(e.value){
                radioGroups[4].query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
            }
        }, this);
    },
    m1340SrgclWndPrsnt00R02: function(radioGroups, surgicalWoundRadioButtons){
        [surgicalWoundRadioButtons[0], surgicalWoundRadioButtons[2]].forEach(function(rb){
            rb.on('change', function(e){
                if(e.value){
                    radioGroups[4].query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                }
            }, this);
        }, this);
    },
    m1340SurgicalWound: function(radioGroups){
        surgicalWoundRadioButtons = this.query("[name=m1340_srgcl_wnd_prsnt]");
        this.m1340SrgclWndPrsnt00R02(radioGroups, surgicalWoundRadioButtons);
        this.m1340SrgclWndPrsnt01(radioGroups, surgicalWoundRadioButtons);
    },
    m1330StasUlcrPrsnt01R02: function(radioGroups, stasisUlcerRadioButtons){
        [stasisUlcerRadioButtons[1], stasisUlcerRadioButtons[2]].forEach(function(rb){
            rb.on('change', function(e){
                if(e.value){
                    [radioGroups[1], radioGroups[2]].forEach(function(rg){
                        rg.query("[xtype=radiofield]").forEach(function(el){el.enable().setValue(false)});
                    });
                }
            }, this);
        }, this);
    },
    m1330StasUlcrPrsnt00R03: function(radioGroups, stasisUlcerRadioButtons){
        [stasisUlcerRadioButtons[0], stasisUlcerRadioButtons[3]].forEach(function(rb){
            rb.on('change', function(e){
                if(e.value){
                    [radioGroups[1], radioGroups[2]].forEach(function(rg){
                        rg.query("[xtype=radiofield]").forEach(function(el){el.disable().setValue(false)});
                    });
                }
            }, this);
        }, this);
    },
    m1330StasisUlcer: function(radioGroups){
        stasisUlcerRadioButtons = this.query("[name=m1330_stas_ulcr_prsnt]");
        this.m1330StasUlcrPrsnt00R03(radioGroups, stasisUlcerRadioButtons);
        this.m1330StasUlcrPrsnt01R02(radioGroups, stasisUlcerRadioButtons);
    },
    initComponent: function(){
        this.callParent();
        radioGroups = this.query("[xtype=radiogroup]");
        this.m1330StasisUlcer(radioGroups);
        this.m1340SurgicalWound(radioGroups);
    }
})
