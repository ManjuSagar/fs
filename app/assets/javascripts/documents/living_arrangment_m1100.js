/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.livingarrangmentm1100', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.livingarrangmentm1100',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'label',
            margin: 5,
            html: '(M1100) Patient Living Situation: Which of the following best describes the patient\'s residential circumstance and availability of assistance? (Check <u>one</u> box only.) ',
            cls: 'oasis_blue',
            itemId: 'pat_living_sit',
        },
        {
            xtype: 'panel',
            border: false,
            margin: '10 5 5 60',
            layout: {
                type: 'table',
                tableAttrs: {
                    border:1,
                    cls: 'oasis_blue',
                },
                columns: 6,
            },
            defaults:{
                bodyStyle: 'padding: 5px; background-color: #CCE6FF;',
            },
            items: [
                {
                    xtype: 'label',
                    text: 'Living Arrangement',
                    rowspan: 2,
                    style: 'font-weight:bold;vertical-align:middle; margin-left:20px;margin-right:auto',
                    height: 75,
                    width: 180,
                    border:false
                },
                {
                    html: 'Availability of Assistance',
                    colspan: 5,
                    style: 'font-weight:bold;text-align:center',
                    border:false
                },
                {
                    html: 'Around the clock',
                    style: 'text-align:center;',
                    width: 88,
                    height: 58,
                    border:false
                },
                {
                    html: 'Regular daytime',
                    style: 'text-align:center;',
                    width: 88,
                    height: 58,
                    border:false
                },
                {
                    html: 'Regular nighttime',
                    style: 'text-align:center;',
                    width: 88,
                    height: 58,
                    border:false
                },
                {
                    html: 'Occasional / short-term assistance',
                    style: 'text-align:center;',
                    width: 88,
                    height: 58,
                    border:false
                },
                {
                    html: 'No assistance available',
                    style: 'text-align:center;',
                    width: 88,
                    height: 58,
                    border:false
                },
                {
                    html: '<b>a.</b> Patient lives alone',
                    width: 180,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "01",
                    boxLabel: '01',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "02",
                    boxLabel: '02',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "03",
                    boxLabel: '03',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "04",
                    boxLabel: '04',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "05",
                    boxLabel: '05',
                    padding: '0 0 0 30px'
                },
                {
                    html: '<b>b.</b> Patient lives with other person(s) in the home',
                    width: 180,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "06",
                    boxLabel: '06',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "07",
                    boxLabel: '07',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "08",
                    boxLabel: '08',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "09",
                    boxLabel: '09',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "10",
                    boxLabel: '10',
                    padding: '0 0 0 30px'
                },
                {
                    html: '<b>c.</b> Patient lives in congregate situation (for example, assisted living, residential care home)',
                    width: 180,
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "11",
                    boxLabel: '11',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "12",
                    boxLabel: '12',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "13",
                    boxLabel: '13',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "14",
                    boxLabel: '14',
                    padding: '0 0 0 30px'
                },
                {
                    xtype: 'radiofield',
                    name: "m1100_ptnt_lvg_stutn",
                    inputValue: "15",
                    boxLabel: '15',
                    padding: '0 0 0 30px'
                },
            ]
        }

    ],
    onValidate: function(){
        var errs = new Array();
        var patient_situation_check = false;
        Ext.each(this.patient_living_stutn_group, function(element, index){
            if(element.checked == true){
                patient_situation_check = true;
            }
        }, this);

        if(patient_situation_check == false){
            errs.push(['M1100', "Patient Living Situation is required."]);
        }
        return errs;
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.patient_living_stutn_group = this.mainScope.query('radiofield[name=m1100_ptnt_lvg_stutn]');
    }
})
