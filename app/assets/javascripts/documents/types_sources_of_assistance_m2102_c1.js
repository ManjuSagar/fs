/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.TypesSourcesOfAssistanceM2102C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.typesSourcesOfAssistanceM2102C1',
    border: 0,
    margin: "0 5 0 5",
    items: [
        {
            xtype: 'label',
            html: '(M2102) Types and Sources of Assistance: Determine the ability and willingness of non-agency caregivers' +
                ' (such as family members , friends , or privately paid caregivers) to provide assistance for the following activities,' +
                ' if assistance is needed. EXCLUDES all care by your agency staff.(Check only <u>one</u> box in each row.)'
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
                columns: 6
            },
            defaults:{
                bodyStyle: 'padding: 5px'
            },
            items: [
                {
                    xtype: 'label',
                    text: "Type of Assistance",
                    height: 150,
                    width: 420,
                    style: "vertical-align:middle;margin-left:150px;margin-right:auto"
                },
                {
                    html: "No assistance needed - patient is independent or does not have needs in this area" ,
                    height: 150,
                    width: 150,
                    style: "text-align:center;",
                    border:false
                },
                {
                    html: "Non-agency caregiver(s) currently provides assistance" ,
                    height: 150,
                    width: 150,
                    style: "text-align:center;",
                    border:false
                },
                {
                    html: "Non-agency caregiver(s) need training/ supportive services to provide assistance" ,
                    height: 150,
                    width: 150,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "Non-agency caregivers(s) are not likely to provide assistance OR it is UNCLEAR if they will provide assistance" ,
                    height: 150,
                    width: 150,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "Assistance needed, but no non-agency caregiver(s) available" ,
                    height: 150,
                    width: 150,
                    style: "text-align:center;",
                    border:false

                },
                {
                    html: "a. <b>ADL assistance</b> (for example:  transfer/ ambulation,  bathing, dressing,  toileting,  eating/feeding)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_adl',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_adl',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_adl',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {

                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_adl',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_adl',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    html: "b. <b>IADL assistance</b> (for example:  meals, housekeeping,  laundry, telephone,  shopping, finances)" ,
                    width: 420,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_iadl',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',

                    name: 'm2102_care_type_src_iadl',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_iadl',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_iadl',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_iadl',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    html: "c. <b>Medication  administration</b> (for example:  oral, inhaled or  injectable)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_mdctn',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_mdctn',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_mdctn',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_mdctn',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_mdctn',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    html: "d. <b>Medical procedures/  treatments</b> (for example:  changing wound  dressing, home exercise program)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_prcdr',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_prcdr',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_prcdr',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_prcdr',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_prcdr',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    html: "e. <b>Management of  Equipment</b> (for example, oxygen,IV/infusion equipment, enteral/ parenteral nutrition, ventilator therapy equipment or supplies)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_equip',
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_equip',
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_equip',
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_equip',
                    inputValue: "03",
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_equip',
                    inputValue: "04",
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    html: "f. <b>Supervision and safety</b> (for example: due to  cognitive impairment)" ,
                    width: 420,
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_sprvsn',
                    inputValue: '00',
                    boxLabel: '0',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_sprvsn',
                    inputValue: '01',
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_sprvsn',
                    inputValue: '02',
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_sprvsn',
                    inputValue: '03',
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_sprvsn',
                    inputValue: '04',
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                },
                {
                    html: "g. <b>Advocacy or facilitation</b> of patient\'s participation in appropriate medical care (for example,transportation to or from appointments)" ,
                    width: 420,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_advcy',
                    inputValue: '00',
                    boxLabel: '0',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_advcy',
                    inputValue: '01',
                    boxLabel: '1',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_advcy',
                    inputValue: '02',
                    boxLabel: '2',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_advcy',
                    inputValue: '03',
                    boxLabel: '3',
                    padding: '0 0 0 30px'

                },
                {
                    xtype: 'radiofield',
                    name: 'm2102_care_type_src_advcy',
                    inputValue: '04',
                    boxLabel: '4',
                    padding: '0 0 0 30px'

                }
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

        this.adl_assistance_group = main.query('radiofield[name=m2102_care_type_src_adl]');
        this.iadl_assistance_group = main.query('radiofield[name=m2102_care_type_src_iadl]');
        this.med_administration_group = main.query('radiofield[name=m2102_care_type_src_mdctn]');
        this.med_procedures_group = main.query('radiofield[name=m2102_care_type_src_prcdr]');
        this.equip_mgmnt_group = main.query('radiofield[name=m2102_care_type_src_equip]');
        this.sprvsn_and_safety_group = main.query('radiofield[name=m2102_care_type_src_sprvsn]');
        this.advocacy_group = main.query('radiofield[name=m2102_care_type_src_advcy]');

        if(this.findValueIsSelected(this.adl_assistance_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for ADL."]);
        }
        if(this.findValueIsSelected(this.iadl_assistance_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for IADL."]);
        }
        if(this.findValueIsSelected(this.med_administration_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for Medical Administration."]);
        }
        if(this.findValueIsSelected(this.med_procedures_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for Medical Procedures/treatments."]);
        }
        if(this.findValueIsSelected(this.equip_mgmnt_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for Management of Equipment."]);
        }
        if(this.findValueIsSelected(this.sprvsn_and_safety_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for Supervision and Safety."]);
        }
        if(this.findValueIsSelected(this.advocacy_group) == false){
            errs.push(['m2102', "Select the level of Assistance required for Advocacy or Facilitation."]);
        }
        return errs;
    }
})
