class ConsltngCompnyProf < Mahaswami::Panel

  def configuration
    c = super
    user = User.current.full_name
    org = User.current.orgs.first  # consultant belongs to only one organization
    c.merge(
        border: false,
        header: false,
        frame: false,
        margin: 5,
        model: "ConsultingCompany",
        bbar: false,
        items: [
            {xtype: 'fieldset',
             border: false,
             title: '',
             layout: {
                 type: 'fit',
             },
             width: "98%",
             items: [
                 {
                     width: "50%",
                     border: false,
                     componentCls: 'consultant-profile-bottom-border',
                     layout: :hbox,
                     items: [
                         {xtype: 'displayfield', labelStyle: 'font-weight:bold', name: :org_name, field_label: "Company" , label_width: 65,  margin: "0 5px 0 0", value: org.org_name, label_separator: '', flex: 1},
                         {xtype: 'displayfield', labelStyle: 'font-weight:bold', name: :org_user, field_label: "Contact", label_width: 65,  margin: "0 5px 0 0", value: user, label_separator: '', flex: 1},
                         {
                             xtype: 'checkboxgroup',
                             field_label: '',
                             label_align: "right",
                             width: 300,
                             flex: 1.15,
                             columns: 4,
                             items: [
                                 { boxLabel: 'Admin', item_id: 'active', xtype: :checkbox, input_value: "admin",readOnly: true },
                                 { boxLabel: 'Billing', item_id: 'pending', xtype: :checkbox, checked: true, input_value: "billing", readOnly: true},
                                 { boxLabel: 'HR', item_id: 'na', xtype: :checkbox, input_value: "hr", readOnly: true},
                                 { boxLabel: 'QA', item_id: 'discharge', xtype: :checkbox, input_value: "qa", editable: false, readOnly: true},
                             ]
                         },
                     ]
                 },
                 {
                     width: "50%",
                     border: false,
                     componentCls: 'consultant-profile-bottom-border',
                     layout: :hbox,
                     items: [
                         {xtype: 'displayfield', labelStyle: 'font-weight:bold', name: :phone_number, field_label: 'Phone', input_mask: '(999) 999-9999', label_separator: '', flex: 1 , label_width: 65, margin: "0 5px 0 0", value: org.phone_number},
                         {xtype: 'displayfield', labelStyle: 'font-weight:bold', name: :fax_number, field_label: 'Fax', input_mask: '(999) 999-9999', label_separator: '', flex: 0.8, label_width: 60, margin: "0 5px 0 0", value: org.fax_number},
                         {xtype: 'displayfield', labelStyle: 'font-weight:bold', name: :email, field_label: 'Email', label_separator: '', flex: 1, label_width: 65, margin: "0 5px 0 5px", value: org.email},
                         {xtype: 'displayfield', labelStyle: 'font-weight:bold', name: :fed_tax_number, field_label: 'Tax ID', label_separator: '', flex: 1, label_width: 65, margin: "0 5px 0 5px", value: "#{org.fed_tax_number[0..1]}-#{org.fed_tax_number[2..-1]}"},

                     ]
                 },
                 {
                     width: "50%",
                     border: false,
                     componentCls: 'consultant-profile-bottom-border',
                     layout: :hbox,
                     items: [
                         {xtype: 'displayfield', name: :street_address, labelStyle: 'font-weight:bold', field_label: 'Address', emptyText: 'Street Address', flex: 1.85, label_separator: '', label_width: 65, margin: "0 5px 0 0", value: org.street_address},
                         {xtype: 'displayfield', name: :suite_number, field_label: 'Suite', labelStyle: 'font-weight:bold', emptyText: 'Suite #', label_width: 65, flex: 0.91, label_separator: '', value: org.suite_number},
                         {xtype: 'displayfield', name: :zip_code, field_label: 'Zip', flex: 1, labelStyle: 'font-weight:bold', label_separator: '', emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0", value: org.zip_code},
                         {xtype: 'displayfield', name: :city, field_label: 'City', labelStyle: 'font-weight:bold', label_separator: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0", value: org.city},
                         {xtype: 'displayfield', name: :state, field_label: 'State', labelStyle: 'font-weight:bold', label_separator: '', flex: 1, emptyText: 'State', label_width: 50, value: org.state}
                     ]
                 },

             ]},
        ]
    )
  end
end
