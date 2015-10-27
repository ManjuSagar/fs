/**
 * Created by msuser1 on 10/12/14.
 */

Ext.define('Ext.panel.DiagnosesRegimenChangeM1016M1018', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.diagnosesRegimenChangeM1016M1018',
    border: false,
    margin: 5,
    layout: {type: "table", columns: 2},
    items: [
        {
            border: false,
            flex: 1,
            items: [
                {
                    xtype: "label",
                    columns: 1,
                    text: "(M1016) Diagnoses Requiring Medical or Treatment Regimen Change Within Past 14 Days: List the patient's Medical Diagnoses and ICD-9-CM codes at the level of highest specificity for those conditions requiring changed medical or treatment regimen within the past 14 days.(no surgical, E codes, or V codes):"
                },
                {
                    xtype: 'netzkeremotecombo',
                    fieldLabel: "a",
                    name: "m1016_chgreg_icd1",
                    labelAlign: 'right'
                },
                {
                    xtype: 'netzkeremotecombo',
                    fieldLabel: "b",
                    name: "m1016_chgreg_icd2",
                    labelAlign: 'right'
                },
                {
                    xtype: 'netzkeremotecombo',
                    fieldLabel: "c",
                    name: "m1016_chgreg_icd3",
                    labelAlign: 'right'
                },
                {
                    xtype: 'netzkeremotecombo',
                    fieldLabel: "d",
                    name: "m1016_chgreg_icd4",
                    labelAlign: 'right'
                },
                {
                    xtype: 'netzkeremotecombo',
                    fieldLabel: "e",
                    name: "m1016_chgreg_icd5",
                    labelAlign: 'right'
                },
                {
                    xtype: 'netzkeremotecombo',
                    fieldLabel: "f",
                    name: "m1016_chgreg_icd6",
                    labelAlign: 'right'
                },
                {
                    xtype: "checkboxfield",
                    fieldLabel: "NA",
                    name: "m1016_chgreg_icd_na",
                    labelAlign: 'right',
                    boxLabel: "NA - Not applicable (no medical or treatment regimen changes within the past 14 days)",
                    inputValue: "1"
                }

            ]
        },
        {
            xtype: 'checkboxgroup',
            fieldLabel: "(M1018) Conditions Prior to Medical or Treatment Regimen Change or Inpatient Stay Within Past 14 Days: If this patient experienced an inpatient facility discharge or change in medical or treatment regimen within the past 14 days, indicate any conditions that existed prior to the inpatient stay or change in medical or treatment regimen. (Mark all that apply.)",
            labelAlign: 'top',
            columns: 1,
            flex: 1,
            margin: 5,
            items: [
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_ur_incon",
                    boxLabel: '1 - Urinary incontinence',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_cath",
                    boxLabel: '2 - Indwelling/suprapubic catheter',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_intract_pain",
                    boxLabel: '3 - Intractable pain',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_impr_decsn",
                    boxLabel: '4 - Impaired decision-making',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_disruptive",
                    boxLabel: '5 - Disruptive or socially inappropriate behavior',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_mem_loss",
                    boxLabel: '6-Memory loss to the extent that supervision required',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_none",
                    boxLabel: '7 - None of the above',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_nochg_14d",
                    boxLabel: 'NA - No inpatient facility discharge and no change in medical or treatment regimen in past 14 days ',
                    inputValue: "1"
                },
                {
                    xtype: 'checkboxfield',
                    name: "m1018_prior_unknown",
                    boxLabel: 'UK - Unknown',
                    inputValue: "1"
                }
            ]
        }

    ],
    serverValidationRequiredFields: function(){
        return ["m1016_chgreg_icd1", "m1016_chgreg_icd2", "m1016_chgreg_icd3", "m1016_chgreg_icd4", "m1016_chgreg_icd5", "m1016_chgreg_icd6"]
    },
    serverValidationRequiredFieldsSuffix: function(){
        return ["a", "b", "c", "d", "e", "f"]
    },
    selectOtherValues: function(){
        Ext.each(this.m1018Fields, function(element){
            this.down("[name="+element+"]").on('change', function(el){
                if(el.value){
                    this.noneOfAbove.setValue(false);
                    this.notAvilable.setValue(false);
                    this.unknown.setValue(false);
                }
            }, this);
        }, this);
    },
    selectUnknown: function(){
        this.unknown.on('change', function(el){
            if(el.value){
                Ext.each(this.m1018Fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
                this.noneOfAbove.setValue(false);
                this.notAvilable.setValue(false);
            }
        }, this);
    },
    selectNotAvailable: function(){
        this.notAvilable.on('change', function(el){
            if(el.value){
                Ext.each(this.m1018Fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
                this.noneOfAbove.setValue(false);
                this.unknown.setValue(false);
            }
        }, this);
    },
    selectNoneOfAbove: function(){
        this.noneOfAbove.on('change', function(el){
            if(el.value){
                Ext.each(this.m1018Fields, function(element){
                    this.down("checkbox[name="+element+"]").setValue(false);
                }, this);
                this.notAvilable.setValue(false);
                this.unknown.setValue(false);
            }
        }, this);
    },
    selectCombo: function(){
        Ext.each(this.m1016Fields, function(element){
            this.down("[name="+element+"]").on('select', function(el){
                if(el.value != null){
                    this.chgregIcdNa.setValue(false);
                }
            },this);
        }, this);
    },
    selectChgregIcdNa: function(){
        this.chgregIcdNa.on('change', function(el){
            if(el.value){
                Ext.each(this.m1016Fields, function(element){
                    this.query("[name="+element+"]")[0].setValue(null);
                },this);
            }
        },this);
    },
    afterRender: function(){
        this.callParent();
        this.mainScope = Ext.ComponentQuery.query('#super_main')[0];
        this.m1016ChgregIcd1 = this.mainScope.down('[name=m1016_chgreg_icd1]');
        this.m1016ChgregIcd2 = this.mainScope.down('[name=m1016_chgreg_icd2]');
        this.m1016ChgregIcd3 = this.mainScope.down('[name=m1016_chgreg_icd3]');
        this.m1016ChgregIcd4 = this.mainScope.down('[name=m1016_chgreg_icd4]');
        this.m1016ChgregIcd5 = this.mainScope.down('[name=m1016_chgreg_icd5]');
        this.m1016ChgregIcd6 = this.mainScope.down('[name=m1016_chgreg_icd6]');
        this.m1016Fields = ["m1016_chgreg_icd1", "m1016_chgreg_icd2", "m1016_chgreg_icd3", "m1016_chgreg_icd4", "m1016_chgreg_icd5", "m1016_chgreg_icd6"]
        this.m1018Fields = ["m1018_prior_ur_incon", "m1018_prior_cath", "m1018_prior_intract_pain", "m1018_prior_impr_decsn", "m1018_prior_disruptive", "m1018_prior_mem_loss"]
        this.chgregIcdNa = this.mainScope.down('checkboxfield[name=m1016_chgreg_icd_na]');
        this.noneOfAbove = this.mainScope.down('checkbox[name=m1018_prior_none]');
        this.notAvilable = this.mainScope.down('checkbox[name=m1018_prior_nochg_14d]');
        this.unknown = this.mainScope.down('checkbox[name=m1018_prior_unknown]');
        this.episodeDate = Ext.ComponentQuery.query('#patient_treatment_episode')[0];
        this.infoCompletedDt = this.mainScope.down('[name=m0090_info_completed_dt]');
        this.selectChgregIcdNa();
        this.selectCombo();
        this.selectNoneOfAbove();
        this.selectNotAvailable();
        this.selectUnknown();
        this.selectOtherValues();
    },
    onValidate: function(main){
        var errs = new Array();
        var fromDate = new Date("October 1, 2015");
        var chkEndDate = new Date("October 5, 2015");
        var episodeDate = this.episodeDate.getRawValue();
        var startDate = new Date(episodeDate.split(' ')[0]);
        var isAfterOct = (startDate > chkEndDate);
        var validationFlag = false;
        if (!isAfterOct && this.infoCompletedDt.value < fromDate) {
            validationFlag = true;
        }
        m1016ChgregIcdNa = this.mainScope.down('[name=m1016_chgreg_icd_na]').value;
        m1016ChgregIcd1 = this.mainScope.down('[name=m1016_chgreg_icd1]').value;
        m1016ChgregIcd2 = this.mainScope.down('[name=m1016_chgreg_icd2]').value;
        m1016ChgregIcd3 = this.mainScope.down('[name=m1016_chgreg_icd3]').value;
        m1016ChgregIcd4 = this.mainScope.down('[name=m1016_chgreg_icd4]').value;
        m1016ChgregIcd5 = this.mainScope.down('[name=m1016_chgreg_icd5]').value;
        m1016ChgregIcd6 = this.mainScope.down('[name=m1016_chgreg_icd6]').value;
        m1018PriorIncon = this.mainScope.down('[name=m1018_prior_ur_incon]').value;
        m1018PriorCath = this.mainScope.down('[name=m1018_prior_cath]').value;
        m1018PriorPain = this.mainScope.down('[name=m1018_prior_intract_pain]').value;
        m1018PriorDecsn = this.mainScope.down('[name=m1018_prior_impr_decsn]').value;
        m1018PriorDisruptive = this.mainScope.down('[name=m1018_prior_disruptive]').value;
        m1018PriorLoss = this.mainScope.down('[name=m1018_prior_mem_loss]').value;
        m1018PriorNone = this.mainScope.down('[name=m1018_prior_none]').value;
        m1018PriorNochg = this.mainScope.down('[name=m1018_prior_nochg_14d]').value;
        m1018PriorUnknown = this.mainScope.down('[name=m1018_prior_unknown]').value;
        m1000InPatientFacility = this.mainScope.down('[name=m1000_dc_none_14_da]').value;
        if(m1016ChgregIcdNa == false){
            if(m1016ChgregIcd1 == null && m1016ChgregIcd2 == null && m1016ChgregIcd3 == null && m1016ChgregIcd4 == null &&
                m1016ChgregIcd5 == null && m1016ChgregIcd6 == null && validationFlag){
                errs.push(["M1016", "Enter at least one diagnosis requiring medical or treatment regimen change within the past 14 days OR select 'NA'."]);
            }
        }
        if (m1016ChgregIcd2)
        {
            diag_b = [this.m1016ChgregIcd1];
            Ext.each(diag_b, function(ele){
                if(m1016ChgregIcd2 == ele.value){
                errs.push(['M1016', "The  diagnosis code 'b' cannot be the same as the " + this.getMessage(ele.name)]);
                }
            },this);
        }
        if (m1016ChgregIcd3)
        {
            diag_c = [this.m1016ChgregIcd1,this.m1016ChgregIcd2];
            Ext.each(diag_c, function(ele){
                if(m1016ChgregIcd3 == ele.value){
                errs.push(['M1016', "The  diagnosis code 'c' cannot be the same as the " + this.getMessage(ele.name)]);
                }
            },this);
        }
        if (m1016ChgregIcd4)
        {
            diag_d = [this.m1016ChgregIcd1,this.m1016ChgregIcd2,this.m1016ChgregIcd3];
            Ext.each(diag_d, function(ele){
                if(m1016ChgregIcd4 == ele.value){
                errs.push(['M1016', "The  diagnosis code 'd' cannot be the same as the " + this.getMessage(ele.name)]);
                }
            },this);
        }
        if (m1016ChgregIcd5)
        {
            diag_e = [this.m1016ChgregIcd1,this.m1016ChgregIcd2,this.m1016ChgregIcd3,this.m1016ChgregIcd4,];
            Ext.each(diag_e, function(ele){
                if(m1016ChgregIcd5 == ele.value){
                errs.push(['M1016', "The  diagnosis code 'e' cannot be the same as the " + this.getMessage(ele.name)]);
                }
            },this);
        }
        if (m1016ChgregIcd6)
        {
            diag_f = [this.m1016ChgregIcd1,this.m1016ChgregIcd2,this.m1016ChgregIcd3,this.m1016ChgregIcd4,this.m1016ChgregIcd5];
            Ext.each(diag_f, function(ele){
                if(m1016ChgregIcd6 == ele.value){
                errs.push(['M1016', "The  diagnosis code 'f' cannot be the same as the " + this.getMessage(ele.name)]);
                }
            },this);
        }
        if(m1018PriorIncon == false && m1018PriorCath == false && m1018PriorPain == false && m1018PriorDecsn == false &&
            m1018PriorDisruptive == false && m1018PriorLoss == false && m1018PriorNone == false && m1018PriorNochg == false &&
            m1018PriorUnknown == false && validationFlag){
            errs.push(["M1018", "Select at least one conditions that existed prior to the medical or treatment regimen change OR select 'NA' or 'Unknown'."]);
        }

        if(m1016ChgregIcdNa == true && m1000InPatientFacility == true && m1018PriorNochg == false  && validationFlag){
            errs.push(["M1018", "If M1000 is 'NA' and M1016 is 'NA' then M1018 must be 'NA'."]);
        }
        m1000Fields = ["m1000_dc_ltc_14_da", "m1000_dc_snf_14_da", "m1000_dc_ipps_14_da", "m1000_dc_ltch_14_da", "m1000_dc_irf_14_da",
            "m1000_dc_psych_14_da", "m1000_dc_oth_14_da"];
        var res = false;
        Ext.each(m1000Fields, function(field, index){
            if(this.mainScope.down("[name="+field+"]").value) res = true;
        }, this);
        if((res || m1016ChgregIcdNa == false) && m1018PriorNochg == true && validationFlag){
            errs.push(["M1018", "M1000 is 'NA' OR M1016 is not 'NA' then M1018 can't be 'NA'."]);
        }
        return errs;
    },
        getMessage: function(code){
        icd_codes = {}
        icd_codes["m1016_chgreg_icd1"] = " diagnosis code 'a'.";
        icd_codes["m1016_chgreg_icd2"] = " diagnosis code 'b'.";
        icd_codes["m1016_chgreg_icd3"] = " diagnosis code 'c'.";
        icd_codes["m1016_chgreg_icd4"] = " diagnosis code 'd'.";
        icd_codes["m1016_chgreg_icd5"] = " diagnosis code 'e'.";
        icd_codes["m1016_chgreg_icd6"] = " diagnosis code 'f'.";
        return icd_codes[code]
    }
})
