/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.Medications2M2040', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.medications2M2040',
    border: 0,
    items: [
        {
            xtype: "label",
            margin: 5,
            html: "(M2040) Prior Medication Management: Indicate the patient's usual ability with managing oral and injectable medications prior to this current illness, exacerbation, or injury. Check only <b><u>one</u></b> box in each row."
        },
        {
            xtype: "panel",
            border: false,
            margin: '10 5 5 60',
            layout: {
                type: 'table',
                tableAttrs: {
                    border:1
                },
                columns: 5,
            },
            defaults:{
                bodyStyle: 'padding: 5px',
            },
            items: [
                {
                    html: 'Functional Area',
                    style: 'text-align:center;font-weight:bold;',
                    height: 36,
                    border:false
                },
                {
                    html: 'Independent',
                    style: 'text-align:center;font-weight:bold;',
                    width: 110,
                    height: 36,
                    border:false

                },
                {
                    html: 'Needed Some Help',
                    style: 'text-align:center;font-weight:bold;',
                    width: 110,
                    height: 40,
                    border:false
                },
                {
                    html: 'Dependent',
                    style: 'text-align:center;font-weight:bold;',
                    width: 110,
                    height: 36,
                    border:false

                },
                {
                    html: 'Not Applicable',
                    style: 'text-align:center;font-weight:bold;',
                    width: 110,
                    height: 36,
                    border:false

                },
                {
                    html: 'a. Oral medications',
                    border:false

                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_oral_mdctn",
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 45px'
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_oral_mdctn",
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 45px'
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_oral_mdctn",
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 45px'
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_oral_mdctn",
                    inputValue: "NA",
                    boxLabel: 'na',
                    padding: '0 0 0 45px'
                },
                {
                    html: 'b. Injectable medications',
                    border:false
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_injctn_mdctn",
                    inputValue: "00",
                    boxLabel: '0',
                    padding: '0 0 0 45px'
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_injctn_mdctn",
                    inputValue: "01",
                    boxLabel: '1',
                    padding: '0 0 0 45px'
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_injctn_mdctn",
                    inputValue: "02",
                    boxLabel: '2',
                    padding: '0 0 0 45px'
                },
                {
                    xtype: 'radiofield',
                    name: "m2040_prior_mgmt_injctn_mdctn",
                    inputValue: "NA",
                    boxLabel: 'na',
                    padding: '0 0 0 45px'
                },
            ]
        }
    ],
    onValidate: function(main){
        var errs = new Array();
        var oral_medicine_check = false;
        var injection_medicine_check = false;
        var oral_checkboxes = main.query('radiofield[name=m2040_prior_mgmt_oral_mdctn]');
        var injection_checkboxes = main.query('radiofield[name=m2040_prior_mgmt_injctn_mdctn]');
        Ext.each(oral_checkboxes, function(element, index){
            if(element.checked == true){
                oral_medicine_check = true;
            }
        }, this);
        if(oral_medicine_check == false){
            errs.push(['M2040', "Select the patient's ability to intake Oral Medications."]);
        }

        Ext.each(injection_checkboxes, function(element, index){
            if(element.checked == true){
                injection_medicine_check = true;
            }
        }, this);
        if(injection_medicine_check == false)   {
            errs.push(['M2040', "Select the patient's ability to intake Injectable Medications."]);
        }

        return errs;
    }
})
