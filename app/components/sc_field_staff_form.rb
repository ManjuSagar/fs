class ScFieldStaffForm < Mahaswami::FormPanel

  def configuration
    c= super
    c.merge(
        model: "StaffingCompanyUser",
        :persistent_config => c[:persistent_config],
        :strong_default_attrs => c[:strong_default_attrs],
        items: [{name: :first_name, field_label: "First Name", allow_blank: false},
                {name: :last_name, field_label: "Last Name", allow_blank: false},
                {name: :license_number, field_label: "License Number"},
                {name: :license_type_id, field_label: "License Type", editable: false, store: license_types, xtype: 'combo', allow_blank: false}
        ]
    )
  end

  def license_types
     LicenseType.all.collect{|x| [x.id, x.license_type_description]}
  end

end

