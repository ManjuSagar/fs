/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.GeneralPatientInformationM0010M0069', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.generalPatientInformationM0010M0069',
    border: false,
    items: [
        {
            xtype: "panel",
            border: false,
            margin: 5,
            layout: "hbox",
            items: [
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    items: [
                        {

                            xtype: 'panel',
                            layout: {type: "table", columns: 2},
                            border: false,
                            items: [
                                {
                                    xtype: "textfield",
                                    fieldLabel: "(M0010) CMS Certification Number",
                                    name: "m0010_ccn",
                                    labelAlign: 'top',
                                    readOnly: true
                                },
                                {
                                    xtype: 'button',
                                    text: "",
                                    icon: '/assets/icons/refresh.png',
                                    margin: '-40 0 0 -7',
                                    tooltip: 'Refresh Agency Information',
                                    name: 'refresh_agency_info'
                                }

                            ]
                        },
                        {
                            xtype: "textfield",
                            fieldLabel: "(M0014) Branch State",
                            name: "m0014_branch_state",
                            labelAlign: 'top',
                            readOnly: true
                        },
                        {
                            xtype: "textfield",
                            fieldLabel: "(M0016) Branch ID Number",
                            name: "m0016_branch_id",
                            labelAlign: 'top',
                            readOnly: true
                        },
                        {
                            xtype: "textfield",
                            fieldLabel: "(M0018) National Provider Identifier (NPI) for the attending physician who has signed the plan of care",
                            name: "m0018_physician_id",
                            labelAlign: 'top',
                            readOnly: true
                        },
                        {
                            xtype: "checkbox",
                            fieldLabel: "(M0018) National Provider Identifier (NPI) for the attending physician who has signed the plan of care: UK",
                            cls: 'oasis_heading',
                            inputValue: "1",
                            name: "m0018_physician_uk",
                            labelAlign: 'top',
                            readOnly: true
                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    flex: 1,
                    items: [
                        {
                            xtype: "textfield",
                            fieldLabel: "(M0020) Patient ID Number",
                            name: "m0020_pat_id",
                            labelAlign: 'top',
                            readOnly: true
                        },
                        {
                            xtype: "datefield",
                            fieldLabel: "(M0030) Start of Care Date",
                            name: "m0030_start_care_dt",
                            labelAlign: 'top'
                        },
                        {
                            xtype: "datefield",
                            fieldLabel: "(M0032) Resumption of Care Date",
                            name: "m0032_roc_dt",
                            labelAlign: 'top'
                        },
                        {
                            xtype: "checkbox",
                            fieldLabel: "(M0032) Resumption of Care Date: NA",
                            cls: 'oasis_heading',
                            inputValue: "1",
                            name: "m0032_roc_dt_na",
                            labelAlign: 'top'
                        }
                    ]
                },
                {
                    xtype: "panel",
                    border: false,
                    flex: 3,
                    items: [
                        {
                            xtype: "label",
                            text: "(M0040) Patient Name:"
                        },
                        {
                            xtype: "panel",
                            layout: "hbox",
                            border: false,
                            items: [
                                {
                                    xtype: "textfield",
                                    fieldLabel: "First",
                                    name: "m0040_pat_fname",
                                    labelAlign: 'top'
                                },{
                                    xtype: "textfield",
                                    fieldLabel: "MI",
                                    name: "m0040_pat_mi",
                                    labelAlign: 'top'
                                },{
                                    xtype: "textfield",
                                    fieldLabel: "Last",
                                    name: "m0040_pat_lname",
                                    labelAlign: 'top'
                                },{
                                    xtype: "textfield",
                                    fieldLabel: "Suffix",
                                    name: "m0040_pat_suffix",
                                    labelAlign: 'top'
                                }
                            ]

                        },
                        {
                            xtype: "panel",
                            border: false,
                            layout: "hbox",
                            items: [
                                {
                                    xtype: "panel",
                                    flex: 0.9,
                                    border: false,
                                    items: [
                                        {
                                            xtype: "textfield",
                                            fieldLabel: "(M0050) Patient State of Residence",
                                            name: "m0050_pat_st",
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "textfield",
                                            fieldLabel: "(M0060) Patient Zip Code",
                                            name: "m0060_pat_zip",
                                            inputMask: '99999-999999-99',
                                            labelAlign: 'top',
                                            maxLength: 11
                                        },
                                        {
                                            xtype: "textfield",
                                            fieldLabel: "(M0063) Medicare Number",
                                            name: "m0063_medicare_num",
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "checkbox",
                                            fieldLabel: "(M0063) Medicare Number: NA",
                                            cls: 'oasis_heading',
                                            name: "m0063_medicare_na",
                                            inputValue: "1",
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "textfield",
                                            fieldLabel: "(M0064) Social Security Number",
                                            name: "m0064_ssn",
                                            inputMask: '999-99-9999',
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "checkbox",
                                            fieldLabel: "(M0064) Social Security Number: UK",
                                            margin: "0 0 20px 0",
                                            cls: 'oasis_heading',
                                            name: "m0064_ssn_uk",
                                            inputValue: "1",
                                            labelAlign: 'top'
                                        }
                                    ]
                                },
                                {
                                    xtype: "panel",
                                    flex:0.9,
                                    border: false,
                                    items: [
                                        {
                                            xtype: "textfield",
                                            fieldLabel: "(M0065) Medicaid Number",
                                            name: "m0065_medicaid_num",
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "checkbox",
                                            fieldLabel: "(M0065) Medicaid Number: NA",
                                            cls: 'oasis_heading',
                                            name: "m0065_medicaid_na",
                                            inputValue: "1",
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "datefield",
                                            fieldLabel: "(M0066) Birth Date",
                                            name: "m0066_pat_birth_dt",
                                            labelAlign: 'top'
                                        },
                                        {
                                            xtype: "combo",
                                            fieldLabel: "(M0069) Gender",
                                            name: "m0069_pat_gender",
                                            labelAlign: 'top',
                                            store: [[1, "Male"], [2, "Female"]],
                                            editable: false
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    ],
    serverValidationRequiredFields: function () {
        return ["m0032_roc_dt"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return [""]
    },
    selectNpiId: function(){
        this.m0018NpiId.on('change', function(el){
            if(el.value){
                this.m0018NpiUk.setValue(false);
            }
        }, this);
    },
    selectNpiUk: function(){
        this.m0018NpiUk.on('change', function(el){
            if(el.value){
                this.m0018NpiId.setValue(null);
            }
        }, this);
    },
    selectMedNum: function(){
        this.m0063MedNum.on('change', function(el){
            if(el.value){
                this.m0063MedNa.setValue(false);
                medicare1 = this.mainScope.down("[name=m0150_cpay_mcare_ffs]");
                medicare2 = this.mainScope.down("[name=m0150_cpay_mcare_hmo]");
                medicare1.setValue(false).enable();
                medicare2.setValue(false).enable();
            }
        }, this);
    },
    selectMedNa: function(){
        this.m0063MedNa.on('change', function(el){
            if(el.value){
                this.m0063MedNum.setValue(null);
                medicare1 = this.mainScope.down("[name=m0150_cpay_mcare_ffs]");
                medicare2 = this.mainScope.down("[name=m0150_cpay_mcare_hmo]");
                medicare1.setValue(false).disable();
                medicare2.setValue(false).disable();
            }
        }, this);
    },
    selectSsn: function(){
        this.m0064Ssn.on('change', function(el){
            if(el.value){
                this.m0064SsnNa.setValue(false);
            }
        }, this);
    },
    selectSsnNa: function(){
        this.m0064SsnNa.on('change', function(el){
            if(el.value){
                this.m0064Ssn.setValue(null);
            }
        }, this);
    },
    selectMediNum: function(){
        this.m0065MedNum.on('change', function(el){
            if(el.value){
                this.m0065MedNa.setValue(false);
                medicaid1 = this.mainScope.down("[name=m0150_cpay_mcaid_ffs]");
                medicaid2 = this.mainScope.down("[name=m0150_cpay_mcaid_hmo]");
                medicaid1.setValue(false).enable();
                medicaid2.setValue(false).enable();
            }
        }, this);
    },
    selectMediNa: function(){
        this.m0065MedNa.on('change', function(el){
            if(el.value){
                this.m0065MedNum.setValue(null);
                medicaid1 = this.mainScope.down("[name=m0150_cpay_mcaid_ffs]");
                medicaid2 = this.mainScope.down("[name=m0150_cpay_mcaid_hmo]");
                medicaid1.setValue(false).disable();
                medicaid2.setValue(false).disable();
            }
        }, this);
    },
    selectDate: function(){
        this.m0032Date.on('change', function(el){
            if(el.value){
                this.m0032Na.setValue(false);
            }
        }, this);
    },
    selectDateNa: function(){
        this.m0032Na.on('change', function(el){
            if(el.value){
                this.m0032Date.setValue(null);
            }
        }, this);
    },
    onValidate: function(main){
        var errs = new Array();
        m0018NpiIdValue = main.down("[name=m0018_physician_id]").value;
        m0018NpiUkValue = main.down("[name=m0018_physician_uk]").value;
        m0040PatLname = main.down("[name=m0040_pat_lname]").value;
        m0050PatState = main.down("[name=m0050_pat_st]").value;
        m0060PatZip = main.down("[name=m0060_pat_zip]");
        m0020PidValue = main.down("[name=m0020_pat_id]").value;
        m0032Date = main.down("[name=m0032_roc_dt]");
        m0032DateNaValue = main.down("[name=m0032_roc_dt_na]").value;
        m0063MedNum = main.down("[name=m0063_medicare_num]");
        m0063MedNA = main.down("[name=m0063_medicare_na]");
        m0064SSN = main.down("[name=m0064_ssn]");
        m0064SSNUK = main.down("[name=m0064_ssn_uk]");
        m0065MediNumValue = main.down("[name=m0065_medicaid_num]").value;
        m0065MediNaValue = main.down("[name=m0065_medicaid_na]").value;
        m0065MediNaValue = main.down("[name=m0065_medicaid_na]").value;
        m0030StartCareDt = main.down("[name=m0030_start_care_dt]");
        m0903LastHomeVisitDt = main.down("[name=m0903_last_home_visit]");
        m0906DCTranDthDt = main.down("[name=m0906_dc_tran_dth_dt]");
        m0090InfoCompletedDt = main.down("[name=m0090_info_completed_dt]");
        m1005InpDischargeDt = main.down("[name=m1005_inp_discharge_dt]");
        m0040PatFname = main.down("[name=m0040_pat_fname]");
        m0040PatMi = main.down("[name=m0040_pat_mi]");
        m0040PatSuffix = main.down("[name=m0040_pat_suffix]");
        m0050PatSt = main.down("[name=m0050_pat_st]");
        m0066PatBirthDt = main.down("[name=m0066_pat_birth_dt]");
        m0069PatGender = main.down("[name=m0069_pat_gender]");
        var notValidValues = ["111111111", "333333333", "999999999", "123456789"];
        var valid = true;
        if(m0018NpiIdValue == "" && m0018NpiUkValue == false){
            errs.push(['M0018', "Enter the NPI of the Physician who will sign the Plan of Care OR select Physician NPI Unknown."]);
        } else if(m0018NpiIdValue){
            if (m0018NpiIdValue.match(/([0-9]){10}/) == null){
                errs.push(['M0018', "Primary Referring Physician National Provider ID (NPI) it must consist of 10 digits with no embedded spaces or blanks."]);
            }
        }
        if(m0040PatFname.value != null && m0040PatFname.value.length > 12){
            errs.push(["M0040", "Patient first name should not be more than 12 characters"]);
        }

        if(m0040PatMi.value != null && m0040PatMi.value.length > 1){
            errs.push(["M0040", "Patient Middle initial should not be more than 1 character"]);
        }

        if(m0040PatLname == null || m0040PatLname == "" ){
            errs.push(['M0040', "Enter the patient's full name."]);
        }

        if(m0040PatLname != null && m0040PatLname.length > 18){
            errs.push(['M0040', "Patient last name should not be more than 18 characters"]);
        }

        if(m0040PatSuffix.value != null && m0040PatSuffix.value.length > 3){
            errs.push(['M0040', "Patient suffix should not be more than 3 characters"]);
        }

        if(m0069PatGender.value == null || m0069PatGender.value == ""){
            errs.push(['M0069', "Enter the patient gender"]);
        }

        if(m0050PatSt.value == null || m0050PatSt.value==""){
            errs.push(['M0050', "Enter the patient state code"]);
        }else if(m0050PatSt.value != null && m0050PatSt.value.length != 2){
            errs.push(['M0050', "State code should  be 2 characters"]);
        }else if(m0050PatSt.value != null && m0050PatSt.value.toUpperCase() != m0050PatSt.value){
            errs.push(['M0050', "State code should be in upper case"]);
        }else if(m0050PatSt.value != null && m0050PatSt.value.length == 2 && m0050PatSt.value.toUpperCase() == m0050PatSt.value){
            main.checkForProperState({state_code: m0050PatSt.value}, function(res){
                if(res){
                    errs.push(['M0050', "Enter the valid state code"]);
                }
            },this);
        }
        if(m0060PatZip.value == null || m0060PatZip.value == "" ){
            errs.push(['M0060', "Enter the Patient Zip Code."]);
        }else if(m0060PatZip.value != null && m0060PatZip.value.match(/^([0-9]){5}([0-9\s]){0,4}(\s){0,2}$/) == null) {
            errs.push(['M0060', "Patient Zip Code: Bytes 1 through 5 must contain numbers (0 through 9). Bytes 6 through 9 must contain numbers (0 through 9) or blanks. Bytes 10 through 11 must contain blanks."]);
        }else if(m0060PatZip.value != null){
            main.checkForProperZipCode({zip_code: m0060PatZip.value}, function(res){
                if(res){
                    errs.push(['M0060', "Enter the valid zip code"]);
                }
            }, this);
        }

        if(m0066PatBirthDt && (m0066PatBirthDt.value == null || m0066PatBirthDt.value == "")){
            errs.push(['M0066', "Enter the birth date"]);
        }else if(m0066PatBirthDt && m0066PatBirthDt.value != null && m0066PatBirthDt.isValid() == false){
            errs.push(['M0066', "Enter the valid date of birth"]);
        }

        if(m0063MedNum && (m0063MedNum.value == null || m0063MedNum.value == "") && m0063MedNA && m0063MedNA.value == false){
            errs.push(["M0063", "Enter Medicare number or select Not Applicable(NA)."]);
        } else if (m0063MedNum && m0063MedNum.value) {
            if(m0063MedNum.value.length > 12){
                errs.push(["M0063", "Medicare number should not be more than 12 characters"]);
            }
            if (m0063MedNum.value.match(/[-\s]/)){
                errs.push(["M0063", "Medicare number must be alphanumeric with no embedded dashes or spaces."]);
            }
            if (m0063MedNum.value.match(/^([0-9]){1}/) && m0063MedNum.value.match(/^([0-9]){9}/) == null){
                errs.push(["M0063", "Medicare number: If the first character is numeric (0 through 9), then the first 9 characters must be numeric."]);
            }
            if (m0063MedNum.value.match(/^[a-zA-z]{1}/) && m0063MedNum.value.match(/^([a-zA-Z]){3}([0-9]){6,9}(\s){0,3}/) == null){
                errs.push(["M0063", "Medicare number: If the first character is a letter, then there must be 1 to 3 alphabetic characters followed by 6 or 9 numbers followed by spaces up to the field length of 12."]);
            }
            valid = true;
            Ext.each(notValidValues, function(val, index){
                if (val == m0063MedNum.value) valid = false;
            }, this);
            if (!valid){
                errs.push(["M0063", "Medicare number: It must not equal any of the following values: 111111111, 333333333, 999999999, 123456789."]);
            }
        }
        if(m0064SSN && m0064SSN.value == "" && m0064SSNUK && m0064SSNUK.value == false){
            errs.push(["M0064", "Enter Patient's Social Security Number or select UK."]);
        }else if(m0064SSN && m0064SSN.value){
            if(m0064SSN.value.length != 9){
                errs.push(["M0064", "Patient's Social Security Number: It must contain 9 digits (0 through 9)."]);
            }
            if(m0064SSN.value.match(/^000/)){
                errs.push(["M0064", "Patient's Social Security Number: It cannot start with 000."]);
            }
            if(m0064SSN.value.match(/[-\s]/)){
                errs.push(["M0064", "Patient's Social Security Number: There must be no embedded dashes or spaces."]);
            }
            valid = true;
            Ext.each(notValidValues, function(val, index){
                if (val == m0064SSN.value) valid = false;
            }, this);
            if (!valid){
                errs.push(["M0064", "Patient's Social Security Number: It must not equal any of the following values: 111111111, 333333333, 999999999, 123456789."]);
            }
        }
        if(m0020PidValue == null || m0020PidValue == ""){
            errs.push(['M0020', "Enter the patient's medical record number."]);
        }
        if(m0020PidValue != null && m0020PidValue.length > 20){
            errs.push(['M0020', "Patient's medical record number should be less than or equal to 20 characters."]);
        }

        if (m0030StartCareDt.value == null){
            errs.push(['M0030', "Start of Care Date can't be blank."]);
        } else if (m0030StartCareDt.value != null && m0030StartCareDt.isValid()){
            if (m0030StartCareDt.value > new Date()) {
                errs.push(['M0030', "Start of care date must be less than or equal to the current date."]);
            }
            var m0100AssessmentReason = this.mainScope.down("[name=m0100_assmt_reason]");
            if(m0100AssessmentReason.value == '01' && m0030StartCareDt.value < new Date(99,6,19,0,0,0)){
                errs.push(['M0030', "Start of Care date cannot precede 07/19/1999."]);
            }
            if(m0032Date != null && m0032Date.isValid() && m0032DateNaValue == false && m0030StartCareDt.value > m0032Date.value){
                errs.push(['M0030', "Start of Care date should be earlier than or equal to Resumption of care date."]);
            }
            if(m0903LastHomeVisitDt != null && m0903LastHomeVisitDt.isValid() && m0030StartCareDt.value > m0903LastHomeVisitDt.value){
                errs.push(['M0030', "Start of Care date should be earlier than or equal to Date of Last Home Visit."]);
            }
            if(m0906DCTranDthDt != null && m0906DCTranDthDt.isValid() && m0030StartCareDt.value > m0906DCTranDthDt.value){
                errs.push(['M0030', "Start of Care date should be earlier than or equal to Discharge, Transfer, Death Date."]);
            }
            if(m0090InfoCompletedDt != null && m0090InfoCompletedDt.isValid() && m0030StartCareDt.value > m0090InfoCompletedDt.value){
                errs.push(['M0030', "Start of Care date should be earlier than or equal to Date Assessment Completed."]);
            }
        }

        var m0100AssessmentReason = this.mainScope.down("[name=m0100_assmt_reason]");
        if(m0100AssessmentReason.value == '03'){
            if(m0032DateNaValue){
                errs.push(['M0032', "For this assessment Resumption of care date can't be NA."]);
            }
            if(m0032Date.value && m0032Date.isValid() && m0090InfoCompletedDt && m0090InfoCompletedDt.value){
                var days = (m0090InfoCompletedDt.value - m0032Date.value)/86400000;
                if (days > 2 || days < 0){
                    errs.push(['M0032', "Info completed date minus Resumption of care date should be greater than or equal to zero and less than or equal to 2."]);
                }
            }
            if(m0032Date.value && m0032Date.isValid() && m1005InpDischargeDt && m1005InpDischargeDt.value){
                var days = (m0032Date.value - m1005InpDischargeDt.value)/86400000;
                if (days > 14 || days < 0){
                    errs.push(['M0032', "Resumption of care date minus Most Recent Inpatient Discharge Date should be greater than or equal to zero and less than or equal to 14."]);
                }
            }
        }
        if(m0032Date.value == null && m0032DateNaValue == false){
            errs.push(['M0032', "Enter the resumption of care date or check resumption of care date 'NA'."]);
        } else if (m0032Date.value != null && m0032Date.isValid()){
            if (m0032Date.value > new Date()) {
                errs.push(['M0032', "Resumption of care date must be less than or equal to the current date."]);
            }
            if(m0100AssessmentReason.value == '03' && m0032Date.value < new Date(99,6,19,0,0,0)){
                errs.push(['M0032', "Resumption of care date cannot precede 07/19/1999."]);
            }
            if(m0903LastHomeVisitDt != null && m0903LastHomeVisitDt.isValid() && m0032Date.value > m0903LastHomeVisitDt.value){
                errs.push(['M0032', "Resumption of care date should be earlier than or equal to Date of Last Home Visit."]);
            }
            if(m0906DCTranDthDt != null && m0906DCTranDthDt.isValid() && m0032Date.value > m0906DCTranDthDt.value){
                errs.push(['M0032', "Resumption of care date should be earlier than or equal to Discharge, Transfer, Death Date."]);
            }
            if(m0090InfoCompletedDt != null && m0090InfoCompletedDt.isValid() && m0032Date.value > m0090InfoCompletedDt.value){
                errs.push(['M0032', "Resumption of care date should be earlier than or equal to Date Assessment Completed."]);
            }
        }
        //console.log("Value = " + this.m0016_branchId.value);
        //console.log("match = " + this.m0016_branchId.value.match(/^[\d[A-Z]]\{2\}Q[\d[A-Z]]\{4\}\d\{3\}/));
        var errMsg = "Enter a valid branch ID number, OR enter 'N' for none and 'P' for parent.";
        var pattern1 = new RegExp(/^[N,P]{1}$/);
        var pattern2 = new RegExp(/^([A-Z0-9]){2}Q([A-Z0-9]){4}([0-9]){3}$/);
        if(this.m0016_branchId.value == null){
            errs.push(['M0016', "Enter a valid branch ID number, OR enter 'N' for none and 'P' for parent."]);
        } else if  (this.m0016_branchId.value.length == 1 && !pattern1.test(this.m0016_branchId.value)) {
            errs.push(['M0016', errMsg]);
        } else if (this.m0016_branchId.value.length != 1 && (this.m0016_branchId.value.length < 10 || this.m0016_branchId.value.length > 10)){
            errs.push(['M0016', errMsg]);
        } else if (this.m0016_branchId.value.length == 10 && !pattern2.test(this.m0016_branchId.value)){
            errs.push(['M0016', errMsg]);
        }
        if(this.m0016_branchId.value.length == 10 && pattern2.test(this.m0016_branchId.value) && this.m0014BranchState.value == ""){
            errs.push(['M0014', "If a standard branch ID (i.e., not N or P) is submitted, then Branch State cannot be blank."]);
        }
        if((m0065MediNumValue == null || m0065MediNumValue == "") && m0065MediNaValue == false){
            errs.push(['M0065', 'At least select one item from either Medicaid Number_NA or Medicaid Number'])
        }else if(m0065MediNumValue != null && m0065MediNumValue.length > 14){
            errs.push(['M0065', 'Medicaid Number should not be more than 14 characters'])
        }
        return errs;
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.m0014BranchState = this.mainScope.down("[name=m0014_branch_state]");
        this.m0018NpiId = this.mainScope.down('textfield[name=m0018_physician_id]');
        this.m0018NpiUk = this.mainScope.down('checkbox[name=m0018_physician_uk]');
        this.m0063MedNum = this.mainScope.down('textfield[name=m0063_medicare_num]');
        this.m0063MedNa = this.mainScope.down('checkbox[name=m0063_medicare_na]');
        this.m0064Ssn = this.mainScope.down('textfield[name=m0064_ssn]');
        this.m0064SsnNa = this.mainScope.down('checkbox[name=m0064_ssn_uk]');
        this.m0065MedNum = this.mainScope.down('textfield[name=m0065_medicaid_num]');
        this.m0065MedNa = this.mainScope.down('checkbox[name=m0065_medicaid_na]');
        this.m0032Date = this.mainScope.down('datefield[name=m0032_roc_dt]');
        this.m0032Na = this.mainScope.down('checkbox[name=m0032_roc_dt_na]');
        this.m0016_branchId = this.mainScope.down("[name=m0016_branch_id]");
        this.m0010Ccn = this.mainScope.down("[name=m0010_ccn]");
        this.m0014BranchState = this.mainScope.down("[name=m0014_branch_state]");
        this.refreshAgencyInfo = this.mainScope.down("[name=refresh_agency_info]");
        this.m0030SocDate = this.mainScope.down("[name=m0030_start_care_dt]");
        this.m0040PatFname = this.mainScope.down("[name=m0040_pat_fname]");
        this.m0040PatLname = this.mainScope.down("[name=m0040_pat_lname]");
        this.m0066PatBirthDt = this.mainScope.down("[name=m0066_pat_birth_dt]");
        this.m0069PatGender = this.mainScope.down("[name=m0069_pat_gender]");
        this.selectNpiId();
        this.selectNpiUk();
        this.selectMedNum();
        this.selectMedNa();
        this.selectSsn();
        this.selectSsnNa();
        this.selectMediNum();
        this.selectMediNa();
        this.selectDate();
        this.selectDateNa();

        if (this.mainScope.hideRefreshAgencyInfo) this.refreshAgencyInfo.hide();
        if (this.mainScope.socDateKeyField) this.m0030SocDate.setReadOnly(true);
        if (this.mainScope.rocDateKeyField) this.m0032Date.setReadOnly(true);
        if (this.mainScope.nonKeyFieldCorrection) {
            this.m0040PatFname.setReadOnly(true);
            this.m0040PatLname.setReadOnly(true);
            this.m0064Ssn.setReadOnly(true);
            this.m0066PatBirthDt.setReadOnly(true);
            this.m0069PatGender.setReadOnly(true);
        }
        this.refreshAgencyInfo.on('click', function(){
            this.mainScope.getAgencyInfo({}, function(res){
                this.m0010Ccn.setValue(res[0]);
                this.m0014BranchState.setValue(res[1]);
                this.m0016_branchId.setValue(res[2]);
            },this);
        },this);
    }
})
