/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.PaymentSourceM0150', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.paymentSourceM0150',
    border: false,
    margin: 5,
    items: [
        {

            xtype: 'checkboxgroup',
            fieldLabel: '(M0150) Current Payment Sources for Home Care: (Mark all that apply.)',
            labelAlign: 'top',
            columns: 1,
            margin: "5px",
            items: [
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_none",
                    inputValue: "1",
                    boxLabel: '0 - None; no charge for current services'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_mcare_ffs",
                    inputValue: "1",
                    boxLabel: '1 - Medicare (traditional fee-for-service)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_mcare_hmo",
                    inputValue: "1",
                    boxLabel: '2 - Medicare (HMO/managed care/Advantage plan)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_mcaid_ffs",
                    inputValue: "1",
                    boxLabel: '3 - Medicaid (traditional fee-for-service)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_mcaid_hmo",
                    inputValue: "1",
                    boxLabel: '4 - Medicaid (HMO/managed care)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_wrkcomp",
                    inputValue: "1",
                    boxLabel: '5 - Worker`s compensation'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_titlepgms",
                    inputValue: "1",
                    boxLabel: '6 - Title programs (e.g., Title III, V, or XX)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_oth_govt",
                    inputValue: "1",
                    boxLabel: '7 - Other government (e.g., TriCare, VA, etc.)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_priv_ins",
                    inputValue: "1",
                    boxLabel: '8 - Private insurance'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_priv_hmo",
                    inputValue: "1",
                    boxLabel: '9 - Private HMO/managed care'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_selfpay",
                    inputValue: "1",
                    boxLabel: '10 - Self-pay'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_other",
                    inputValue: "1",
                    boxLabel: '11 - Other (specify)'
                },
                {
                    xtype: 'checkboxfield',
                    name: "m0150_cpay_uk",
                    inputValue: "1",
                    boxLabel: 'UK Unknown'
                }
            ]
        },
        {
            xtype: "textfield",
            name: "m0150_other_cpay",
            labelAlign: "top",
            width: "50%",
            margin: "5px",
            disabled: true,
            fieldLabel: "If 11- Other is checked for M0150. Then specify the Other Payment Source. (NOTE: This field is not transmitted to the OASIS State System.)"
        }
    ],
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.mcareFFS = this.mainScope.down('[name=m0150_cpay_mcare_ffs]');
        this.mcareHMO = this.mainScope.down('[name=m0150_cpay_mcare_hmo]');
        this.mcaidFFS = this.mainScope.down('[name=m0150_cpay_mcaid_ffs]');
        this.mcaidHMO = this.mainScope.down('[name=m0150_cpay_mcaid_hmo]');
        this.cpayNone = this.mainScope.down('[name=m0150_cpay_none]');
        this.cpayUk = this.mainScope.down('[name=m0150_cpay_uk]');
        this.cpayOther = this.mainScope.down('[name=m0150_cpay_other]');
        this.otherCpay = this.mainScope.down('[name=m0150_other_cpay]');
        this.m0063MedNa = this.mainScope.down('checkbox[name=m0063_medicare_na]');
        this.m0065MedNa = this.mainScope.down('checkbox[name=m0065_medicaid_na]');

        if(this.otherCpay.value == true){
            this.otherCpay.setValue("").enable();}
        else{
            this.otherCpay.setValue("").disable();
        }

        this.cpayUk.on('change', function(ele){
            if(ele.value == true){
                var checks = this.query("checkboxfield");
                Ext.each(checks, function(check, index){
                    if(check.name != "m0150_cpay_uk") check.setValue(false).disable();
                });
            }else{
                var checks = this.query("checkboxfield");
                Ext.each(checks, function(check, index){
                    if(check.name != "m0150_cpay_uk") check.setValue(false).enable();
                });
            }
        }, this);

        var checks = this.query("checkboxfield");
        Ext.each(checks, function(check, index){
            check.on('change', function(ele){
                if (ele.name == "m0150_cpay_other"){
                    if(ele.value == true)
                        this.otherCpay.setValue("").enable();
                    else
                        this.otherCpay.setValue("").disable();
                }
            }, this);
        }, this);
        this.cpayUk.on('change', function(ele){
            if(this.m0065MedNa.value == true){
                medicaid1 = this.mainScope.down("[name=m0150_cpay_mcaid_ffs]");
                medicaid2 = this.mainScope.down("[name=m0150_cpay_mcaid_hmo]");
                medicaid1.setValue(false).disable();
                medicaid2.setValue(false).disable();
            }
            if(this.m0063MedNa.value == true){
                medicare1 = this.mainScope.down("[name=m0150_cpay_mcare_ffs]");
                medicare2 = this.mainScope.down("[name=m0150_cpay_mcare_hmo]");
                medicare1.setValue(false).disable();
                medicare2.setValue(false).disable();
            }
        }, this)
    },
    onValidate: function(main){
        var errs = new Array();
        if (this.private_insurance == false) {
            if (this.mcareFFS.value == false && this.mcareHMO.value == false && this.mcaidFFS.value == false && this.mcaidHMO.value == false) {
                errs.push(['M0150', "Select at least one payment source."]);
            }
        }
        if(this.cpayNone.value == true || this.cpayUk.value == true){
            errs.push(['M0150', "Both Current Payment: None and Current Payment: UK(Unknown) should be blank."]);
        }
        return errs;
    }
})
