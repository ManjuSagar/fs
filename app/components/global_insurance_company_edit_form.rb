class GlobalInsuranceCompanyEditForm < Mahaswami::FormPanel
  def configuration
    s = super
    s.merge(
        model: 'InsuranceCompany',
        title: 'Insurance Company Details',
        width: 150,
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
                            {name: :company_name, field_label: 'Company', item_id: :coy_name, emptyText: 'Name', allow_blank: false, label_width: 70, flex: 3, margin: "0 5px 0 0"},
                            {name: :company_code, field_label: '', emptyText: 'Code', flex: 1}
                        ]
                    },
                    {
                        border: false,
                        layout: :hbox,

                        style: 'text-align: right; margin: "5px";',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :claim_street_address, field_label: 'Address', allow_blank: false, item_id: :street_address, emptyText: 'Street Address', label_width: 70, flex: 3, margin: "0 5px 0 0"},
                            {name: :claim_suite_number, field_label: '', emptyText: 'Suite #', flex: 1},
                        ]
                    },
                    {
                        border: false,
                        layout: :hbox,
                        style: 'text-align: right; margin: 0 0 0 5px',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :claim_zip_code, field_label: 'Location', flex: 1, emptyText: 'ZIP Code', allow_blank: false, label_width: 65, margin: "0 5px 0 0"},
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
                            {name: :claim_phone_number, field_label: 'Contact', input_mask: '(999) 999-9999', emptyText: 'Claim Phone Number',  label_width: 70, margin: "0 5px 0 0", flex: 1},
                            {name: :authorization_phone_number, field_label: '', input_mask: '(999) 999-9999', emptyText: 'Authorization Phone Number', flex: 1,},
                        ]
                    },
                    {
                        border: false,
                        layout: :hbox,

                        style: 'text-align: right; margin: "5px";',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {xtype: "numberfield", name: :certification_period, field_label: 'Cert Period', item_id: :cert_period, label_width: 70, margin: "0 5px 0 0", minValue: 0,  flex: 0.6},
                            {name: :co_pay_applicable, field_label: 'Copay Applicable', flex: 0.7},
                        ]
                    },



                ]
            }
        ]
    )

  end

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