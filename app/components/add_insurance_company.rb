class AddInsuranceCompany < Mahaswami::FormPanel

  def configuration
    s = super
    is_bill_type_read_only = if s[:mode] == 'edit'
                      PatientTreatment.ins_scope(s[:record_id]).size >= 1
                    else
                      false
                    end
    component_session[:selected_insurance_company_id] = s[:record_id]
    s.merge(
      notify_on_save: (s[:strong_default_attrs] and (s[:strong_default_attrs][:is_sample_ins] == true)? false : true),
      items: [
          {
              border: false,
              item_id: :add_ins_cmpny,
              :margin => '0 0 5px 10px',
              items: [
                  {
                      border: false,
                      layout: :hbox,

                      style: 'text-align: right; margin: "5px";',
                      bodyStyle: 'padding-top: 10px; padding-right: 30px',
                      items: [
                          {name: :company_name, field_label: 'Company', item_id: :coy_name, emptyText: 'Name', allow_blank: false, label_width: 80, flex: 3, margin: "0 5px 0 0"},
                          {name: :company_code, field_label: '', emptyText: 'Code', flex: 1}
                      ]
                  },
                  {
                      border: false,
                      layout: :hbox,

                      style: 'text-align: right; margin: "5px";',
                      bodyStyle: 'padding-top: 10px; padding-right: 30px',
                      items: [
                          {name: :claim_street_address, field_label: 'Address', allow_blank: false, item_id: :street_address, emptyText: 'Street Address', label_width: 80, flex: 3, margin: "0 5px 0 0"},
                          {name: :claim_suite_number, field_label: '', emptyText: 'Suite #', flex: 1},
                      ]
                  },
                  {
                      border: false,
                      layout: :hbox,
                      style: 'text-align: right; margin: 0 0 0 5px',
                      bodyStyle: 'padding-top: 10px; padding-right: 30px',
                      items: [
                          {name: :claim_zip_code, field_label: 'Location', flex: 1, emptyText: 'ZIP Code', allow_blank: false, label_width: 75, margin: "0 5px 0 0"},
                          {name: :claim_city, field_label: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0"},
                          {name: :claim_state, field_label: '', xtype: 'combo', flex: 1, emptyText: 'State', label_width: 65,
                           store: State.all.collect{|x|[x.state_code, x.state_description]}},
                      ]
                  },
                  {
                      border: false,
                      layout: :hbox,

                      style: 'text-align: right; margin: "5px";',
                      bodyStyle: 'padding-top: 10px; padding-right: 30px',
                      items: [
                          {name: :claim_phone_number, field_label: 'Contact', input_mask: '(999) 999-9999', emptyText: 'Claim Phone Number',  label_width: 80, margin: "0 5px 0 0", flex: 1},
                          {name: :authorization_phone_number, field_label: '', input_mask: '(999) 999-9999', emptyText: 'Authorization Phone Number', flex: 1,},
                      ]
                  },
                  {
                      border: false,
                      layout: :hbox,

                      style: 'text-align: right; margin: "5px";',
                      bodyStyle: 'padding-top: 10px; padding-right: 30px',
                      items: [
                          {xtype: "numberfield", name: :certification_period, field_label: 'Cert Period', item_id: :cert_period, label_width: 80, margin: "0 5px 0 0", minValue: 0, width: '25%'},
                          {name: :co_pay_applicable, field_label: 'Copay Applicable'},
                          {
                              xtype: 'radiogroup',
                              fieldLabel: 'Billing type:',
                              labelSeparator: ' ',
                              layout: {
                                  type: 'hbox',
                                  align: 'stretch'
                              },
                              items: [
                                  {xtype: 'radiofield', name: :billing_flow, checked: true, read_only: is_bill_type_read_only, field_label: '', width: 80, boxLabel: 'HHRG', inputValue: 'H' },
                                  {xtype: 'radiofield', name: :billing_flow, field_label: '', read_only: is_bill_type_read_only, width: 80, boxLabel: 'Visit', inputValue: 'V'}
                              ]
                          },
                      ]
                  },
                  {
                    layout: :hbox,
                    border: false,
                    style: 'text-align: right; margin: "5px";',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [
                          {name: :claim_submission_due_days, field_label: "Billing Due in (days)", label_width: 125, margin: "0 0 5px 0", minValue: 0, flex: 1.1 },
                          {name: :claim_payment_due_days, field_label: "Payment Due in (days)", label_width: 145, margin: "0 0 5px 0", minValue: 0, flex: 1.2},
                          {name: :claim_form_type, field_label: "Form Type", xtype: :combo, store: InsuranceCompany::FORM_TYPES, label_width: 70, editable: false, margin: "0 0 5px 5px", flex: 1}

                    ]

                  },
                  {
                    layout: :hbox,
                    border: false,
                    style: 'text-align: right; margin: "5px";',
                    bodyStyle: 'padding-top: 10px; padding-right: 30px',
                    items: [
                      {name: :payer_id, field_label: "Payer Id", label_width: 80, margin: "0 0 5px 0", item_id: :payer_id, width: "25%"}

                    ]

                  },

                  :details.component

              ]
          }
        ]
    )
  end

  component :details do
    {
        :name => :details,
        :title => "",
        :header => false,
        :height => 290,
        :margin => '0 0 10px 20px',
        :class_name => "Netzke::Basepack::TabPanel",
        :items => [
            :case_managers.component(class_name: "CaseManagers",
                                     association: "insurance_case_managers",
                                     parent_model: "InsuranceCompany",
                                     parent_id: component_session[:selected_insurance_company_id],
                                     insurance_company_id: component_session[:selected_insurance_company_id],
            ),
            :ins_comp_visit_rate_list.component(class_name: "InsCompVisitRateList",
                                                association: "insurance_company_visit_type_rates",
                                                parent_model: "InsuranceCompany",
                                                item_id: :ins_comp_visit_type_rate_grid,
                                                parent_id: component_session[:selected_insurance_company_id],
                                                insurance_company_id: component_session[:selected_insurance_company_id],

            )
        ]
    }
  end

  js_method :on_apply, <<-JS
    function(){
      var insVtRates = this.down('#ins_comp_visit_type_rate_grid');
      insVtRates.onApply();
      this.callParent();
    }
  JS

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      var zipCode = this.down("[name=claim_zip_code]");
      var city = this.down("[name=claim_city]");
      var state = this.down("[name=claim_state]");
      this.autoFillCityStateBasedOnZipcode(city, state, zipCode);
    }
  JS


end