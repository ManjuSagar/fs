class NewOrgForm < Mahaswami::FormPanel
  def configuration
    super.merge(
        model: "Org",
        cityStatePrefill: true,
        items: [{
                    title: "Details",
                    border: false,
                    layout: :hbox,

                    style: 'text-align: right; margin: 10px;',
                    bodyStyle: 'padding-top: 10px',
                    items: [
                        {name: :org_name, field_label: 'Name', width: "60%"}
                    ]
                },{
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px;',
                    items: [
                        {
                            xtype: 'combo',
                            name: :org_type,
                            item_id: :org_types,
                            field_label: 'Type',
                            store: Org::ORG_TYPES,
                            width: "30%"
                        },{
                            xtype: 'combo',
                            name: :org_package,
                            field_label: 'Package',
                            store: Org::ORG_PACKAGES
                        },{
                            name: :week_start_day,
                            xtype: 'combo',
                            store: Org::WEEK_DAYS,
                            field_label: 'Week Start Day',
                            width: "30%"
                        }]
                },{
                    title: "Contact Details",
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    bodyStyle: 'padding-top: 10px',
                    items: [{name: :street_address, field_label: 'Street Address'},
                            {name: :suite_number, field_label: 'Suite #'}
                    ]
                },{
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    items: [:nine_digit_zip_code.component,
                            :city,
                            {name: :state,
                             xtype: 'combo',
                             store: State.all.collect{|x|[x.state_code, x.state_description]},
                             field_label: 'State',
                             width: "30%"}
                    ]
                },{
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    items: [
                        {name: :phone_number, field_label: "Phone Number", input_mask: '(999) 999-9999'},
                        {name: :fax_number, field_label: "Fax Number", input_mask: '(999) 999-9999'}
                    ]
                },{
                    title: "Preferred Alert Mode",
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    bodyStyle: 'padding-top: 10px',
                    items: [
                        {name: :email, vtype: 'email'},
                        {xtype: 'combobox',
                         name: :preferred_alert_mode,
                         field_label: 'Preferred Alert Mode',
                         store: HealthAgency::ALERT_MODES,
                         editable: false,
                         width: "30%"
                        }]
                },{
                    title: "Other Information",
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px;',
                    bodyStyle: 'padding-top: 10px',
                    items: [
                        {name: :fed_tax_number, field_label: "Fed Tax #", input_mask: '999999999'},
                        {name: :branch_id, field_label: "Branch Id"}
                    ]
                },{
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    items: [{name: :notes, width:"50%"}]
                },{
                    title: "Primary Contact & Admin User Information",
                    width: "70%",
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    bodyStyle: 'padding-top: 10px',
                    items: [
                        {name: :primary_contact_first_name, field_label: "First Name", allow_blank: false},
                        {name: :primary_contact_last_name, field_label: "Last Name", allow_blank: false},
                        {name: :primary_contact_email, field_label: "Email", allow_blank: false}
                    ]
                },{
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    items: [
                        {name: :primary_contact_phone_number, field_label: "Phone Number", input_mask: '(999) 999-9999', allow_blank: false},
                        {name: :primary_contact_extension, field_label: "Extn."},
                    ]
                },{
                    border: false,
                    layout: :hbox,
                    style: 'text-align: right; margin: 10px',
                    items: [
                        {name: :primary_contact_password, field_label: "Password", inputType: "password", allow_blank: false},
                        {name: :primary_contact_password_confirmation, field_label: "Confirm Password", inputType: "password", allow_blank: false},
                    ]
                }
        ]
    )
  end

  component :nine_digit_zip_code do
    {
    class_name: 'NineDigitZipCode',
        header: false,
        border: false
    }
  end

end

