class  Documents::Oasis::WoundCarePlanPoc < Mahaswami::SubPanel

  def configuration
    c = super
    @record_id = c[:record_id] if c[:record_id]
    @document = OasisEvaluation.find(@record_id) if @record_id
    c.merge(
        autoScroll: true,
        header: false,
        title: false,
        wound_panel_next_seq: wound_panel_next_seq,
        items: [
            {
                xtype: 'panel',
                border: 0,
                itemId: 'wound',
                layout: {
                    align: 'stretch',
                    type: 'vbox'
                },
                items: [
                    {
                        xtype: 'patientPrimaryWoundType'
                    },
                    {
                        xtype: "patientWoundType"
                    }
                ]  + wound_types(c[:record_id])
            },
            {
                xtype: 'panel',
                border: 0,
                height: 22,
                items: [
                    {
                        xtype: 'numberfield',
                        hidden: true,
                        itemId: 'total_wound_panels',
                        name: 'total_wound_panels',
                        value: 0,
                        fieldLabel: '',
                        minValue: 0
                    },
                    {
                        xtype: 'button',
                        itemId: 'add_wound_button',
                        text: 'Click to Add Wound Description'
                    }
                ]
            }
        ])
  end

  def wound_type_panel(wound_number)
    {
        xtype: 'panel',
        height: 615,
        itemId: "wound_description_#{wound_number}",
        margin: '3px',
        border: 0,
        layout: {
            align: 'stretch',
            type: 'vbox'
        },
        title: "Wound Description #{wound_number}",
        items: [
            {
                xtype: 'panel',
                border: 0,
                margin: '0 3 3 0',
                layout: {
                    align: 'middle',
                    type: 'hbox'
                },
                items: [
                    {
                        xtype: 'textfield',
                        name: "wound_type_#{wound_number}",
                        margin: '5px',
                        fieldLabel: 'Wound Type:',
                        labelAlign: 'right'
                    },
                    {
                        xtype: 'numberfield',
                        name: "wound_age_#{wound_number}",
                        fieldLabel: 'Age in Months:',
                        labelAlign: 'right',
                        maxValue: 1200,
                        minValue: 1
                    },
                    {
                        xtype: 'textfield',
                        name: "wound_location_#{wound_number}",
                        fieldLabel: 'Wound Location:',
                        labelAlign: 'right'
                    }
                ]
            },
            {
                xtype: 'panel',
                flex: 3,
                border: 0,
                height: 236,
                layout: {
                    align: 'stretch',
                    type: 'hbox'
                },
                items: [
                    {
                        xtype: 'fieldset',
                        flex: 1,
                        margin: 3,
                        items: [
                            {
                                xtype: 'radiogroup',
                                fieldLabel: 'Is there eschar tissue present in the wound?',
                                labelAlign: 'top',
                                labelSeparator: ' ',
                                items: [
                                    {
                                        xtype: 'radiofield',
                                        margin: '0 20px',
                                        name: "wound_tissue_present_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_tissue_present_#{wound_number}",
                                        boxLabel: 'No',
                                        inputValue: 'no'
                                    }
                                ]
                            },
                            {
                                xtype: 'radiogroup',
                                fieldLabel: 'Has debridement been attempted in the last 10 days?',
                                labelAlign: 'top',
                                labelSeparator: ' ',
                                items: [
                                    {
                                        xtype: 'radiofield',
                                        margin: '0 20px',
                                        name: "wound_debridement_attempted_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_debridement_attempted_#{wound_number}",
                                        boxLabel: 'No',
                                        inputValue: 'no'
                                    }
                                ]
                            },
                            {
                                xtype: 'datefield',
                                width: 180,
                                name: "wound_debridement_date_#{wound_number}",
                                fieldLabel: 'If Yes, debridement date',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                width: 161,
                                name: "wound_debridement_type_#{wound_number}",
                                fieldLabel: 'Debridement Type',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'radiogroup',
                                height: 43,
                                fieldLabel: 'Are serial debridements required?',
                                labelAlign: 'top',
                                labelSeparator: ' ',
                                items: [
                                    {
                                        xtype: 'radiofield',
                                        margin: '0 20px',
                                        name: "wound_debridement_required_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_debridement_required_#{wound_number}",
                                        boxLabel: 'No',
                                        inputValue: 'no'
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        flex: 1,
                        margin: 3,
                        items: [
                            {
                                xtype: 'datefield',
                                name: "wound_measurement_date_#{wound_number}",
                                fieldLabel: 'Measurement date:',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_length_#{wound_number}",
                                fieldLabel: 'Length (cm)',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_width_#{wound_number}",
                                fieldLabel: 'Width (cm)',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_depth_#{wound_number}",
                                fieldLabel: 'Depth',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'textfield',
                                name: "wound_appearance_of_wound_#{wound_number}",
                                fieldLabel: 'Appearance of wound bed and color:',
                                labelAlign: 'top'
                            }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        flex: 1,
                        margin: 3,
                        title: '',
                        items: [
                            {
                                xtype: 'textfield',
                                name: "wound_exudate_#{wound_number}",
                                fieldLabel: 'Exudate (amount and color):',
                                labelAlign: 'top'
                            },
                            {
                                xtype: 'radiogroup',
                                fieldLabel: 'Is the wound full thickness?',
                                labelAlign: 'top',
                                labelSeparator: ' ',
                                items: [
                                    {
                                        xtype: 'radiofield',
                                        margin: '0 20px',
                                        name: "wound_thickness_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_thickness_#{wound_number}",
                                        boxLabel: 'No',
                                        inputValue: 'no'
                                    }
                                ]
                            },
                            {
                                xtype: 'radiogroup',
                                fieldLabel: 'Is muscle, tendon or bone exposed?',
                                labelAlign: 'top',
                                labelSeparator: ' ',
                                items: [
                                    {
                                        xtype: 'radiofield',
                                        margin: '0 20px',
                                        name: "wound_muscle_#{wound_number}",
                                        boxLabel: 'Yes',
                                        inputValue: 'yes'
                                    },
                                    {
                                        xtype: 'radiofield',
                                        name: "wound_muscle_#{wound_number}",
                                        boxLabel: 'No',
                                        inputValue: 'no'
                                    }
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                xtype: 'fieldset',
                flex: 1.3,
                height: 121,
                margin: 3,
                layout: {
                    type: 'vbox'
                },
                items: [
                    {
                        xtype: 'radiogroup',
                        flex: 1,
                        width: 400,
                        fieldLabel: 'Is there undermining?',
                        labelAlign: 'top',
                        labelSeparator: ' ',
                        items: [
                            {
                                xtype: 'radiofield',
                                margin: '0 20px',
                                name: "wound_underminig_#{wound_number}",
                                boxLabel: 'Yes',
                                inputValue: 'yes'
                            },
                            {
                                xtype: 'radiofield',
                                name: "wound_underminig_#{wound_number}",
                                boxLabel: 'No',
                                inputValue: 'no'
                            }
                        ]
                    },
                    {
                        xtype: 'panel',
                        flex: 0.8,
                        border: 0,
                        layout: {
                            align: 'middle',
                            type: 'hbox'
                        },
                        items: [
                            {
                                xtype: 'textfield',
                                name: "wound_undermining_location1_#{wound_number}",
                                fieldLabel: 'Location #1 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_from1_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_to1_#{wound_number}",
                                fieldLabel: 'To',
                                labelAlign: 'right'
                            }
                        ]
                    },
                    {
                        xtype: 'panel',
                        flex: 0.8,
                        border: 0,
                        layout: {
                            align: 'middle',
                            type: 'hbox'
                        },
                        items: [
                            {
                                xtype: 'textfield',
                                name: "wound_undermining_location2_#{wound_number}",
                                fieldLabel: 'Location #2 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_from2_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_undermining_to2_#{wound_number}",
                                fieldLabel: 'To',
                                labelAlign: 'right'
                            }
                        ]
                    }
                ]
            },
            {
                xtype: 'fieldset',
                flex: 1.3,
                height: 125,
                margin: 3,
                layout: {
                    type: 'vbox'
                },
                items: [
                    {
                        xtype: 'radiogroup',
                        flex: 1,
                        width: 400,
                        fieldLabel: 'Is there tunneling/sinus?',
                        labelAlign: 'top',
                        labelSeparator: ' ',
                        items: [
                            {
                                xtype: 'radiofield',
                                margin: '0 20px',
                                name: "wound_tunneling_#{wound_number}",
                                boxLabel: 'Yes',
                                inputValue: 'yes'
                            },
                            {
                                xtype: 'radiofield',
                                name: "wound_tunneling_#{wound_number}",
                                boxLabel: 'No',
                                inputValue: 'no'
                            }
                        ]
                    },
                    {
                        xtype: 'panel',
                        flex: 0.8,
                        border: 0,
                        layout: {
                            align: 'middle',
                            type: 'hbox'
                        },
                        items: [
                            {
                                xtype: 'textfield',
                                name: "wound_tunneling_location1_#{wound_number}",
                                fieldLabel: 'Location #1 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_from1_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_to1_#{wound_number}",
                                fieldLabel: 'To',
                                labelAlign: 'right'
                            }
                        ]
                    },
                    {
                        xtype: 'panel',
                        flex: 0.8,
                        border: 0,
                        layout: {
                            align: 'middle',
                            type: 'hbox'
                        },
                        items: [
                            {
                                xtype: 'textfield',
                                name: "wound_tunneling_location2_#{wound_number}",
                                fieldLabel: 'Location #2 (cm)',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_from2_#{wound_number}",
                                fieldLabel: 'From',
                                labelAlign: 'right'
                            },
                            {
                                xtype: 'timefield',
                                name: "wound_tunneling_to2_#{wound_number}",
                                fieldLabel: 'To',
                                labelAlign: 'right'
                            }
                        ]
                    }
                ]
            }
        ],
        tools: [
            {
                xtype: 'tool',
                tooltip: 'close',
                type: 'close'
            }
        ]
    }
  end

  def wound_panel_next_seq
      (wound_panel_indices.sort.last || 0) + 1
  end

  def wound_panel_indices
      if @document
          (1..20).to_a.inject([]) do |result, i|
              if(@document.data.has_key?("wound_type_" + i.to_s))
                  result << i
              end
              result
          end
      else
          []
      end
  end

  def wound_types(record_id)
    wound_type_arr = []
    if record_id
      doc = OasisEvaluation.find(record_id)
      total_wound = doc.total_wound_panels || 0
      wound_panel_indices.each {|i|
          wound_type_arr << wound_type_panel(i)
      }
    end
    wound_type_arr
  end

  def netzke_attributes
    netzke_attrs_in_natural_order
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var form = this;
      var woundDescriptionPanel = this.down('#wound_description_');
      var woundPanel = this.down('#wound');
      woundDescriptionPanel.hide();
      var button = Ext.ComponentQuery.query('#add_wound_button')[0];
      var nextSeqNumber = this.woundPanelNextSeq;
      button.on('click', function(){
        createWoundPanel(woundPanel, woundDescriptionPanel, nextSeqNumber);
        nextSeqNumber = nextSeqNumber + 1;
        var tools = Ext.ComponentQuery.query("tool[tooltip=close]");
        Ext.each(tools, function(tool, index){
          tool.on('click', function(){
            this.up('panel').destroy();
          });
        });
      });
    }
  JS

  js_method :after_render, <<-JS
    function()
    {
      this.callParent();
      var recordId = this.recordId;
      var getComp = this;
      var toolButtons = Ext.ComponentQuery.query("tool[tooltip=close]");
      Ext.each(toolButtons, function(toolButton, index){
        toolButton.on('click', function(){
          var woundPanelItemId =  this.up('panel').getItemId();
            var splitWoundPanelItemId = woundPanelItemId.split("wound_description_");
            var panelNo = parseInt(splitWoundPanelItemId[1]);
            getComp.deleteWoundPanelData({record_id: recordId, panel_no: panelNo},function(result){
              if(result)
              {
                this.up('panel').destroy();
              }
            },this);
        });
      });
    }
  JS

    endpoint :delete_wound_panel_data do |params|
        doc = OasisEvaluation.find(params[:record_id])
        panel_to_delete = params[:panel_no]
        panel_no = panel_to_delete.to_s
        doc_fields_to_delete = ["wound_type_" + panel_no, "wound_age_" + panel_no, "wound_location_" + panel_no,
                                "wound_tissue_present_" + panel_no, "wound_debridement_attempted_" + panel_no, "wound_debridement_date_" + panel_no,
                                "wound_debridement_type_" + panel_no, "wound_debridement_required_" + panel_no, "wound_measurement_date_" + panel_no,
                                "wound_length_" + panel_no, "wound_width_" + panel_no, "wound_depth_" + panel_no, "wound_appearance_of_wound_" + panel_no,
                                "wound_exudate_" + panel_no, "wound_thickness_" + panel_no, "wound_muscle_" + panel_no,
                                "wound_underminig_" + panel_no, "wound_undermining_location1_" + panel_no, "wound_undermining_from1_" + panel_no,
                                "wound_undermining_to1_" + panel_no, "wound_undermining_location2_" + panel_no,
                                "wound_undermining_from2_" + panel_no, "wound_undermining_to2_" + panel_no, "wound_tunneling_" + panel_no,
                                "wound_tunneling_location1_" + panel_no, "wound_tunneling_from1_" + panel_no, "wound_tunneling_to1_" + panel_no,
                                "wound_tunneling_location2_" + panel_no, "wound_tunneling_from2_" + panel_no, "wound_tunneling_to2_" + panel_no]
        doc_fields_to_delete.each do |field|
            doc.data.delete(field)
        end
        doc.save!
        {set_result: true }
    end

end