class AdhocLiteFieldStaffFormPanel < Mahaswami::FormPanel
  def configuration
    c = super
    c.merge(
        :model => "LiteFieldStaff",
        :persistent_config => c[:persistent_config],
        :strong_default_attrs => c[:strong_default_attrs],
        :border => true,
        :bbar => false,
        :prevent_header => true,
        :item_id => :lite_field_staff_form,
        :mode => c[:mode],
        items: [
            {name: :first_name, editable: false, field_label: "First Name"},
            {name: :last_name, editable: false, field_label: "Last Name"},
            {name: :license_number, field_label: "License Number"},
            {name: :license_type__license_type_description, field_label: "License Type", editable: false}

        ]
    )
  end

  def netzke_submit_endpoint(params)
    result = super
    session[:recently_created_lite_user_id] = result[:set_form_values]["id"]
    result
  end

end
