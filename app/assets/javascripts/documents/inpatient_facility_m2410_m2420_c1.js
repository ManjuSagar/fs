/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.InpatientFacilityM2410M2420C1', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.inpatientFacilityM2410M2420C1',
    border: false,
    margin: 5,
    items: [
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M2410) To which Inpatient Facility has the patient been admitted?',
            cls: 'oasis_blue',
            itemId: 'inpat_fac_adm',
            width: "60%",
            labelAlign: 'top',
            margin: 5,
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '1 - Hospital',
                    inputValue: '01',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M2430]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '2 - Rehabilitation facility',
                    inputValue: '02',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '3 - Nursing home',
                    inputValue: '03',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: '4 - Hospice',
                    inputValue: '04',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2410_inpat_facility',
                    boxLabel: 'NA - No inpatient facility admission',
                    inputValue: 'NA'
                }
            ]
        },
        {
            xtype: 'radiogroup',
            layout: {
                align: 'stretch',
                type: 'vbox'
            },
            fieldLabel: '(M2420) Discharge Disposition: Where is the patient after discharge from your agency?'+
                '(Choose only oneanswer.)',
            cls: 'oasis_blue',
            itemId: 'discharge_disposition',
            width: "60%",
            labelAlign: 'top',
            margin: 5,
            items: [
                {
                    xtype: 'radiofield',
                    name: 'm2420_dschrg_disp',
                    boxLabel: '1 - Patient remained in the community (without formal assistive services)',
                    inputValue: '01'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2420_dschrg_disp',
                    boxLabel: '2 - Patient remained in the community (with formal assistive services)',
                    inputValue: '02'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2420_dschrg_disp',
                    boxLabel: '3 - Patient transferred to a non-institutional hospice',
                    inputValue: '03'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2420_dschrg_disp',
                    boxLabel: '4 - Unknown because patient moved to a geographic location not served by this agency',
                    inputValue: '04'
                },
                {
                    xtype: 'radiofield',
                    name: 'm2420_dschrg_disp',
                    boxLabel: 'UK - Other unknown',
                    inputValue: 'UK',
                    afterBoxLabelTpl: ' <text class="oasis_yellow">[Go to M0903]</text>'
                }

            ]
        }
    ],
    afterRender: function(){
        this.callParent();
        this.super_main = Ext.ComponentQuery.query("#super_main")[0];
        this.dischargeDispositions = this.super_main.down('#discharge_disposition').query('radiofield');

        this.super_main.query("[name = m2410_inpat_facility]").forEach(function(s){
            s.on('change', function(el){
                if(el.getGroupValue() == "NA"){
                    Ext.each(this.dischargeDispositions, function(el){
                        el.enable().setValue(false);
                    },this);
                } else {
                    Ext.each(this.dischargeDispositions, function(el){
                        el.disable().setValue(false);
                    },this);
                }
            }, this);
        }, this);

    },
    onValidate: function(main){
        var errs = new Array();
        var m2410InpatFacility = this.super_main.down('radiofield[name=m2410_inpat_facility]');
        var m2420DschrgDisp = this.super_main.down('[name=m2420_dschrg_disp]');
        var m0100Value = this.super_main.down("[name=m0100_assmt_reason]").value;
        if(m2410InpatFacility.getGroupValue() == null){
            errs.push(['M2410', "Select one option to which inpatient facility the patient been admitted."]);
        }

        if(m2410InpatFacility.getGroupValue() == "NA"){
            if(m2420DschrgDisp.getGroupValue() == null){
                errs.push(['M2420',"Do not leave discharge disposition blank since inpatient facility is 'NA'."])
            }
        }

        if(m2420DschrgDisp.getGroupValue() == null){
            errs.push(['M2420'," Discharge Disposition can't be blank."])
        }
        if(m0100Value == "09" && m2410InpatFacility.getGroupValue() != "NA"){
            errs.push(['M2410',"Inpatient Facility must be 'NA' for this assessment type. Refer to (M0100)."])
        }

        return errs;
    }
})
