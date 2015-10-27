class OrgForm < Mahaswami::FormPanel
	def configuration
    c = super
    component_session[:org_id] = c[:record_id] if c[:record_id]
		c.merge(
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
              },
              #:mylist.component(
              #    class_name: "Mahaswami::CollectionList",
              #    association: "contacts",
              #    parent_model: "Org",
              #    parent_id: component_session[:org_id]
              #),
              :details.component(
                  :name => :details,
                  :title => "Other Details",
                  :height => 300,
                  :class_name => "Netzke::Basepack::TabPanel",
                  :items => [:contacts.component(
                                 class_name: "Mahaswami::HasManyCollectionList",
                                 association: "contacts",
                                 parent_model: "Org",
                                 bbar: [:add_in_form.action, :edit_in_form.action, :del.action],
                                 context_menu: [:add_in_form.action, :edit_in_form.action, :del.action],
                                 parent_id: component_session[:org_id],
                                 columns: [
                                     {name: :contact_first_name, header: 'First Name', editable: false},
                                     {name: :contact_last_name, header: 'Last Name', editable: false, allow_blank: false},
                                     {name: :phone_number, header: 'Phone Number', input_mask: '(999) 999-9999', width: "20%", editable: false, getter: lambda {|r| "(#{r.extension})-#{r.phone_number}"}},
                                     {name: :email, editable: false, width: "20%"}
                                 ]
                             ),
                             :userlist.component(:class_name => "OrganizationUsersList",
                                                 :scope => ["id in (select user_id from org_users where org_id = ?)", component_session[:org_id]],
                                                 bbar: [:add_in_form.action, :edit_in_form.action, :del.action],
                                                 context_menu: [:add_in_form.action, :edit_in_form.action, :del.action],
                                                 org_id: component_session[:org_id],
                                                 facility_owner_login: true,
                                                 :strong_default_attrs => {:org_id => component_session[:org_id]}
                             )],
                  :width => 700,
                  :border => true,
                  :active_tab => 0
              )
    ]
		)
  end

  component :nine_digit_zip_code do
    {
        class_name: 'NineDigitZipCode',
        header: false,
        border: false,
        org_type: 'StaffingCompany'
    }
  end

end

