class FieldStaffForm < Mahaswami::FormPanel

  def configuration
    c = super
    c.merge(
        model: "FieldStaff",
        :cityStatePrefill => true,
        items: [
            {

                border: false,
                :margin => '0 0 5px 20px',
                items: [
                    {
                        border: false,
                        layout: :hbox,


                        style: 'text-align: right; margin: "5px";',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :first_name, field_label: 'Name', item_id: :first_name, emptyText: 'First Name', allow_blank: false, label_width: 70, flex: 5},
                            {name: :last_name, field_label: ' ', item_id: :last_name, label_separator: '',  label_width: 5, emptyText: 'Last Name', allow_blank: false, flex: 4},
                        ]
                    },
                    {
                        header: false,
                        border: false,
                        layout: :hbox,
                        style: 'text-align: right; margin: 0 0 0 5px;',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [{name: :street_address, field_label: 'Address', emptyText: 'Street Address', flex: 4, label_width: 65, margin: "0 5px 0 0"},
                                {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 1}
                        ]
                    },
                    {
                        border: false,
                        layout: :hbox,
                        style: 'text-align: right; margin: 0 0 0 5px',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :zip_code, field_label: 'Location', allow_blank: false,  flex: 1, emptyText: 'ZIP Code', label_width: 65, margin: "0 5px 0 0"},
                            {name: :city, field_label: '', flex: 1, emptyText: 'City', label_width: 65, margin: "0 5px 0 0"},
                            {name: :state, field_label: '', xtype: 'combo', flex: 1, emptyText: 'State', label_width: 65,
                             store: State.all.collect{|x|[x.state_code, x.state_description]}},
                        ]
                    },
                    {
                        border: false,
                        layout: :hbox,
                        style: 'text-align: right; margin: 0 0 0 5px;',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :email, field_label: 'Contact', allow_blank: false, emptyText: 'Email', flex: 2, label_width: 65,  margin: "0 5px 0 0"},
                            {name: :phone_number, field_label: '', flex: 1, label_width: 65, emptyText: "Phone Number 1", input_mask: '(999) 999-9999',  margin: "0 5px 0 0"},
                            {name: :phone_number_2, field_label: '', flex: 1, label_width: 65, emptyText: 'Phone Number 2', input_mask: '(999) 999-9999', margin: "0 5px 0 0"},
                            {name: :fax_number, field_label: '', flex: 1,  label_width: 70, input_mask: '(999) 999-9999', emptyText: 'Fax Number', label_separator: ''},
                        ]
                    },
                    {

                        border: false,
                        layout: :hbox,

                        style: 'text-align: right; margin: "5px";',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :password, inputType: 'password', field_label: 'Password', emptyText: 'Password', allow_blank: false, label_width: 70, flex: 5},
                            {name: :password_confirmation, inputType: 'password', field_label: ' ', label_separator: '',  label_width: 5, emptyText: 'Confirm password', allow_blank: false, flex: 4},
                        ]
                    },
                    {
                        border: false,
                        layout: :hbox,
                        style: 'text-align: right; margin: 0 0 10px 5px',
                        bodyStyle: 'padding-top: 10px; padding-right: 30px',
                        items: [
                            {name: :gender, field_label: 'Details', mode: 'local', store: User::GENDERS, xtype: :combo, editable: false, flex: 1, emptyText: 'Gender', label_width: 65, margin: "0 5px 0 0"},
                            {name: :license_number, field_label: '', flex: 1, emptyText: 'License Number', label_width: 65, margin: "0 5px 0 0"},
                            {name: :license_type__license_type_description, flex: 1, field_label: ' ', label_separator: '', emptyText: 'License Type ', allow_blank: false, label_width: 5},
                        ]
                    }
                ]},
            :languages.component
        ]
    )
  end

  component :languages do
    {
        class_name: "Mahaswami::HasAndBelongsToManyInput",
        record: record,
        columns: 3,
        label_width: 63,
        margin: '0 0 10px 25px',
        association: :languages,
        scope: :sort_ascending
    }
  end

end