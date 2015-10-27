/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.TypesSourcesOfAssistancem2100', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.typesSourcesOfAssistancem2100',
    border: 0,
    items: [
        {
            xtype: 'label',
            margin: 5,
            html: '(M2100) Types and Sources of Assistance: Determine the level of caregiver ability and willingness to provide assistance for the following activities, if assistance is needed. (Check only <u>one</u> box in each row.)',
        },
        {
            xtype: 'panel',
            border: false,
            margin: '10 5 5 60',
            layout: {
                type: 'table',
                tableAttrs: {
                    border:1
                },
                columns: 7,
            },
            defaults:{
                bodyStyle: 'padding: 5px',
            },
            items: [
                {
                    xtype: 'label',
                    text: "Type of Assistance",
                    height: 100,
                    width: 420,
                    style: "vertical-align:middle;margin-left:150px;margin-right:auto"
                },
                {
                    html: "No assistance needed in this area" ,
                    height: 100,
                    width: 100,
                    style: "text-align:center;",
                    border:false
                },
                {
                    html: "Caregiver(s) currently provides assistance" ,
                    height: 100,
                    width: 100,
                    style: "text-align:center;",
                    border:false
                },
                {
                    html: "Caregiver(s) need training/ supportive services to provide assistance" ,
                    height: 100,
                    width: 100,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "Caregiver(s) <u>not likely</u> to provide assistance" ,
                    height: 100,
                    width: 100,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "Unclear if Caregiver(s) will provide assistance" ,
                    height: 100,
                    width: 100,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "Assistance needed, but no Caregiver(s) available" ,
                    height: 100,
                    width: 100,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "a. <b>ADL assistance</b> (e.g.,  transfer/ ambulation,  bathing, dressing,  toileting,  eating/feeding)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_adl',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_adl',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_adl',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {

                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_adl',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_adl',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_adl',
                    inputValue: "05",
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
                {
                    html: "b. <b>IADL assistance</b> (e.g.,  meals, housekeeping,  laundry, telephone,  shopping, finances)" ,
                    width: 420,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_iadl',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',

                    name: 'm2100_care_type_src_iadl',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_iadl',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_iadl',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_iadl',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_iadl',
                    inputValue: "05",
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
                {
                    html: "c. <b>Medication  administration</b> (e.g.,  oral, inhaled or  injectable)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_mdctn',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_mdctn',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_mdctn',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_mdctn',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_mdctn',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_mdctn',
                    inputValue: "05",
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
                {
                    html: "d. <b>Medical procedures/  treatments</b> (e.g.,  changing wound  dressing)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_prcdr',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_prcdr',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_prcdr',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_prcdr',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_prcdr',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_prcdr',
                    inputValue: "05",
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
                {
                    html: "e. <b>Management of  Equipment</b> (includes  oxygen, IV/infusion  equipment, enteral/parenteral nutrition,  ventilator therapy  equipment or supplies)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_equip',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_equip',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_equip',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_equip',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_equip',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_equip',
                    inputValue: "05",
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
                {
                    html: "f. <b>Supervision and safety</b> (e.g., due to  cognitive impairment)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_sprvsn',
                    inputValue: '00',
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_sprvsn',
                    inputValue: '01',
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_sprvsn',
                    inputValue: '02',
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_sprvsn',
                    inputValue: '03',
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_sprvsn',
                    inputValue: '04',
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_sprvsn',
                    inputValue: '05',
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
                {
                    html: "g. <b>Advocacy or facilitation</b> of patient\'s participation in appropriate medical care (includes transportation to or from appointments)" ,
                    width: 420,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_advcy',
                    inputValue: '00',
                    boxLabel: '0',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_advcy',
                    inputValue: '01',
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_advcy',
                    inputValue: '02',
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_advcy',
                    inputValue: '03',
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_advcy',
                    inputValue: '04',
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2100_care_type_src_advcy',
                    inputValue: '05',
                    boxLabel: '5',
                    padding: '0 0 0 30px'

                },
            ]
        }
    ],
    findValueIsSelected: function(list) {
        var selected = false;
        Ext.each(list, function(element, index){
            if(element.checked == true){
                selected = true;
            }
        }, this);
        return selected;
    },
    onValidate: function(main) {
        var errs = new Array();

        this.adl_assistance_group = main.query('radiofield[name=m2100_care_type_src_adl]');
        this.iadl_assistance_group = main.query('radiofield[name=m2100_care_type_src_iadl]');
        this.med_administration_group = main.query('radiofield[name=m2100_care_type_src_mdctn]');
        this.med_procedures_group = main.query('radiofield[name=m2100_care_type_src_prcdr]');
        this.equip_mgmnt_group = main.query('radiofield[name=m2100_care_type_src_equip]');
        this.sprvsn_and_safety_group = main.query('radiofield[name=m2100_care_type_src_sprvsn]');
        this.advocacy_group = main.query('radiofield[name=m2100_care_type_src_advcy]');

        if(this.findValueIsSelected(this.adl_assistance_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for ADL."]);
        }
        if(this.findValueIsSelected(this.iadl_assistance_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for IADL."]);
        }
        if(this.findValueIsSelected(this.med_administration_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for Medical Administration."]);
        }
        if(this.findValueIsSelected(this.med_procedures_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for Medical Procedures/treatments."]);
        }
        if(this.findValueIsSelected(this.equip_mgmnt_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for Management of Equipment."]);
        }
        if(this.findValueIsSelected(this.sprvsn_and_safety_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for Supervision and Safety."]);
        }
        if(this.findValueIsSelected(this.advocacy_group) == false){
            errs.push(['M2100', "Select the level of Assistance required for Advocacy or Facilitation."]);
        }
        return errs;
    }
})
