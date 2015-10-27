class FieldStaffAgenciesInfo < Mahaswami::GridPanel

  def configuration
    c = super
    c.merge(
        model: 'Org',
        title: 'HHAs',
        edit_on_dbl_click: false,
        item_id: :agencies_grid,
        bbar: [],
        columns: [
            {name: :org_name, label: "Agency Name", editable: false, width: "18%", addHeaderFilter: true},
            {name: :email, label: "Email", editable: false, width: "16%"},
            {name: :phone_number, label: "Phone Number", editable: false, width: "12%"},
            {name: :fax_number, label: "Fax Number", editable: false, width: "12%"},
            {name: :street_address, label: "Address", editable: false, width: "16%"},
            {name: :city, label: "City", editable: false, width: "12%"},
            {name: :state, label: "state", editable: false, width: "5%"},
        ],
        scope: :field_staff_scope,
    )
  end
end