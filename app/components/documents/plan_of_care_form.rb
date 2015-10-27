# Custom user form (predefined model and layout)
class Documents::PlanOfCareForm < Documents::AbstractDocumentForm

  def configuration
    c = super
     treatment_id = c[:strong_default_attrs][:treatment_id] if c[:strong_default_attrs]
      treatment_episode_id = c[:strong_default_attrs][:treatment_episode_id] if c[:strong_default_attrs]
      episode_id = c[:strong_default_attrs][:episode_id] if c[:strong_default_attrs]
    #TODO We have to change it as a single name either episode_id or treatment_episode_id
      episode_id ||= treatment_episode_id
      if treatment_id
        org = PatientTreatment.find(treatment_id).patient.org
        episode_start_date = TreatmentEpisode.org_scope(org).find(episode_id).start_date
        icd9flag = episode_start_date < Date.parse('03-08-2015')
        icd0910flag =  (episode_start_date >= Date.parse('03-08-2015') and episode_start_date < Date.parse('01-10-2015'))
        show_icd_9_fields = (icd9flag or icd0910flag)
        icd10flag = (episode_start_date >= Date.parse('01-10-2015'))
        show_icd_10_fields = (icd10flag or icd0910flag)
      end
    if c[:record_id]
      poc = PlanOfCare.find(c[:record_id])
      hide_refresh_button = poc.hide_refresh_button
    end
    c.merge(
        model: "PlanOfCare",
        items:[
            {
                xtype: 'container',
                height: 768,
                width: 1024,
                layout: {
                    type: 'fit'
                },
                items: [
                    {
                        xtype: 'form',
                        border: 0,
                        frame: false,
                        style: 'color:green;',
                        focusOnToFront: false,
                        layout: {
                            type: 'border'
                        },
                        bodyBorder: false,
                        bodyPadding: 10,
                        closable: false,
                        collapsible: false,
                        manageHeight: false,
                        title: '',
                        paramsAsHash: false,
                        items: [
                            {
                                xtype: 'panel',
                                region: 'north',
                                border: 0,
                                layout: {
                                    type: 'fit'
                                },
                                items: [
                                    :patient_details.component
                                ]
                            },
                            {
                                xtype: 'tabpanel',
                                region: 'center',
                                margin: '5px',
                                activeTab: 0,
                                plain: true,
                                items: [
                                    {
                                        xtype: 'panel',
                                        autoScroll: false,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'POC Date/Diagnosis',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                height: 713,
                                                items: [
                                                    {
                                                        xtype: 'fieldset',
                                                        layout: {
                                                            type: 'auto'
                                                        },
                                                        title: 'POC Date',
                                                        margin: 3,
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                layout: 'hbox',
                                                                align: 'stretch',
                                                                border: false,
                                                                items: [
                                                                    {
                                                                        xtype: 'datefield',
                                                                        anchor: '100%',
                                                                        fieldLabel: 'POC Date',
                                                                        margin: 3,
                                                                        allowBlank: false,
                                                                        name: "poc_date",
                                                                        label_align: 'right'
                                                                    },
                                                                    {
                                                                        xtype: 'button',
                                                                        margin: '3 0 0 30',
                                                                        text: 'Import Diagnosis from OASIS',
                                                                        cls: 'drug_interactions_button',
                                                                        name: 'refresh_poc_diagnoses',
                                                                        hidden: hide_refresh_button
                                                                    }
                                                                ]
                                                            }
                                                        ]

                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: 0,
                                                        height: 530,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'hbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'Diagnosis',
                                                                items: [
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: false,
                                                                        layout: {
                                                                            columns: (icd0910flag)? 4 : 3,
                                                                            type: 'table'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd1',
                                                                                fieldLabel: 'ICD-9-CM Principal Diagnosis ',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd10_1',
                                                                                fieldLabel: 'ICD-10-CM Principal Diagnosis ',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date1',
                                                                                fieldLabel: 'Date',
                                                                                margin: '0 0 3px 3px',
                                                                                labelAlign: 'top'
                                                                            },
                                                                              {
                                                                                    xtype: 'combo',
                                                                                name: 'principal_oe1',
                                                                                fieldLabel: 'O/E',
                                                                                margin: '0 0 3px 3px',
                                                                                labelAlign: 'top',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd2',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd10_2',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date2',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'principal_oe2',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd3',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd10_3',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date3',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'principal_oe3',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd4',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd10_4',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date4',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'principal_oe4',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd5',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd10_5',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date5',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'principal_oe5',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd6',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'principal_icd10_6',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'principal_date6',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'principal_oe6',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: false,
                                                                        height: 190,
                                                                        layout: {
                                                                            columns: (icd0910flag)? 4 : 3,
                                                                            type: 'table'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd1',
                                                                                fieldLabel: 'ICD-9-CM Other Pertinent Diagnosis',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd10_1',
                                                                                fieldLabel: 'ICD-10-CM Other Pertinent Diagnosis',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                width: 150,
                                                                                name: 'pertinent_date1',
                                                                                fieldLabel: 'Date',
                                                                                margin: '0 0 3px 3px',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'pertinent_oe1',
                                                                                fieldLabel: 'O/E',
                                                                                margin: '0 0 3px 3px',
                                                                                labelAlign: 'top',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd2',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd10_2',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date2',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'pertinent_oe2',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store:['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd3',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd10_3',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date3',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'pertinent_oe3',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd4',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd10_4',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !icd10flag,
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date4',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'pertinent_oe4',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd5',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd10_5',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date5',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'pertinent_oe5',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',
                                                                                parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd6',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'pertinent_icd10_6',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields,
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'pertinent_date6',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'pertinent_oe6',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'panel',
                                                                        border: false,
                                                                        height: 126,
                                                                        layout: {
                                                                            columns: (icd0910flag)? 4 : 3,
                                                                            type: 'table'
                                                                        },
                                                                        items: [
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd1',
                                                                                fieldLabel: 'ICD-9-CM Surgical Procedure',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd10_1',
                                                                                fieldLabel: 'ICD-10-PCS Surgical Procedure',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date1',
                                                                                fieldLabel: 'Date',
                                                                                margin: '0 0 3px 3px',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'surgical_oe1',
                                                                                fieldLabel: 'O/E',
                                                                                margin: '0 0 3px 3px',
                                                                                labelAlign: 'top',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd2',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd10_2',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date2',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                labelAlign: 'top'
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'surgical_oe2',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd3',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd10_3',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date3',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'surgical_oe3',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd4',
                                                                                margin: '0 0 3px 5px',
                                                                                fieldLabel: '',
                                                                                hidden: !show_icd_9_fields
                                                                            },
                                                                            {
                                                                                xtype: 'netzkeremotecombo',parent_id: self.global_id,
                                                                                width: 380,
                                                                                name: 'surgical_icd10_4',
                                                                                fieldLabel: '',
                                                                                margin: '0 0 3px 5px',
                                                                                labelAlign: 'top',
                                                                                hidden: !show_icd_10_fields
                                                                            },
                                                                            {
                                                                                xtype: 'datefield',
                                                                                name: 'surgical_date4',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: ''
                                                                            },
                                                                            {
                                                                                xtype: 'combo',
                                                                                name: 'surgical_oe4',
                                                                                margin: '0 0 3px 3px',
                                                                                fieldLabel: '',
                                                                                store: ['O', 'E']
                                                                            }
                                                                        ]
                                                                    },
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        autoScroll: false,
                                        layout: {
                                            align: 'stretch',
                                            type: 'vbox'
                                        },
                                        title: 'DME/Safety Measures/Nutritional Req./Allergies',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                flex: 1,
                                                border: 0,
                                                height: 713,
                                                autoScroll: true,
                                                items: [
                                                    {
                                                        xtype: 'panel',
                                                        border: 0,
                                                        autoScroll: false,
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'hbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'DME and Supplies',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'None',
                                                                                inputValue: 'None'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Cane',
                                                                                inputValue: 'Cane'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Walker',
                                                                                inputValue: 'Walker'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Wheelchair',
                                                                                inputValue: 'Wheelchair'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Hospital bed',
                                                                                inputValue: 'Hospital bed'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Mobility Scooter',
                                                                                inputValue: 'Mobility Scooter'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Comode',
                                                                                inputValue: 'Comode'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Splint',
                                                                                inputValue: 'Splint'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Brace',
                                                                                inputValue: 'Brace'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Crutches',
                                                                                inputValue: 'Crutches'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'dme',
                                                                                boxLabel: 'Orthotic Device '
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textarea',
                                                                        margin: '3px',
                                                                        name: 'other_dme',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'Functional Limitations',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Amputation',
                                                                                inputValue: 'Amputation'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Bowel/Bladder',
                                                                                inputValue: 'Bowel/Bladder'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Contracture',
                                                                                inputValue: 'Contracture'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Hearing',
                                                                                inputValue: 'Hearing'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Paralysis',
                                                                                inputValue: 'Paralysis'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Endurance',
                                                                                inputValue: 'Endurance'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Ambulation',
                                                                                inputValue: 'Ambulation'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Speech',
                                                                                inputValue: 'Speech'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Legally blind ',
                                                                                inputValue: 'Legally blind'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'functional_limitations',
                                                                                boxLabel: 'Dyspnea With Minimal Exertion',
                                                                                inputValue: 'Dyspnea With Minimal Exertion'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '3px',
                                                                        name: 'other_functional_limitations',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'Activities Permitted ',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Complete Bedrest',
                                                                                inputValue: 'Complete Bedrest'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Bedrest BRP',
                                                                                inputValue: 'Bedrest BRP'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Up As Tolerated',
                                                                                inputValue: 'Up As Tolerated'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Transfer Bed/Chair',
                                                                                inputValue: 'Transfer Bed/Chair'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Exercises Prescribed',
                                                                                inputValue: 'Exercises Prescribed'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Partial Weight Bearing',
                                                                                inputValue: 'Partial Weight Bearing'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Independent At Home',
                                                                                inputValue: 'Independent At Home'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Crutches',
                                                                                inputValue: 'Crutches'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Cane',
                                                                                inputValue: 'Cane'
                                                                            },                                                                        
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Wheelchair',
                                                                                inputValue: 'Wheelchair'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                flex: 1,
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'Walker',
                                                                                inputValue: 'Walker'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                flex: 1,
                                                                                name: 'activities_permitted',
                                                                                boxLabel: 'No Restrictions',
                                                                                inputValue: 'No Restrictions'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        name: 'other_activities_permitted',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                xtype: 'fieldset',
                                                                flex: 1,
                                                                margin: '3px',
                                                                title: 'Mental Status',
                                                                items: [
                                                                    {
                                                                        xtype: 'checkboxgroup',
                                                                        layout: {
                                                                            align: 'stretch',
                                                                            type: 'vbox'
                                                                        },
                                                                        fieldLabel: '',
                                                                        items: [
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Oriented',
                                                                                inputValue: 'Oriented'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Comatose',
                                                                                inputValue: 'Comatose'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Forgetful',
                                                                                inputValue: 'Forgetful'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Depressed',
                                                                                inputValue: 'Depressed'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Disoriented',
                                                                                inputValue: 'Disoriented'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Lethargic',
                                                                                inputValue: 'Lethargic'
                                                                            },
                                                                            {
                                                                                xtype: 'checkboxfield',
                                                                                name: 'mental_status',
                                                                                boxLabel: 'Agitated',
                                                                                inputValue: 'Agitated'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '3px',
                                                                        name: 'mental_status_other1',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    },
                                                                    {
                                                                        xtype: 'textfield',
                                                                        margin: '3px',
                                                                        name: 'mental_status_other2',
                                                                        fieldLabel: 'Other',
                                                                        labelWidth: 40
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    },
                                                    {
                                                        xtype: 'panel',
                                                        border: 0,
                                                        padding: '3px',
                                                        layout: {
                                                            align: 'stretch',
                                                            type: 'hbox'
                                                        },
                                                        items: [
                                                            {
                                                                xtype: 'panel',
                                                                flex: 1,
                                                                border: 0,
                                                                height: 560,
                                                                margin: '2px 2px 0px 2px',
                                                                padding: '3px',
                                                                autoScroll: false,
                                                                layout: {
                                                                    type: 'vbox'
                                                                },
                                                                items: [
                                                                    {
                                                                        xtype: 'radiogroup',
                                                                        height: 34,
                                                                        width: 649,
                                                                        layout: {
                                                                            align: 'middle',
                                                                            type: 'hbox'
                                                                        },
                                                                        fieldLabel: 'Prognosis',
                                                                        labelAlign: 'right',
                                                                        items: [
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.1,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Poor ',
                                                                                checked: true,
                                                                                inputValue: 'Poor'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.15,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Guarded ',
                                                                                inputValue: 'Guarded'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.1,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Fair ',
                                                                                inputValue: 'Fair'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.1,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Good ',
                                                                                inputValue: 'Good'
                                                                            },
                                                                            {
                                                                                xtype: 'radiofield',
                                                                                flex: 0.15,
                                                                                name: 'prognosis',
                                                                                boxLabel: 'Excellent ',
                                                                                inputValue: 'Excellent'
                                                                            }
                                                                        ]
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        margin: '3px',
                                                                        padding: ' ',
                                                                        name: 'nutritional_req',
                                                                        fieldLabel: 'Nutritional Req.  ',
                                                                        labelAlign: 'top',
                                                                        cols: 100
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        margin: '3px',
                                                                        name: 'allergies',
                                                                        fieldLabel: 'Allergies ',
                                                                        labelAlign: 'top',
                                                                        cols: 100
                                                                    },
                                                                    {
                                                                        xtype: 'textareafield',
                                                                        height: 159,
                                                                        margin: '3px',
                                                                        name: 'safety_measures',
                                                                        fieldLabel: 'Safety Measures',
                                                                        labelAlign: 'top',
                                                                        cols: 100
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '3px',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Orders',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                margin: '7px',
                                                layout: {
                                                    type: 'vbox'
                                                },
                                                items: [
                                                    {
                                                    xtype: 'label',
                                                    margin: '4px',
                                                    text: 'Orders for Discipline and Treatments (Specify Amount/Frequency/Duration)'
                                                     },
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '4px',
                                                        name: 'orders',
                                                        fieldLabel: 'Orders ',
                                                        labelAlign: 'top',
                                                        cols: 120,
                                                        height: 500
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '3px',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Goals',
                                        items: [
                                            {
                                                xtype: 'panel',
                                                border: 0,
                                                margin: '7px',
                                                layout: {
                                                    type: 'vbox'
                                                },
                                            items:[
                                                    {
                                                        xtype: 'label',
                                                        margin: '4px',
                                                        text: 'Goals/Rehabilitation Potential Discharge Plans',
                                                    },
                                                    {
                                                        xtype: 'textareafield',
                                                        margin: '4px',
                                                        name: 'goals',
                                                        fieldLabel: 'Goals',
                                                        labelAlign: 'top',
                                                        cols: 120,
                                                        height: 500
                                                    }
                                                ]
                                            }
                                        ]
                                    },
                                    {
                                        xtype: 'panel',
                                        margin: '3px',
                                        layout: {
                                            type: 'fit'
                                        },
                                        title: 'Miscellaneous',
                                        items: [
                                            {
                                                 xtype: 'panel',
                                                 border: 0,
                                                 margin: '7px',
                                                 layout: {
                                                     type: 'vbox'
                                                 },
                                                 items:[
                                                     {
                                                        xtype: 'textareafield',
                                                        margin: '4px',
                                                        name: 'miscellaneous',
                                                        fieldLabel: 'Miscellaneous',
                                                        labelAlign: 'top',
                                                        cols: 120,
                                                        height: 500
                                                     }
                                                ]
                                            }
                                        ]
                                    }]
                            }
                        ]
                    }
                ]
            }
        ]
    )
  end

  def get_combobox_options_endpoint(params)
    PlanOfCare.netzke_combo_options_for(params["column"], {query: params["query"]})
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var refreshButton = this.down('[name=refresh_poc_diagnoses]');
      var recordId = this.record.id;
      refreshButton.on("click", function() {
        this.checkPocDiagnosesWithOasis({record_id: recordId, treatment_episode_id: this.record.treatment_episode_id},
        function(res){
          Ext.each(res, function(r){
              principalIcd = this.down('[name=principal_icd'+r.icdNumber+']');
              principalDate = this.down('[name=principal_date'+r.icdNumber+']');
              principalOe = this.down('[name=principal_oe'+r.icdNumber+']');
              if(principalIcd && principalIcd.hidden == false){
                principalIcd.triggerAction = 'query';
                principalIcd.store.load({params: {query: r.icdValue}});
                principalIcd.setValue(r.icdValue);
              }
              if(principalDate){
                principalDate.setValue('');
              }
              if(principalOe){
                principalOe.setValue('');
              }
          }, this);
        }, this);
      }, this);
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      for(var i=1; i<=6; i++){
        var principalIcd = this.down('[name=principal_icd'+i+']');
        if(principalIcd.hidden == false){
          principalIcd.on("keydown",this.disablePasteFromKeyboard);
          principalIcd.getEl().on("paste",this.disablePasteFromMouse);
        }
        var principalIcd10 = this.down('[name=principal_icd10_'+i+']')
        if(principalIcd10.hidden == false){
          principalIcd10.on("keydown",this.disablePasteFromKeyboard);
          principalIcd10.getEl().on("paste",this.disablePasteFromMouse);
        }
      }
    }
    JS

  js_method :disable_paste_from_keyboard, <<-JS
    function(field, event){
      var keyCode = event.getKey();
      if((event.ctrlKey) && (keyCode == 86)){
          Ext.MessageBox.alert('Message', 'Please click the "Import from OASIS" button to import Diagnosis from the previous OASIS');
          event.stopEvent();
        }
    }
  JS

  js_method :disable_paste_from_mouse, <<-JS
    function(event, field){
      var w = new Ext.window.Window({
        width: 579,
        height: 128,
        bbar: false,
        fbar: false,
        modal: true,
        border: false,
        layout:'fit',
        title: "Message",
        html: '<div style="overflow: hidden; padding: 10px; margin: 0px; right: auto; left: 0px; top: 0px;">' +
            '<div class="x-form-display-field">Please click the "Import from OASIS" button to import Diagnosis' +
            'from the previous OASIS</div></div>',
        buttonAlign: 'center',
        buttons:[{
                text: 'OK',
                listeners: {
                    click: function() {w.close(); }
                    }
        }],
        alwaysOnTop: true
        });
        w.show();
        event.stopEvent();
    }
  JS

    endpoint :check_poc_diagnoses_with_oasis do |params|
    oasis_diagnoses =  if params[:record_id].present?
            poc = PlanOfCare.find(params[:record_id])
            poc.poc_diagnoses(poc.treatment, poc.treatment_episode)
        else
            treatment_episode = TreatmentEpisode.find(params[:treatment_episode_id])
            treatment = treatment_episode.treatment
            poc = PlanOfCare.new
            poc.poc_diagnoses(treatment, treatment_episode)
        end
    {set_result: oasis_diagnoses}
  end
 end
