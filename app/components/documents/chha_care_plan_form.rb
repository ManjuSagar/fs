class Documents::ChhaCarePlanForm < Documents::AbstractDocumentForm

    def configuration
      c = super
      @prev_eval_document = PatientTreatment.find(c[:treatment_id]).documents.find_all_by_document_type('ChhaCarePlan').last if c[:treatment_id]
      c.merge(
          show_last_evaluation_action: true,
          item_id: "evaluation",
          freeFormTemplate: false,
          model: "ChhaCarePlan",
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
                          xtype: 'borderlessFormPanel',
                          style: 'color:green;',
                          layout: {
                              type: 'border'
                          },
                          bodyPadding: 10,
                          manageHeight: false,
                          title: '',
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
                                          height: 707,
                                          margin: '3px',
                                          layout: {
                                              type: 'anchor'
                                          },
                                          title: 'Activities',
                                          items: [
                                                      {
                                                          xtype: 'panel',
                                                          border: 0,
                                                          layout: {
                                                              align: 'stretch',
                                                              type: 'hbox'
                                                          },
                                                          items: [
                                                              {
                                                                  xtype: 'label',
                                                                  weight: 2,
                                                                  text: 'PRN'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  height: 15,
                                                                  margin: '0 0 0 10px',
                                                                  width: 66,
                                                                  text: 'Q Visit'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  height: 21,
                                                                  width: 108,
                                                                  text: 'Weekly'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  margin: '',
                                                                  width: 283,
                                                                  text: 'ASSIST WITH/PERFORM'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  margin: '0 0 0 10px',
                                                                  text: 'PRN'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  margin: '0 0 0 5px',
                                                                  width: 69,
                                                                  text: 'Q Visit'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  height: 25,
                                                                  width: 79,
                                                                  text: 'Weekly'
                                                              },
                                                              {
                                                                  xtype: 'label',
                                                                  height: 25,
                                                                  width: 295,
                                                                  text: 'ASSIST WITH/PERFORM'
                                                              }
                                                          ]
                                                      },
                                                      {
                                                          xtype: 'panel',
                                                          border: 0,
                                                          layout: {
                                                              align: 'stretch',
                                                              type: 'hbox'
                                                          },
                                                          items: [
                                                              {
                                                                  xtype: 'panel',
                                                                  border: 0,
                                                                  width: 508,
                                                                  layout: {
                                                                      align: 'stretch',
                                                                      type: 'hbox'
                                                                  },
                                                                  items: [
                                                                      {
                                                                          xtype: 'panel',
                                                                          border: 0,
                                                                          height: 492,
                                                                          width: 210,
                                                                          items: [
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  margin: '10px 0 0 0',
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'temp_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'temp_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'temp_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'pulse_rate_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'pulse_rate_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'pulse_rate_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'respiratory_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'respiratory_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'respiratory_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false

                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'blood_pressure_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'blood_pressure_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'blood_pressure_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'toileting_activities_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'toileting_activities_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'toileting_activities_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'shower_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'shower_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'shower_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'tub_bath_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'tub_bath_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'tub_bath_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'bed_bath_partial_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'bed_bath_partial_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'bed_bath_partial_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'bed_bath_complete_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'bed_bath_complete_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'bed_bath_complete_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'bed_bath_sponge_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'bed_bath_sponge_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'bed_bath_sponge_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'deodorant_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'deodorant_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'deodorant_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'dressing_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'dressing_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'dressing_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'denture_care_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'denture_care_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'denture_care_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'oral_care_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'oral_care_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'oral_care_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'hair_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'hair_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'hair_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'shave_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'shave_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'shave_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'makeup_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'makeup_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'makeup_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'nail_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'nail_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'nail_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'foot_care_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'foot_care_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'foot_care_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          flex: 1,
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'skin_care_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 0px',
                                                                                          name: 'skin_care_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 50 0 30px',
                                                                                          width: 82,
                                                                                          name: 'skin_care_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              }
                                                                          ]
                                                                      },
                                                                      {
                                                                          xtype: 'panel',
                                                                          border: 0,
                                                                          height: 639,
                                                                          layout: {
                                                                              align: 'stretch',
                                                                              type: 'vbox'
                                                                          },
                                                                          items: [
                                                                              {
                                                                                  xtype: 'radiogroup',
                                                                                  margins: '10px 0 5px 0',
                                                                                  height: 20,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  fieldLabel: 'Check Temperature',
                                                                                  labelWidth: 120,
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'radiofield',
                                                                                          name: 'temp',
                                                                                          boxLabel: 'Oral',
                                                                                          inputValue: 'Oral'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'radiofield',
                                                                                          margin: '0 2px 0 3px',
                                                                                          name: 'temp',
                                                                                          boxLabel: 'Axiliary',
                                                                                          inputValue: 'Axiliary'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'radiofield',
                                                                                          name: 'temp',
                                                                                          boxLabel: 'Rectal',
                                                                                          inputValue: 'Rectal'
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 20,
                                                                                  text: 'Check Pulse'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 22,
                                                                                  text: 'Check Respiration'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 22,
                                                                                  text: 'Check Blood Pressure'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 22,
                                                                                  text: 'Toileting Activities'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 22,
                                                                                  text: 'Bathing: Shower (please use a shower chair)'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 22,
                                                                                  text: 'Bathing: Tub'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 3px 0',
                                                                                  height: 22,
                                                                                  text: 'Bathing: Bed Partial '
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Bathing: Bed Complete '
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Bathing: Bed Sponge '
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Appling Deodorant'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Dressing and Undressing'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Denture Care'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Brushing Teeth'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Brushing/Combing Hair'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Shaving'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Appling Makeup'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Nail Hygiene'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  width: 269,
                                                                                  text: 'Foot Care'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margins: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Skin Care'
                                                                              }
                                                                          ]
                                                                      }
                                                                  ]
                                                              },
                                                              {
                                                                  xtype: 'panel',
                                                                  border: 0,
                                                                  width: 535,
                                                                  layout: {
                                                                      align: 'stretch',
                                                                      type: 'hbox'
                                                                  },
                                                                  items: [
                                                                      {
                                                                          xtype: 'panel',
                                                                          border: 0,
                                                                          width: 178,
                                                                          items: [
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  margin: '11px 0 0 0',
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'back_rub_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'back_rub_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'back_rub_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      },
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          width: 225,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'grocery_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'grocery_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'grocery_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      },
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'meal_preparation_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'meal_preparation_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'meal_preparation_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'ast_feeding_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'ast_feeding_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'ast_feeding_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      },
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'self_medications_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'self_medications_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'self_medications_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      },
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'cha_bed_linen_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'cha_bed_linen_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'cha_bed_linen_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      },
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          width: 225,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'laundry_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'laundry_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'laundry_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      },
                                                                                      {
                                                                                          xtype: 'panel',
                                                                                          border: 0,
                                                                                          width: 225,
                                                                                          layout: {
                                                                                              align: 'stretch',
                                                                                              type: 'hbox'
                                                                                          },
                                                                                          items: [
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 5px',
                                                                                                  name: 'cln_liv_area_prn',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'checkboxfield',
                                                                                                  margin: '0 0 0 17px',
                                                                                                  name: 'cln_liv_area_qvisit',
                                                                                                  fieldLabel: '',
                                                                                                  boxLabel: ''
                                                                                              },
                                                                                              {
                                                                                                  xtype: 'numberfield',
                                                                                                  margin: '0 25 0 30px',
                                                                                                  width: 82,
                                                                                                  name: 'cln_liv_area_weekly',
                                                                                                  fieldLabel: '',
                                                                                                  labelAlign: 'right',
                                                                                                  minValue: 0,
                                                                                                  hideTrigger: true,
                                                                                                  mouseWheelEnabled: false
                                                                                              }
                                                                                          ]
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'amb_assist_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'amb_assist_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'amb_assist_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  margin: '0 0 0 0',
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'transfers_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'transfers_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'transfers_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'rom_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'rom_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'rom_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 214,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'excercise_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'excercise_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'excercise_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  width: 225,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'positioning_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'positioning_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'positioning_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  margin: '25px 0 0 0 ',
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'infection_control_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'infection_control_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'infection_control_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  margin: '18px 0 0 0 ',
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'clr_path_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'clr_path_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'clr_path_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'othr_text1_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'othr_text1_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'othr_text1_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'othr_text2_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'othr_text2_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'othr_text2_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'othr_text3_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'othr_text3_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'othr_text3_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'othr_text4_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'othr_text4_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'othr_text4_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'panel',
                                                                                  border: 0,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 5px',
                                                                                          name: 'othr_text5_prn',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 17px',
                                                                                          name: 'othr_text5_qvisit',
                                                                                          fieldLabel: '',
                                                                                          boxLabel: ''
                                                                                      },
                                                                                      {
                                                                                          xtype: 'numberfield',
                                                                                          margin: '0 25 0 30px',
                                                                                          width: 82,
                                                                                          name: 'othr_text5_weekly',
                                                                                          fieldLabel: '',
                                                                                          labelAlign: 'right',
                                                                                          minValue: 0,
                                                                                          hideTrigger: true,
                                                                                          mouseWheelEnabled: false
                                                                                      }
                                                                                  ]
                                                                              }
                                                                          ]
                                                                      },
                                                                      {
                                                                          xtype: 'panel',
                                                                          border: 0,
                                                                          height: 639,
                                                                          width: 279,
                                                                          layout: {
                                                                              align: 'stretch',
                                                                              type: 'vbox'
                                                                          },
                                                                          items: [
                                                                              {
                                                                                  xtype: 'label',
                                                                                  height: 22,
                                                                                  margin: '10px 0 3px 0',
                                                                                  text: 'Back Rub'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margin: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Grocery Shopping'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margin: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Meal Preparation'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margin: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Feeding'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margin: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Self-Administaration of Medications'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margin: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Changing Bed Linens'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  margin: '0 0 2px 0',
                                                                                  height: 22,
                                                                                  text: 'Laundry'
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  height: 22,
                                                                                  text: 'Cleaning Living Areas'
                                                                              },
                                                                              {
                                                                                  xtype: 'checkboxgroup',
                                                                                  fieldLabel: 'Amb. Assist',
                                                                                  labelWidth: 80,
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'amb_assist',
                                                                                          boxLabel: 'W/C',
                                                                                          inputValue: 'W/C'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'amb_assist',
                                                                                          boxLabel: 'Walker',
                                                                                          inputValue: 'Walker'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'amb_assist',
                                                                                          boxLabel: 'Cane',
                                                                                          inputValue: 'Cane'
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  height: 18,
                                                                                  text: 'Transfers'
                                                                              },
                                                                              {
                                                                                  xtype: 'checkboxgroup',
                                                                                  height: 18,
                                                                                  fieldLabel: 'ROM',
                                                                                  labelWidth: 50,
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'rom',
                                                                                          boxLabel: 'Active',
                                                                                          inputValue: 'Active'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'rom',
                                                                                          margin: '0 0 4px 0',
                                                                                          boxLabel: 'Passive',
                                                                                          inputValue: 'Passive'
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  height: 19,
                                                                                  width: 315,
                                                                                  margin: '0 0 3px 0',
                                                                                  text: 'PT/OT Ordered Exercises'
                                                                              },
                                                                              {
                                                                                  xtype: 'checkboxgroup',
                                                                                  width: 279,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  fieldLabel: 'Positioning: Turn each hour',
                                                                                  labelAlign: 'top',
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: "position",
                                                                                          boxLabel: 'Encourage',
                                                                                          inputValue: 'Encourage'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 0 0 2px',
                                                                                          name: "position",
                                                                                          boxLabel: 'Assist',
                                                                                          inputValue: 'Assist'
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'checkboxgroup',
                                                                                  height: 40,
                                                                                  width: 276,
                                                                                  layout: {
                                                                                      align: 'stretch',
                                                                                      type: 'hbox'
                                                                                  },
                                                                                  fieldLabel: 'Infection Control',
                                                                                  labelAlign: 'top',
                                                                                  labelPad: 1,
                                                                                  labelWidth: 50,
                                                                                  items: [
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'infection_control',
                                                                                          boxLabel: 'Hand washing ',
                                                                                          inputValue: 'Hand Washing'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          margin: '0 2px 0 2px',
                                                                                          name: 'infection_control',
                                                                                          boxLabel: 'Gloves',
                                                                                          inputValue: 'Gloves'
                                                                                      },
                                                                                      {
                                                                                          xtype: 'checkboxfield',
                                                                                          name: 'infection_control',
                                                                                          boxLabel: 'Mask',
                                                                                          inputValue: 'Mask'
                                                                                      }
                                                                                  ]
                                                                              },
                                                                              {
                                                                                  xtype: 'label',
                                                                                  height: 22,
                                                                                  text: 'Clear Pathways',
                                                                                  margin: "5px 0 0 0"
                                                                              },
                                                                              {
                                                                                  xtype: 'textfield',
                                                                                  margin: '0 100 0 2px',
                                                                                  name: 'other1_text',
                                                                                  fieldLabel: '',
                                                                                  labelAlign: 'right'
                                                                              },
                                                                              {
                                                                                  xtype: 'textfield',
                                                                                  margin: '0 100 0 2px',
                                                                                  name: 'other2_text',
                                                                                  fieldLabel: '',
                                                                                  labelAlign: 'right'
                                                                              },
                                                                              {
                                                                                  xtype: 'textfield',
                                                                                  margin: '0 100 0 2px',
                                                                                  name: 'other3_text',
                                                                                  fieldLabel: '',
                                                                                  labelAlign: 'right'
                                                                              },
                                                                              {
                                                                                  xtype: 'textfield',
                                                                                  margin: '0 100 0 2px',
                                                                                  name: 'other4_text',
                                                                                  fieldLabel: '',
                                                                                  labelAlign: 'right'
                                                                              },
                                                                              {
                                                                                  xtype: 'textfield',
                                                                                  margin: '0 100 0 2px',
                                                                                  name: 'other5_text',
                                                                                  fieldLabel: '',
                                                                                  labelAlign: 'right'
                                                                              }
                                                                          ]
                                                                      }
                                                                  ]
                                                              }
                                                          ]
                                                      }                                                 
                                          ]
                                      }
                                  ]
                              }
                          ]
                      }
                  ]
              }
          ]
      )
    end

    action :previous_evaluation_report, text: "View Last Evaluation"



    js_method :launch_previous_evaluation_report, <<-JS
    function(report_options) {
      var reportUrl = report_options[0];
      reportUrl = window.location.protocol + "//" + window.location.host + reportUrl;
      var reportTitle = report_options[1];
      if (Ext.isGecko) {
        window.location = reportUrl;
      } else {
        Ext.create('Ext.window.Window', {
            width : 800,
            height: 600,
            layout : 'fit',
            title : reportTitle,
            items : [{
                xtype : "component",
                id: 'myIframe1',
                autoEl : {
                    tag : "iframe",
                    href : ""
                }
            }]
        }).show();

        Ext.getDom('myIframe1').src = reportUrl;
      }
    }
  JS


  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var action = this.actions.previousEvaluationReport;
      if (action) {
        this.checkPrevEvalAvailability({}, function(result){
          action.setDisabled((result == 'q'));
        },this);
      }
    }
  JS

  endpoint :check_prev_eval_availability do |params|
    {set_result: (@prev_eval_document.present? ? 'p' : 'q')}
  end

  js_method :on_previous_evaluation_report, <<-JS
    function() {
      this.viewPreviousEvaluationReport();
    }
  JS

  endpoint :view_previous_evaluation_report do |params|
    if @prev_eval_document
      treatment = @prev_eval_document.treatment
      session[:pre_generated_file_name] = @prev_eval_document.combined_reports
      certification_period = @prev_eval_document.treatment_episode
      report_url = "/reports/pre_generated"
      report_title = "Patient : #{treatment.to_s}, Certification Period - #{certification_period}"
      {:launch_previous_evaluation_report => [report_url, report_title]}
    end

  end









end